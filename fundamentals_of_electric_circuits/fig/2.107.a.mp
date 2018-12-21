newRa.X(r1);
ObjMLP.X(r1)("5\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("20\Omega")(is)(bot);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("10\Omega")(is)(rt);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("40\Omega")(is)(rt);

newNode.X(na) "pathfilled(false)";
ObjMLP.X(na)("a")(iw)(lft);
newNode.X(nb) "pathfilled(false)";
ObjMLP.X(nb)("b")(iw)(lft);

newNode.X(n1);
newNode.X(n2);

X(na).c = origin;
X(nb).c = X(na).c + UD(0,-6);
X(n1).c = X(na).c + UD(2,0);
X(n2).c = X(n1).c + UD(6,0);
X(r1).c = (X(n1).c + X(n2).c)/2 + UD(0,1.5);
X(r2).c = (X(n1).c + X(n2).c)/2 + UD(0,-1.5);
X(r3).c = (xpart (X(n2).c + UD(2,0)),
		ypart (X(na).c + X(nb).c)/2);
X(r4).c = X(r3).c + UD(4,0);

drawObj(X(r1),X(r2),X(r3),X(r4),X(na),X(nb));
pcsimple(X(na))(0)(X(n1))(0);
pcsimple(X(n1))(90)(X(r1))(1);
pcsimple(X(n1))(-90)(X(r2))(1);
pcsimple(X(r1))(2)(X(n2))(-90);
pcsimple(X(r2))(2)(X(n2))(90);
pcsimple(X(n2))(0)(X(r3))(2);
pcsimple(X(n2))(0)(X(r4))(2);
pcsimple(X(nb))(0)(X(r3))(1);
pcsimple(X(nb))(0)(X(r4))(1);
