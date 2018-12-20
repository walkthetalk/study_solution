newRa.X(r1);
ObjMLabel.X(r1)("30\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("10\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("60\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("R") "labpoint(is)", "labdir(rt)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("12\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r6) "angle(90)";
ObjMLabel.X(r6)("12\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r7) "angle(90)";
ObjMLabel.X(r7)("12\Omega") "labpoint(is)", "labdir(rt)";

newCDM.X(m1);
ObjMLabel.X(m1)("R_{eq}") "labpoint(in)", "labdir(top)";

newNode.X(n1) "pathfilled(false)";
newNode.X(n2) "pathfilled(false)";
newNode.X(n3);
newNode.X(n4);

numeric uc;
uc := 10;
X(n1).c = origin;
X(n2).c = X(n1).c + (0,-6uc);

X(r1).c = X(n1).c + (3uc,0);
X(r2).c = X(r1).c + (3uc,3uc);
X(n3).c = X(r2).c + (0,3uc);
X(r3).c = X(r1).c + (3uc,-3uc);
X(r4).c = X(r2).c + (6uc,0);
X(r6).c = X(n4).c + (0,-3uc);
X(r5).c = X(r6).c + (-3uc,0);
X(r7).c = X(r6).c + (3uc,0);
X(n4).c = (X(r4).c + X(r6).c)/2;

X(m1).w = (X(n1).c + X(n2).c)/2;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(n1),X(n2),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(r2))(2)(X(n3))(90);
pcsimple(X(n3))(0)(X(r4))(2);
pcsimple(X(r4))(1)(X(n4))(-90);
pcsimple(X(n4))(180)(X(r5))(2);
pcsimple(X(n4))(-90)(X(r6))(2);
pcsimple(X(n4))(  0)(X(r7))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
pcsimple(X(n2))(0)(X(r7))(1);
