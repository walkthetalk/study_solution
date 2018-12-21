newR.X(r1);
ObjMLP.X(r1)("16\Omega")(in)(top);
newR.X(r2);
ObjMLP.X(r2)("14\Omega")(in)(top);
newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("10V")(in)(lft);
newIVS.X(u2) "angle(90)";
ObjMLP.X(u2)("25V")(is)(rt);

newNode.X(n1);
ObjMLP.X(n1)("+")(is)(bot);
newNode.X(n2);
ObjMLP.X(n2)("-")(in)(top);

X(n1).c = UD(0, 3);
X(n2).c = UD(0,-3);
X(r1).c = X(n1).c + UD(-3, 0);
X(r2).c = X(n1).c + UD( 3, 0);
X(u1).c = UD(-6, 0);
X(u2).c = UD( 6, 0);

ObjMLabel.X(n2)("V_0") "labshift((X(n1).c - X(n2).c) / 2)";

drawObj(X(r1),X(r2),X(u1),X(u2));
pcsimple(X(r1))(2)(X(n1))(0);
pcsimple(X(n1))(0)(X(r2))(1);
pcsimple(X(r2))(2)(X(u2))(2);
pcsimple(X(u2))(1)(X(n2))(180);
pcsimple(X(n2))(180)(X(u1))(1);
pcsimple(X(u1))(2)(X(r1))(1);
drawObj(X(n1),X(n2));
