// orcad wrapper for mnp/openscad-scraper (CC0-1.0): scraper.scad.
// Upstream calls Scraper() with literal arguments at top level, so the wrapper
// declares the dimensions and passes them to the module itself.
use <openscad-scraper-c16e115c/scraper.scad>

scraper_text = "Kitchen";
scraper_width = 100;
scraper_height = 50;
scraper_thickness = 3;
scraper_text_depth = 0.2;

text_depth = scraper_text_depth;
Scraper(scraper_text, 0, 0, 0, scraper_width, scraper_height, scraper_thickness);
