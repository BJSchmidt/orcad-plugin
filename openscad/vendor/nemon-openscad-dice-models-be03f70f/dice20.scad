// 20面体骰子
module item(w=10,d=45,p=0){
    rotate([d,0,p])
        cube([w*2,w,w*2],center=true);
}

module dice_20(w=10){
    d=acos(tan(30)/tan(36));//acos(tan(54)/tan(60));
    f=asin(sin(54)/sin(60))*2;
    rotate([d,0,0])
        intersection(){
            intersection_for (a = [ 0 : 4 ])item(w,90-d,72*a);
            intersection_for (a = [ 0 : 4 ])item(w,f-d-90,72*a);
        };
}

w=10;
dice_20(w);





