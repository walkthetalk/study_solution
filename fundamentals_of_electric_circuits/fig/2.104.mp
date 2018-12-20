newRa.X(r1);
ObjMLabel.X(r1)("8\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("2\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("1\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("4\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("6\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r6) "angle(90)";
ObjMLabel.X(r6)("2\Omega") "labpoint(is)", "labdir(rt)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("15V") "labpoint(in)", "labdir(lft)";

newCDM.X(m1);
ObjMLabel.X(m1)("I") "labpoint(in)", "labdir(top)";
newCDM.X(m2);
ObjMLabel.X(m2)("R_{eq}") "labpoint(in)", "labdir(top)";

newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(n1).c = origin;
X(n2).c = X(n1).c + (0,-6uc);
X(u1).c = (X(n1).c + X(n2).c)/2;

X(r1).c = X(n1).c + (5uc,0);
X(r2).c = X(r1).c + (6uc,0);
X(r3).c = X(r2).c + (6uc,0);
X(r4).c = (xpart (X(r1).c+X(r2).c)/2, ypart X(u1).c);
X(r5).c = (xpart (X(r2).c+X(r3).c)/2, ypart X(u1).c);
ypart X(r6).c = ypart X(u1).c;
xpart X(r3).c = xpart (X(r5).c+X(r6).c)/2;
X(m1).se = X(r1).w;
X(m2).e = X(r4).nw;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(u1),X(m1),X(m2));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(n1))(-90)(X(u1))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r2))(2)(X(r5))(2);
pcsimple(X(r3))(2)(X(r6))(2);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(r4))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
