newRa.X(r1);
ObjMLP.X(r1)("20\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("30\Omega")(in)(top);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("30\Omega")(is)(rt);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("8\Omega")(is)(rt);

newNode.X(na) "pathfilled(false)";
ObjMLP.X(na)("a")(iw)(lft);
newNode.X(nb) "pathfilled(false)";
ObjMLP.X(nb)("b")(iw)(lft);

X(na).c = origin;
X(nb).c = X(na).c + UD(0,-6);
X(r3).c = (X(na).c + X(nb).c)/2 + UD(3,0);
X(r4).c = X(r3).c + UD(6,0);
X(r2).c = (X(r3).c + X(r4).c)/2 + UD(0,3);
X(r1).c = X(r2).c + UD(0,3);

drawObj(X(r1),X(r2),X(r3),X(r4),X(na),X(nb));
pcsimple(X(na))(0)(X(r2))(1);
pcsimple(X(na))(0)(X(r3))(2);
pcsimple(X(r3))(2)(X(r1))(1);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r2))(2)(X(r4))(2);
pcsimple(X(nb))(0)(X(r3))(1);
pcsimple(X(nb))(0)(X(r4))(1);
