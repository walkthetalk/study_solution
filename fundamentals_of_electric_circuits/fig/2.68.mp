newIVS.X(v0)"angle(90)";
ObjMLP.X(v0)("40V")(is)(rt);
newRa.X(r0) "angle(90)";
ObjMLP.X(r0)("100\Omega")(is)(rt);
newRa.X(r1) "angle(90)";
ObjMLP.X(r1)("250\Omega")(is)(rt);
newSwitch.X(s0)(1) "angle(90)";
ObjMLP.X(s0)("1")(pin[1])(lft);
ObjMLP.X(s0)("2")(pin[2])(rt);
newCDM.X(cdm0) "angle(90)";
ObjMLP.X(cdm0)("i")(is)(rt);

X(v0).c = origin;
X(s0).c = X(v0).c  + UD(0, 5);
X(r0).c = X(v0).ie + UD(-6, 0);
X(r1).c = X(v0).ie + UD( 6, 0);
X(cdm0).nw = X(v0).ie;

drawObj(X(v0),X(r0),X(r1),X(s0),X(cdm0));
pcsimple(X(s0))(1)(X(r0))(2);
pcsimple(X(s0))(2)(X(r1))(2);
pcsimple(X(s0))(3)(X(v0))(2);
pcsimple(X(v0))(1)(X(r0))(1);
pcsimple(X(v0))(1)(X(r1))(1); 
