//模块 -  安装望远镜的鸠尾槽
tail_for_telescope_width=63;
tail_for_telescope_thickness=20;
tail_for_telescope_cut1_length=38;
tail_for_telescope_cut2_length=54;
tail_for_telescope_cut3_thickness=8;


dovetail_saddle(40,1);
module dovetail_saddle(tail_for_telescope_length,position){
    
    if(position==1){
    //旋转把手
    translate([tail_for_telescope_width/2+20,0,tail_for_telescope_thickness/2])
    rotate([0,90,0])
    cylinder(h=15,d=30,center=true);
    
        translate([tail_for_telescope_width/2-5+10,0,tail_for_telescope_thickness/2])
    rotate([0,90,0])
    cylinder(h=15,d=8,center=true);}
    else
    {
          //旋转把手
    translate([-tail_for_telescope_width/2-20,tail_for_telescope_length/4,tail_for_telescope_thickness/2])
    rotate([0,90,0])
    cylinder(h=15,d=30,center=true);
    
        translate([-tail_for_telescope_width/2-5,tail_for_telescope_length/4,tail_for_telescope_thickness/2])
    rotate([0,90,0])
    cylinder(h=15,d=8,center=true);  
        
        translate([-tail_for_telescope_width/2-20,-tail_for_telescope_length/4,tail_for_telescope_thickness/2])
    rotate([0,90,0])
    cylinder(h=15,d=30,center=true);
    
        translate([-tail_for_telescope_width/2-5,-tail_for_telescope_length/4,tail_for_telescope_thickness/2])
    rotate([0,90,0])
    cylinder(h=15,d=8,center=true);  
        }
    
    //槽面
    color("silver")
    translate([-tail_for_telescope_width/2,tail_for_telescope_length/2,])
    rotate([90,0,0])
linear_extrude(tail_for_telescope_length)
 polygon(points=[[0,0],[tail_for_telescope_width,0],
 
 //右上角
 [tail_for_telescope_width,tail_for_telescope_thickness],
 [tail_for_telescope_width-(tail_for_telescope_width-tail_for_telescope_cut1_length)/2,tail_for_telescope_thickness],
 
  [tail_for_telescope_width-(tail_for_telescope_width-tail_for_telescope_cut2_length)/2,tail_for_telescope_cut3_thickness],
  
    [(tail_for_telescope_width-tail_for_telescope_cut2_length)/2,tail_for_telescope_cut3_thickness],
    
    
     [(tail_for_telescope_width-tail_for_telescope_cut1_length)/2,tail_for_telescope_thickness],
 //左上角
  [0,tail_for_telescope_thickness],
 ]);}