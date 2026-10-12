
dovetail_bar(100);
//鸠尾板
module dovetail_bar(main_tube_lenght){

    rotate([90,0,0])
    translate([-22.5,0,-(main_tube_lenght+70)/2])
    //鸠尾板
color("DarkOrange")
linear_extrude(height=main_tube_lenght+70){

 
 polygon(points=[[0,0],[45,0],[41.5,12],[3.5,12]]);
 
 
    }
}