newR.X(r1) "angle(90)";
ObjMLabel.X(r1)("+")
	"labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r1)("-")
	"labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r1)("V_1")
	"labpoint(is)", "labdir(rt)";

newR.X(r2);
ObjMLabel.X(r2)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r2)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r2)("1V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newR.X(r3) "angle(90)";
ObjMLabel.X(r3)("+")
	"labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r3)("-")
	"labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r3)("5V")
	"labpoint(is)", "labdir(rt)";

newR.X(r4);
ObjMLabel.X(r4)("+")
	"labpoint(inw)", "labdir(top)";
ObjMLabel.X(r4)("-")
	"labpoint(ine)", "labdir(top)";
ObjMLabel.X(r4)("2V")
	"labpoint(in)", "labdir(top)", "labshift((0,10))";

newR.X(r5) "angle(90)";
ObjMLabel.X(r5)("V_2")
	"labpoint(is)", "labdir(rt)";
ObjMLabel.X(r5)("+")
	"labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r5)("-")
	"labpoint(isw)", "labdir(rt)";

numeric uc;
uc := 10;
X(r3).c = origin;
X(r1).c = X(r3).c+(-6uc,0);
X(r5).c = X(r3).c+( 6uc,0);
X(r2).c = X(r3).c+(-3uc,4uc);
X(r4).c = X(r3).c+( 3uc,4uc);

pcsimple(X(r5))(2)(X(r4))(2);
pcsimple(X(r3))(1)(X(r5))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
pcsimple(X(r3))(1)(X(r1))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
pcsimple(X(r3))(2)(X(r4))(1);
pcsimple(X(r3))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r2))(1);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5)); 
