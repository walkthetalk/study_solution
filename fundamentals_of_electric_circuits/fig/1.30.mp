newR.X(r0) "angle(90)";
ObjMLabel.X(r0)("-")
	"labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r0)("+")
	"labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r0)("15V")
	"labpoint(is)", "labdir(rt)";
ObjMLabel.X(r0)("p_2")
	"labpoint(ine)", "labdir(ulft)";

newR.X(r1) "angle(90)";
ObjMLabel.X(r1)("-")
	"labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r1)("+")
	"labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r1)("9V")
	"labpoint(is)", "labdir(rt)";
ObjMLabel.X(r1)("p_3")
	"labpoint(ine)", "labdir(lft)";

newIVS.X(u2) "angle(-90)";
ObjMLabel.X(u2)("6V")
	"labpoint(in)", "labdir(rt)";
ObjMLabel.X(u2)("p_4")
	"labpoint(ise)", "labdir(llft)";

newICS.X(u1) "angle(-90)";
ObjMLabel.X(u1)("15V")
	"labpoint(in)", "labdir(rt)";
ObjMLabel.X(u1)("10A")
	"labpoint(is)", "labdir(lft)";
ObjMLabel.X(u1)("-")
	"labpoint(inw)", "labdir(rt)";
ObjMLabel.X(u1)("+")
	"labpoint(ine)", "labdir(rt)";
ObjMLabel.X(u1)("p_1")
	"labpoint(isw)", "labdir(ulft)";

newCDM.X(cdm0) "angle(-90)";
ObjMLabel.X(cdm0)("I")
	"labpoint(in)", "labdir(rt)";
newCDM.X(cdm1) "angle(90)";
ObjMLabel.X(cdm1)("4A")
	"labpoint(is)", "labdir(rt)";

numeric uc;
uc := 10;
X(r0).c = origin;
X(r1).c = X(r0).c + (5uc,2uc);
X(u2).c = X(r0).c + (5uc,-2uc);
X(u1).c = X(r0).c + (-5uc,0);
X(cdm0).ssw = (xpart X(r1).c, ypart X(r0).ie + 5uc);
X(cdm1).ne  = X(r0).ie + (0,5uc);

drawObj(X(r0),X(r1),X(u1),X(u2));
pcsimple(X(r0))(2)(X(r1))(2) "armA(5uc)";
pcsimple(X(r0))(2)(X(u1))(1) "armA(5uc)";
pcsimple(X(r0))(1)(X(u1))(2) "armA(3uc)";
pcsimple(X(r0))(1)(X(u2))(2) "armA(3uc)";
pcsimple(X(r1))(1)(X(u2))(1);
drawObj(X(cdm0),X(cdm1)); 
