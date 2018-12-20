newRa.X(r1);
ObjMLabel.X(r1)("5\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("8\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("20\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r4);
ObjMLabel.X(r4)("30\Omega") "labpoint(in)", "labdir(top)";

newNode.X(na) "pathfilled(false)";
ObjMLabel.X(na)("a") "labpoint(iw)", "labdir(lft)";
newNode.X(nb) "pathfilled(false)";
ObjMLabel.X(nb)("b") "labpoint(ie)", "labdir(rt)";
newNode.X(n1);
newNode.X(n2);
newNode.X(n3);
newNode.X(n4);

numeric uc;
uc := 10;
X(na).c = origin;
X(n1).c = X(na).c + (2uc, 0);
X(n3).c = X(n1).c + (6uc, -2uc);
X(n4).c = X(n3).c + (6uc,0);
X(n2).c = X(n4).c + (uc, 3uc);
X(nb).c = X(n2).c + (2uc, 0);

X(r1).c = X(n1).c + (5uc,1uc);
X(r2).c = X(n3).c + (-3uc,0);
X(r3).c = (X(n3).c + X(n4).c)/2;
X(r4).c = X(r3).c + (0,-3uc);

drawObj(X(r1),X(r2),X(r3),X(r4),X(na),X(nb));
pcsimple(X(na))(0)(X(n1))(0);
pcsimple(X(n1))(90)(X(r1))(1);
pcsimple(X(n1))(-90)(X(r2))(1);
pcsimple(X(r1))(2)(X(n2))(-90);
pcsimple(X(n2))(0)(X(nb))(0);
pcsimple(X(n2))(-90)(X(n4))(180);
pcsimple(X(n4))(180)(X(r3))(2);
pcsimple(X(n4))(-90)(X(r4))(2);
pcsimple(X(r4))(1)(X(n3))(90);
pcsimple(X(r3))(1)(X(n3))(180);
pcsimple(X(n3))(180)(X(r2))(2);
