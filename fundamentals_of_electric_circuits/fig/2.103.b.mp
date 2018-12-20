newRa.X(r1);
ObjMLabel.X(r1)("3k\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("2k\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("6k\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("6k\Omega") "labpoint(in)", "labdir(lft)";

newNode.X(n1) "pathfilled(false)";
newNode.X(n2) "pathfilled(false)";
newNode.X(n3);
newNode.X(n4);

numeric uc;
uc := 10;
X(n1).c = origin;
X(n2).c = X(n1).c + (0,-6uc);
X(n3).c = X(n1).c + (1.5uc,3uc);
X(n4).c = (xpart X(n3).c + 6uc, ypart X(n1).c);

X(r1).c = (xpart X(n4).c, ypart X(n3).c);
X(r2).c = X(n4).c + (-3uc, 0);
X(r3).c = X(n4).c + (3uc,0);
X(r4).c = X(n4).c + (6uc,-3uc);

drawObj(X(r1),X(r2),X(r3),X(r4),X(n1),X(n2));
pcsimple(X(n1))(0)(X(r2))(1);
pcsimple(X(n1))(0)(X(n3))(90);
pcsimple(X(n3))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r2))(2)(X(n4))(0);
pcsimple(X(n4))(0)(X(r3))(1);
pcsimple(X(r3))(2)(X(r4))(2);
pcsimple(X(n2))(0)(X(n4))(90);
pcsimple(X(n2))(0)(X(r4))(1);
