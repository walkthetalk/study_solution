newRa.X(r1);
ObjMLabel.X(r1)("8\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("3\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("6\Omega") "labpoint(is)", "labdir(rt)";

newCDM.X(m1);
ObjMLabel.X(m1)("I_o") "labpoint(is)", "labdir(bot)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("10V") "labpoint(in)", "labdir(lft)";


newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(u1).c = origin;
X(n1).c = X(u1).c + (0, 3uc);
X(n2).c = X(u1).c + (0,-3uc);
X(r1).c = X(n1).c + (3uc,0);
X(r2).c = X(u1).c + (6uc,0);
X(r3).c = X(r2).c + (4uc,0);

X(m1).n = X(r1).is;

drawObj(X(r1),X(r2),X(r3),X(u1),X(m1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
