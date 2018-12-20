newRa.X(r1);
ObjMLabel.X(r1)("R_1") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("R_1") "labpoint(in)", "labdir(top)";

newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("R_1") "labpoint(in)", "labdir(lft)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("R_1") "labpoint(in)", "labdir(lft)";

newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(n1).c = origin;
X(n2).c = X(n1).c + (0,-6uc);

X(r1).c = X(n1).c + (3uc,0);
X(r2).c = X(r1).c + (6uc,0);
X(r3).c = (X(n1).c+X(n2).c)/2 + (6uc,0);
X(r4).c = X(r3).c + (6uc,0);

drawObj(X(r1),X(r2),X(r3),X(r4));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r4))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
