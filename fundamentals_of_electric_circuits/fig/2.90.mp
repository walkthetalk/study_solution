newRa.X(r1);
ObjMLabel.X(r1)("25\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("20\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("10\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("50\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("40\Omega") "labpoint(is)", "labdir(rt)";

newCDM.X(m1);
ObjMLabel.X(m1)("i_x") "labpoint(in)", "labdir(top)";
newCDM.X(m2);
ObjMLabel.X(m2)("i_o") "labpoint(in)", "labdir(top)";

newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(n1).c = (0,3uc);
X(n2).c = (0,-3uc);
X(r1).c = X(n1).c + (4uc,0);
X(r2).c = (7uc,0);
X(r3).c = X(r2).c + (4uc,0);
X(r4).c = X(r3).c + (4uc,0);
X(r5).c = X(r4).c + (4uc,0);

X(m1).sw = X(n1).c;
X(m2).s = (xpart (X(r4).c + X(r5).c)/2, ypart X(n1).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(m1),X(m2));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r1))(2)(X(r5))(2);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
pcsimple(X(n2))(0)(X(r5))(1);
