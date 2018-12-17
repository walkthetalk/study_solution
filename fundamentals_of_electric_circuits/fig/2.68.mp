newIVS.X(v0)"angle(90)";
ObjMLabel.X(v0)("40V")
	"labpoint(is)", "labdir(rt)";
newRa.X(r0) "angle(90)";
ObjMLabel.X(r0)("100\Omega")
	"labpoint(is)", "labdir(rt)";
newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("250\Omega")
	"labpoint(is)", "labdir(rt)";
newSwitch.X(s0)(1) "angle(90)";
ObjMLabel.X(s0)("1")
	"labpoint(pin[1])", "labdir(lft)";
ObjMLabel.X(s0)("2")
	"labpoint(pin[2])", "labdir(rt)";
newCDM.X(cdm0) "angle(90)";
ObjMLabel.X(cdm0)("i")
	"labpoint(is)", "labdir(rt)";

numeric uc;
uc := 10;
X(v0).c = origin;
X(s0).c = X(v0).c  + (0, 5uc);
X(r0).c = X(v0).ie + (-6uc, 0);
X(r1).c = X(v0).ie + ( 6uc, 0);
X(cdm0).nw = X(v0).ie;

drawObj(X(v0),X(r0),X(r1),X(s0),X(cdm0));
pcsimple(X(s0))(1)(X(r0))(2);
pcsimple(X(s0))(2)(X(r1))(2);
pcsimple(X(s0))(3)(X(v0))(2);
pcsimple(X(v0))(1)(X(r0))(1);
pcsimple(X(v0))(1)(X(r1))(1); 
