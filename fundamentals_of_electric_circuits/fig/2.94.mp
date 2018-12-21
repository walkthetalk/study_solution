newRa.X(r1);
ObjMLP.X(r1)("25\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("180\Omega")(in)(top);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("60\Omega")(is)(rt);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("60\Omega")(is)(rt);

newCDM.X(m1);
ObjMLP.X(m1)("R_{eq}")(iw)(lft);


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

X(n1).c = X(n2).c + UD(0, 6);
X(n2).c = UD(0, -3);
X(n3).c = X(n1).c + UD(6, 3);

X(r1).c = X(n1).c + UD(3, 0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = X(r2).c + UD(3,-3);
X(r4).c = X(r2).c + UD(7,0);
X(m1).w = origin;

drawObj(X(r1),X(r2),X(r3),X(r4),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(n3))(90);
pcsimple(X(r2))(1)(X(n3))(90);
pcsimple(X(n3))(0)(X(r4))(2);
pcsimple(X(r2))(2)(X(r3))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
