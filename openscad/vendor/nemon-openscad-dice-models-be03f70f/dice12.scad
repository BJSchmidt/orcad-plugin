// 12面体骰子
module item(w=10,d=45,p=0){
    rotate([d,0,p])
        cube([w*2,w,w*2],center=true);
}

module dice_12(w=10){
    d=90-acos(tan(18)/tan(36));
    intersection(){
        item(w,90,0);
        intersection_for (a = [ 0 : 4 ])item(w,d,72*a);
    };
}

w=10;
dice_12(w);

