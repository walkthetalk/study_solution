newRa.X(r1);
ObjMLP.X(r1)("10\Omega")(in)(top);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("80\Omega")(in)(lft);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("60\Omega")(in)(lft);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("20\Omega")(in)(lft);
newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("30\Omega")(in)(lft);

newNode.X(na) "pathfilled(false)";
ObjMLP.X(na)("a")(iw)(lft);
newNode.X(nb) "pathfilled(false)";
ObjMLP.X(nb)("b")(iw)(lft);

newNode.X(n1);
newNode.X(n2);

X(na).c = origin;
X(nb).c = X(na).c + UD(0,-8);
X(r2).c = (X(na).c + X(nb).c)/2 + UD(3,0);
X(r1).c = X(na).c + UD(8,0);
X(n2).c = X(nb).c + UD(14,0);
X(n1).c = X(n2).c + UD(0,6);
X(r4).c = (X(n1).c + X(n2).c)/2;
X(r3).c = X(r4).c + UD(-5,0);
X(r5).c = X(r4).c + UD(5,0);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(na),X(nb));
pcsimple(X(na))(0)(X(r2))(2);
pcsimple(X(na))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(n1))(-90);
pcsimple(X(n1))(180)(X(r3))(2);
pcsimple(X(n1))(-90)(X(r4))(2);
pcsimple(X(n1))(0)(X(r5))(2);
pcsimple(X(nb))(0)(X(r2))(1);
pcsimple(X(nb))(0)(X(r3))(1);
pcsimple(X(nb))(0)(X(r4))(1);
pcsimple(X(nb))(0)(X(r5))(1);
