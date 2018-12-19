newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("10 k\Omega") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(r1)("+") "labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r1)("-") "labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r1)("V_o") "labpoint(is)", "labdir(rt)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("5 k\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("20 k\Omega") "labpoint(is)", "labdir(rt)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("5 mA") "labpoint(in)", "labdir(lft)";
newDVS.X(u2) "angle(90)";
ObjMLabel.X(u2)("0.01 V_o") "labpoint(is)", "labdir(rt)";

newNode.X(n1);
newNode.X(n2);
newNode.X(n3);
newNode.X(n4);

numeric uc;
uc := 10;
X(u1).c = origin;
X(r1).c = X(u1).c + (5uc,0);
X(u2).c = X(r1).c + (5uc,0);
X(r2).c = X(u2).c + (5uc,0);
X(r3).c = X(r2).c + (5uc,0);

X(n1).c = X(u1).c + (0,3uc);
X(n2).c = X(u1).c + (0,-3uc);
X(n3).c = X(u2).c + (0,3uc);
X(n4).c = X(u2).c + (0,-3uc);

drawObj(X(r1),X(r2),X(r3),X(u1),X(u2));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n1))(0)(X(r1))(2);
pcsimple(X(n2))(0)(X(r1))(1);

pcsimple(X(u2))(2)(X(n3))(90);
pcsimple(X(u2))(1)(X(n4))(-90);
pcsimple(X(n3))(0)(X(r2))(2);
pcsimple(X(n3))(0)(X(r3))(2);
pcsimple(X(n4))(0)(X(r2))(1);
pcsimple(X(n4))(0)(X(r3))(1);

pcsimple(X(n2))(0)(X(n4))(0);
