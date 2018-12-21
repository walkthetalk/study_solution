newRa.X(r1) "angle(90)";
ObjMLP.X(r1)("10\Omega")(is)(rt);
newRa.X(r2);
ObjMLP.X(r2)("10\Omega")(is)(bot);
ObjMLP.X(r2)("+")(inw)(top);
ObjMLP.X(r2)("V_0")(in)(top) "labshift(UD(0,1))";
ObjMLP.X(r2)("-")(ine)(top);
newICS.X(u1) "angle(90)";
ObjMLP.X(u1)("25A")(in)(lft);
newDCS.X(u2) "angle(90)";
ObjMLP.X(u2)("2V_0")(is)(rt);

newNode.X(n1);
newNode.X(n2);

X(n1).c = origin;
X(r1).c = X(n1).c + UD(0,-3);
X(n2).c = X(r1).c + UD(0,-3);

X(r2).c = X(n1).c + UD(4, 0);
X(u1).c = X(r1).c + UD(8, 0);
X(u2).c = X(u1).c + UD(3,0);

drawObj(X(r1),X(r2),X(u1),X(u2));
pcsimple(X(r1))(2)(X(n1))(90);
pcsimple(X(n1))(0)(X(r2))(1);
pcsimple(X(r2))(2)(X(u1))(2);
pcsimple(X(r2))(2)(X(u2))(2);
pcsimple(X(r1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(u1))(1);
pcsimple(X(n2))(0)(X(u2))(1);
