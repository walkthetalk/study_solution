newRa.X(r1);
ObjMLabel.X(r1)("25\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("180\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("60\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("60\Omega") "labpoint(is)", "labdir(rt)";

newCDM.X(m1);
ObjMLabel.X(m1)("R_{eq}") "labpoint(iw)", "labdir(lft)";


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

numeric uc;
uc := 10;
X(n1).c = X(n2).c + (0, 6uc);
X(n2).c = (0, -3uc);
X(n3).c = X(n1).c + (6uc, 3uc);

X(r1).c = X(n1).c + (3uc, 0);
X(r2).c = X(r1).c + (6uc,0);
X(r3).c = X(r2).c + (3uc,-3uc);
X(r4).c = X(r2).c + (7uc,0);
X(m1).w = origin;

drawObj(X(r1),X(r2),X(r3),X(r4),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(n3))(90);
pcsimple(X(r2))(1)(X(n3))(90);
pcsimple(X(n3))(0)(X(r4))(2);
pcsimple(X(r2))(2)(X(r3))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
