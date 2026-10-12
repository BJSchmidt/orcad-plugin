// 4面体骰子
module item(w=10,d=45,p=0){
    rotate([d,0,p])
        cube([w*3,w,w*3],center=true);
}

module dice_4(w=10){
    intersection(){
        translate([0,0,-w])
            intersection_for (a = [ 0 : 2 ])
                item(w,90-acos(1/3),120*a);
        item(w,90,0);
    }
}

w=5;
dice_4(w);

echo(pow(3,1/2));