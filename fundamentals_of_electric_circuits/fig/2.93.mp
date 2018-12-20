newRa.X(r1);
ObjMLabel.X(r1)("R") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("R") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("R") "labpoint(in)", "labdir(top)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("R") "labpoint(is)", "labdir(rt)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("R") "labpoint(is)", "labdir(rt)";
newRa.X(r6) "angle(90)";
ObjMLabel.X(r6)("R") "labpoint(is)", "labdir(rt)";
newRa.X(r7) "angle(90)";
ObjMLabel.X(r7)("R") "labpoint(is)", "labdir(rt)";

newCDM.X(m1);
ObjMLabel.X(m1)("R_{eq}") "labpoint(in)", "labdir(top)";


newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(n1).c = X(n2).c + (0, 9uc);
X(n2).c = (0, -6uc);
X(r4).c = X(n2).c + (3uc, 3uc);
X(r5).c = X(r4).c + (5uc,0);
X(r6).c = X(r5).c + (6uc,0);
X(r7).c = X(r6).c + (6uc,0);
X(r3).c = (xpart (X(r6).c+X(r7).c)/2, ypart X(n2).c);
X(r2).c = (X(r6).c+X(r5).c)/2 + (0,3uc);
X(r1).c = (xpart X(r2).c, ypart X(n1).c);
X(m1).e = (xpart X(r4).c, ypart X(r2).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(n1))(0)(X(r4))(2);
pcsimple(X(r1))(2)(X(r7))(2);
pcsimple(X(r2))(1)(X(r4))(2);
pcsimple(X(r2))(1)(X(r5))(2);
pcsimple(X(r2))(2)(X(r6))(2);
pcsimple(X(r2))(2)(X(r7))(2);
pcsimple(X(n2))(0)(X(r4))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(r3))(2)(X(r7))(1);
