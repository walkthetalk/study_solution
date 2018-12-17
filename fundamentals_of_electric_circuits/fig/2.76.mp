newR.X(r1) "angle(90)";
ObjMLabel.X(r1)("+")
	"labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r1)("-")
	"labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r1)("40V")
	"labpoint(is)", "labdir(rt)";

newR.X(r2);
ObjMLabel.X(r2)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r2)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r2)("50V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newR.X(r3);
ObjMLabel.X(r3)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r3)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r3)("20V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newR.X(r4);
ObjMLabel.X(r4)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r4)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r4)("30V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newR.X(r5) "angle(90)";
ObjMLabel.X(r5)("v_1")
	"labpoint(in)", "labdir(lft)";
ObjMLabel.X(r5)("+")
	"labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r5)("-")
	"labpoint(inw)", "labdir(lft)";

newR.X(r6);
ObjMLabel.X(r6)("v_2")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";
ObjMLabel.X(r6)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r6)("-")
	"labpoint(ine)", "labdir(top)";

newR.X(r7) "angle(90)";
ObjMLabel.X(r7)("v_3")
	"labpoint(in)", "labdir(lft)";
ObjMLabel.X(r7)("+")
	"labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r7)("-")
	"labpoint(inw)", "labdir(lft)";

numeric uc;
uc := 10;
X(r1).c = origin;
X(r2).c = X(r1).c+(3uc,4uc);
X(r3).c = X(r2).c+(6uc,0);
X(r4).c = X(r3).c+(3uc,4uc);
X(r5).c = X(r1).c+(12uc,0);
X(r6).c = X(r3).c+(6uc,0);
X(r7).c = X(r5).c+(6uc,0);

pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r2))(2)(X(r4))(1) "armA(xpart (X(r3).pin[1]-X(r2).pin[2]) / 2)";
pcsimple(X(r3))(2)(X(r5))(2);
pcsimple(X(r3))(2)(X(r6))(1);
pcsimple(X(r4))(2)(X(r7))(2);
pcsimple(X(r6))(2)(X(r7))(2);
pcsimple(X(r5))(1)(X(r7))(1) "armA(ypart(X(r6).iw-X(r5).ie))";
pcsimple(X(r5))(1)(X(r1))(1) "armA(ypart(X(r6).iw-X(r5).ie))";

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7)); 
