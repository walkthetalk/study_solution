newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("p_1")
	"labpoint(is)", "labdir(rt)";
ObjMLabel.X(u1)("30V")
	"labpoint(in)", "labdir(lft)";

newR.X(r2);
ObjMLabel.X(r2)("p_2")
	"labpoint(is)", "labdir(bot)";
ObjMLabel.X(r2)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r2)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r2)("10V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newR.X(r3) "angle(90)";
ObjMLabel.X(r3)("p_3")
	"labpoint(is)", "labdir(rt)";
ObjMLabel.X(r3)("+")
	"labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r3)("-")
	"labpoint(inw)", "labdir(lft)";
ObjMLabel.X(r3)("20V")
	"labpoint(in)", "labdir(lft)";

newR.X(r4);
ObjMLabel.X(r4)("p_4")
	"labpoint(is)", "labdir(bot)";
ObjMLabel.X(r4)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r4)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r4)("8V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newDCS.X(u2) "angle(90)";
ObjMLabel.X(u2)("p_5")
	"labpoint(is)", "labdir(urt)";
ObjMLabel.X(u2)("0.4I")
	"labpoint(is)", "labdir(lrt)";
ObjMLabel.X(u2)("12V")
	"labpoint(in)", "labdir(lft)";
ObjMLabel.X(u2)("+")
	"labpoint(ie)", "labdir(ulft)";
ObjMLabel.X(u2)("-")
	"labpoint(iw)", "labdir(llft)";

newCDM.X(cdm0) "angle(180)";
ObjMLabel.X(cdm0)("4A")
	"labpoint(is)", "labdir(top)";
newCDM.X(cdm1);
ObjMLabel.X(cdm1)("I=10A")
	"labpoint(in)", "labdir(top)";
newCDM.X(cdm2) "angle(-90)";
ObjMLabel.X(cdm2)("14A")
	"labpoint(in)", "labdir(rt)";

numeric uc;
uc := 10;
X(r3).c = origin;
X(u1).c = X(r3).c+(-9uc,0);
X(u2).c = X(r3).c+( 9uc,0);
X(r2).c = X(r3).c+(-3uc,5uc);
X(r4).c = X(r3).c+( 3uc,5uc);

X(cdm0).nnw = (xpart(X(u2).c), ypart(X(r4).c));
X(cdm1).ssw = (xpart(X(u1).c), ypart(X(r2).c));
X(cdm2).se = X(r3).ie;

pcsimple(X(u2))(2)(X(r4))(2);
pcsimple(X(r3))(1)(X(u2))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
pcsimple(X(r3))(1)(X(u1))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
pcsimple(X(r3))(2)(X(r4))(1);
pcsimple(X(r3))(2)(X(r2))(2);
pcsimple(X(u1))(2)(X(r2))(1);

drawObj(X(u1),X(r2),X(r3),X(r4),X(u2));
drawObj(X(cdm0),X(cdm1),X(cdm2)); 
