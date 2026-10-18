/* OrcaCAD's mesh fast path: deduplicate the vertices of a binary STL.
 *
 * The Python implementation in openscad/mesh.py stays the reference - it is what
 * the tests compare against and what runs when this library cannot be loaded.
 * This file exists because that loop is the one hot spot that shows on a slow
 * machine: about 2 ms per 1000 triangles in Python, which is a second of the
 * render for a 500k-triangle model.
 *
 * Freestanding on purpose: no libc, no allocation, no platform headers. The
 * caller (Python, via ctypes) owns every buffer, so the same source builds for
 * Linux, Windows and macOS without an SDK and without a runtime to ship.
 *
 * Layout of a binary STL: 80-byte header, uint32 little-endian triangle count,
 * then 50 bytes per triangle (12 normal + 3 * 12 vertex + 2 attribute).
 */
#include <stddef.h>
#include <stdint.h>

#define ORCAD_MESH_ERROR 0xFFFFFFFFu
#define ORCAD_MESH_HEADER 84u
#define ORCAD_MESH_RECORD 50u
#define ORCAD_MESH_SLOT 16u /* 12 key bytes + uint32 (vertex index + 1) */

#if defined(_WIN32)
/* A DLL still needs an entry point, and this library deliberately links no CRT
 * to provide DllMainCRTStartup. Nothing has to happen when it is loaded. */
int __stdcall DllMainCRTStartup(void *instance, unsigned long reason, void *reserved) {
    (void)instance;
    (void)reason;
    (void)reserved;
    return 1;
}
#endif

static uint32_t read_u32(const uint8_t *p) {
    return (uint32_t)p[0] | ((uint32_t)p[1] << 8) | ((uint32_t)p[2] << 16) | ((uint32_t)p[3] << 24);
}

static void write_u32(uint8_t *p, uint32_t value) {
    p[0] = (uint8_t)(value & 0xFFu);
    p[1] = (uint8_t)((value >> 8) & 0xFFu);
    p[2] = (uint8_t)((value >> 16) & 0xFFu);
    p[3] = (uint8_t)((value >> 24) & 0xFFu);
}

/* FNV-1a over the vertex's exact 12 bytes: Python keys the lookup on the bytes
 * too, so -0.0 and 0.0 (or two NaNs with different payloads) stay distinct. */
static uint32_t hash12(const uint8_t *key) {
    uint32_t hash = 2166136261u;
    for (int i = 0; i < 12; i++) {
        hash ^= key[i];
        hash *= 16777619u;
    }
    return hash;
}

/* Triangle count of a well-formed, non-empty binary STL, else 0. */
uint32_t orcad_mesh_triangles(const uint8_t *stl, size_t length) {
    if (stl == NULL || length < ORCAD_MESH_HEADER) return 0;
    uint32_t count = read_u32(stl + 80);
    if (count == 0) return 0;
    if (length < (size_t)ORCAD_MESH_HEADER + (size_t)count * ORCAD_MESH_RECORD) return 0;
    return count;
}

/* Scratch bytes a caller must pass for `triangles` triangles: a hash table with
 * room for the worst case (every triangle contributing three distinct
 * vertices), kept at most three quarters full so the probe chains stay short.
 * A closed mesh is far below that, so the table is usually nearly empty. */
size_t orcad_mesh_scratch(size_t triangles) {
    size_t slots = 16;
    while (slots < triangles * 4) slots <<= 1;
    return slots * ORCAD_MESH_SLOT;
}

/* Writes 3 floats per distinct vertex into `positions` (12 bytes each, in the
 * STL's own little-endian order) and three uint32 indices per triangle into
 * `indices`, and returns the vertex count. Returns ORCAD_MESH_ERROR when the
 * STL does not match `triangles` or the scratch buffer is too small.
 *
 * `scratch` must be zeroed: an empty slot is one whose stored index is 0. */
uint32_t orcad_mesh_index(const uint8_t *stl, size_t length, float *positions, uint32_t *indices,
                          size_t triangles, uint8_t *scratch, size_t scratch_bytes) {
    if (orcad_mesh_triangles(stl, length) != triangles) return ORCAD_MESH_ERROR;
    if (scratch == NULL || positions == NULL || indices == NULL) return ORCAD_MESH_ERROR;
    if (scratch_bytes < orcad_mesh_scratch(triangles)) return ORCAD_MESH_ERROR;
    const size_t slots = scratch_bytes / ORCAD_MESH_SLOT;
    uint8_t *const out = (uint8_t *)positions;
    uint32_t vertices = 0;
    const uint8_t *record = stl + ORCAD_MESH_HEADER;
    for (size_t triangle = 0; triangle < triangles; triangle++, record += ORCAD_MESH_RECORD) {
        for (int corner = 0; corner < 3; corner++) {
            const uint8_t *key = record + 12 + (size_t)corner * 12;
            size_t slot = hash12(key) & (slots - 1);
            size_t probe = 0;
            for (; probe < slots; probe++) {
                uint8_t *entry = scratch + slot * ORCAD_MESH_SLOT;
                uint32_t stored = read_u32(entry + 12);
                if (stored == 0) { /* empty: this vertex is new */
                    __builtin_memcpy(entry, key, 12);
                    write_u32(entry + 12, vertices + 1);
                    __builtin_memcpy(out + (size_t)vertices * 12, key, 12);
                    indices[triangle * 3 + (size_t)corner] = vertices;
                    vertices++;
                    break;
                }
                if (__builtin_memcmp(entry, key, 12) == 0) { /* seen before */
                    indices[triangle * 3 + (size_t)corner] = stored - 1;
                    break;
                }
                slot = (slot + 1) & (slots - 1); /* linear probe */
            }
            /* A full table means the caller sized the scratch for fewer vertices
             * than the model has. Give up instead of looping inside the slicer. */
            if (probe == slots) return ORCAD_MESH_ERROR;
        }
    }
    return vertices;
}
