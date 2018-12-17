newIVS.X(v0)"angle(90)";
ObjMLabel.X(v0)("12V")
	"labpoint(in)", "labdir(lft)";
newRa.X(r0);
ObjMLabel.X(r0)("1\Omega")
	"labpoint(in)", "labdir(top)";
newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("8\Omega")
	"labpoint(is)", "labdir(rt)";
newRa.X(r2);
ObjMLabel.X(r2)("4\Omega")
	"labpoint(in)", "labdir(top)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("5\Omega")
	"labpoint(is)", "labdir(rt)";
newICS.X(c0) "angle(-90)";
ObjMLabel.X(c0)("2A")
	"labpoint(in)", "labdir(rt)";

numeric uc;
uc := 10;
X(v0).c = origin;
X(r0).c = X(v0).c + (3uc,3uc);
X(r1).c = X(v0).c + (6uc,  0);
X(r2).c = X(r0).c + (6uc,  0);
X(r3).c = X(r1).c + (6uc,  0);
X(c0).c = X(r3).c + (6uc,  0);

drawObj(X(v0),X(r0),X(r1),X(r2),X(r3),X(c0));
pcsimple(X(v0))(2)(X(r0))(1);
pcsimple(X(r0))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(c0))(1);
pcsimple(X(r0))(2)(X(r1))(2);
pcsimple(X(r2))(2)(X(r3))(2);
pcsimple(X(r1))(1)(X(v0))(1);
pcsimple(X(r1))(1)(X(r3))(1);
pcsimple(X(r3))(1)(X(c0))(2); 
