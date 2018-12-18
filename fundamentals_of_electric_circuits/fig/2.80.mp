newR.X(r1);
ObjMLabel.X(r1)("16\Omega") "labpoint(in)", "labdir(top)";
newR.X(r2);
ObjMLabel.X(r2)("14\Omega") "labpoint(in)", "labdir(top)";
newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("10V") "labpoint(in)", "labdir(lft)";
newIVS.X(u2) "angle(90)";
ObjMLabel.X(u2)("25V") "labpoint(is)", "labdir(rt)";

newNode.X(n1);
ObjMLabel.X(n1)("+") "labpoint(is)", "labdir(bot)";
newNode.X(n2);
ObjMLabel.X(n2)("-") "labpoint(in)", "labdir(top)";

numeric uc;
uc := 10;
X(n1).c = (0, 3uc);
X(n2).c = (0,-3uc);
X(r1).c = X(n1).c + (-3uc, 0);
X(r2).c = X(n1).c + ( 3uc, 0);
X(u1).c = (-6uc, 0);
X(u2).c = ( 6uc, 0);

ObjMLabel.X(n2)("V_0") "labshift((X(n1).c - X(n2).c) / 2)";

drawObj(X(r1),X(r2),X(u1),X(u2));
pcsimple(X(r1))(2)(X(n1))(0);
pcsimple(X(n1))(0)(X(r2))(1);
pcsimple(X(r2))(2)(X(u2))(2);
pcsimple(X(u2))(1)(X(n2))(180);
pcsimple(X(n2))(180)(X(u1))(1);
pcsimple(X(u1))(2)(X(r1))(1);
drawObj(X(n1),X(n2));
