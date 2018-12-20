newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("6\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("6\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r3);
ObjMLabel.X(r3)("3\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("3\Omega") "labpoint(is)", "labdir(rt)";

newNode.X(n1) "pathfilled(false)";
newNode.X(n2) "pathfilled(false)";

numeric uc;
uc := 10;
X(n1).c = origin;
X(n2).c = X(n1).c + (0,-12uc);

X(r1).c = X(n1).c + (3uc,-3uc);
X(r2).c = X(n2).c + (3uc, 3uc);
X(r4).c = X(r2).c + (6uc, 0);
X(r3).c = (xpart (X(r2).c + X(r4).c)/2, ypart (X(r1).c + X(r2).c)/2);

drawObj(X(r1),X(r2),X(r3),X(r4),X(n1),X(n2));
pcsimple(X(n1))(0)(X(r1))(2);
pcsimple(X(n1))(0)(X(r4))(2);
pcsimple(X(r1))(1)(X(r3))(1);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(r4))(2);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r4))(1);
