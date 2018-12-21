newRa.X(r1);
ObjMLP.X(r1)("5\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("8\Omega")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("20\Omega")(in)(top);
newRa.X(r4);
ObjMLP.X(r4)("30\Omega")(in)(top);

newNode.X(na) "pathfilled(false)";
ObjMLP.X(na)("a")(iw)(lft);
newNode.X(nb) "pathfilled(false)";
ObjMLP.X(nb)("b")(ie)(rt);
newNode.X(n1);
newNode.X(n2);
newNode.X(n3);
newNode.X(n4);

X(na).c = origin;
X(n1).c = X(na).c + UD(2, 0);
X(n3).c = X(n1).c + UD(6, -2);
X(n4).c = X(n3).c + UD(6,0);
X(n2).c = X(n4).c + UD(1, 3);
X(nb).c = X(n2).c + UD(2, 0);

X(r1).c = X(n1).c + UD(5,1);
X(r2).c = X(n3).c + UD(-3,0);
X(r3).c = (X(n3).c + X(n4).c)/2;
X(r4).c = X(r3).c + UD(0,-3);

drawObj(X(r1),X(r2),X(r3),X(r4),X(na),X(nb));
pcsimple(X(na))(0)(X(n1))(0);
pcsimple(X(n1))(90)(X(r1))(1);
pcsimple(X(n1))(-90)(X(r2))(1);
pcsimple(X(r1))(2)(X(n2))(-90);
pcsimple(X(n2))(0)(X(nb))(0);
pcsimple(X(n2))(-90)(X(n4))(180);
pcsimple(X(n4))(180)(X(r3))(2);
pcsimple(X(n4))(-90)(X(r4))(2);
pcsimple(X(r4))(1)(X(n3))(90);
pcsimple(X(r3))(1)(X(n3))(180);
pcsimple(X(n3))(180)(X(r2))(2);
