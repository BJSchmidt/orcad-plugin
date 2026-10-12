// 2 * 5 = 10面体骰子
module item(w=10,d=45,p=0){
    rotate([d,0,p])
        cube([w*2,w,w*2],center=true);
}

module dice_2n(n=5,w=10){
    p=360/n;
    d=90-atan(sqrt(1/cos(p/2)));
    rotate([90-d,0,0])
    intersection_for (a = [ 0 : (n-1) ])
        item(w,d,p*a);
}

w=5;
n=3;
for(a=[n:8]){
    translate([(a-n)*2*w,0,0])
        dice_2n(a,w);
}
//item(50,0,0);