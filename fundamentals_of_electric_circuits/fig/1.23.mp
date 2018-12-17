defcoord(10,2,15,15,1.5);
defdim.x("t(ms)")(0,2,4,6,8,10,12);
defdim.y("q(t)(mC)")(30);
draw coordsys;
drawemp((0,0)--(2,30)--(8,30)--(12,0));
drawaux((2,0)--(2,30));
drawaux((8,0)--(8,30)); 
