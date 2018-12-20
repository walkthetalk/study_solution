newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("70\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("30\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("20\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("5\Omega") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(r4)("+") "labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r4)("-") "labpoint(inw)", "labdir(lft)";
ObjMLabel.X(r4)("V_o")"labpoint(in)", "labdir(lft)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("200V") "labpoint(in)", "labdir(lft)";

newCDM.X(m1);
ObjMLabel.X(m1)("I_o") "labpoint(in)", "labdir(top)";


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

numeric uc;
uc := 10;
X(n3).c = origin;

X(u1).c = X(n3).c + (-6uc,0);
X(n1).c = X(u1).c + (0,6uc);
X(n2).c = X(u1).c + (0,-6uc);

X(r1).c = X(n3).c + (0,3uc);
X(r3).c = X(n3).c + (0,-3uc);
X(r2).c = X(r1).c + (4uc,0);
X(r4).c = X(r3).c + (4uc,0);

X(m1).s = X(n3).c + (2uc, 0);

drawObj(X(r1),X(r2),X(r3),X(r4),X(u1),X(m1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(u1))(1)(X(n2))(-90);

pcsimple(X(n1))(0)(X(r1))(2);
pcsimple(X(n1))(0)(X(r2))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);

pcsimple(X(n3))(90)(X(r1))(1);
pcsimple(X(n3))(-90)(X(r3))(2);
pcsimple(X(n3))(0)(X(r2))(1);
pcsimple(X(n3))(0)(X(r4))(2);
