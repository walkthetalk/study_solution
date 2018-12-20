newRa.X(r1);
ObjMLabel.X(r1)("4S") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("6S") "labpoint(in)", "labdir(top)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("1S") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(r3)("+") "labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r3)("-") "labpoint(inw)", "labdir(lft)";
ObjMLabel.X(r3)("v") "labpoint(in)", "labdir(lft)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("2S") "labpoint(is)", "labdir(rt)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("3S") "labpoint(is)", "labdir(rt)";

newCDM.X(m1);
ObjMLabel.X(m1)("i") "labpoint(in)", "labdir(top)";

newICS.X(u1) "angle(90)";
ObjMLabel.X(u1)("9A") "labpoint(in)", "labdir(lft)";


newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(u1).c = origin;
X(n1).c = X(u1).c + (0, 3uc);
X(n2).c = X(u1).c + (0,-3uc);

X(r1).c = (xpart (X(r3).c + X(r4).c)/2, ypart X(n1).c);
X(r2).c = (xpart (X(r4).c + X(r5).c)/2, ypart X(n1).c);

X(r3).c = X(u1).c + (4uc,0);
X(r4).c = X(r3).c + (8uc,0);
X(r5).c = X(r4).c + (6uc,0);

X(m1).se = X(r1).w;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(u1),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(n1))(0)(X(r3))(2);
pcsimple(X(n1))(-90)(X(u1))(2);

pcsimple(X(r4))(2)(X(r1))(2);
pcsimple(X(r4))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r5))(2);

pcsimple(X(n2))(90)(X(u1))(1);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
pcsimple(X(n2))(0)(X(r5))(1);
