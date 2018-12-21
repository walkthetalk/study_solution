newRa.X(r1) "angle(90)";
ObjMLP.X(r1)("6\Omega")(in)(lft);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("6\Omega")(in)(lft);
newRa.X(r3);
ObjMLP.X(r3)("3\Omega")(in)(top);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("3\Omega")(is)(rt);

newNode.X(n1) "pathfilled(false)";
newNode.X(n2) "pathfilled(false)";

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-12);

X(r1).c = X(n1).c + UD(3,-3);
X(r2).c = X(n2).c + UD(3, 3);
X(r4).c = X(r2).c + UD(6, 0);
X(r3).c = (xpart (X(r2).c + X(r4).c)/2, ypart (X(r1).c + X(r2).c)/2);

drawObj(X(r1),X(r2),X(r3),X(r4),X(n1),X(n2));
pcsimple(X(n1))(0)(X(r1))(2);
pcsimple(X(n1))(0)(X(r4))(2);
pcsimple(X(r1))(1)(X(r3))(1);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(r4))(2);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r4))(1);
