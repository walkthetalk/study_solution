defcoord(7,0.7,15,15,1.5);
defdim.x("(t) s")(0,6,10,15);
setloc.x("lrt")(10,15);
defdim.y("q(t) C")(18,54,66,126);
draw coordsys;

defcurve.main(0,6,1,20)(polyval)(polytan)(0,0,1.5);
drawauxp.p((6,54),(10,126),(15,66));
drawemp(pathcurve.main--(10,126)--(15,66)--(16,66));
