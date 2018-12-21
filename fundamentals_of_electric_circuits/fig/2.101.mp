newRa.X(r1);
ObjMLP.X(r1)("R_1")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("R_1")(in)(top);

newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("R_1")(in)(lft);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("R_1")(in)(lft);

newNode.X(n1);
newNode.X(n2);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);

X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = (X(n1).c+X(n2).c)/2 + UD(6,0);
X(r4).c = X(r3).c + UD(6,0);

drawObj(X(r1),X(r2),X(r3),X(r4));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r4))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
