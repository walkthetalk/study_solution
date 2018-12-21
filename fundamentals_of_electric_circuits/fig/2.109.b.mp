newRa.X(r1);
ObjMLP.X(r1)("5\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("15\Omega")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("30\Omega")(in)(top);
newRa.X(r4);
ObjMLP.X(r4)("20\Omega")(in)(top);
newRa.X(r5);
ObjMLP.X(r5)("10\Omega")(in)(top);

newRa.X(r6) "angle(90)";
ObjMLP.X(r6)("25\Omega")(is)(rt);
newRa.X(r7) "angle(90)";
ObjMLP.X(r7)("12\Omega")(is)(rt);
newRa.X(r8) "angle(90)";
ObjMLP.X(r8)("60\Omega")(is)(rt);

newNode.X(na) "pathfilled(false)";
ObjMLP.X(na)("a")(iw)(lft);
newNode.X(nb) "pathfilled(false)";
ObjMLP.X(nb)("b")(iw)(lft);

newNode.X(n1);

X(r6).c = origin;
X(r1).c = X(r6).c + UD(-3,3);
X(r2).c = X(r6).c + UD(-3,-3);
X(r4).c = X(r6).c + UD(3,3);
X(r5).c = X(r6).c + UD(3,-3);
X(r3).c = X(r4).c + UD(0,6);
X(r8).c = X(r6).c + UD(6,0);
X(r7).c = X(r8).c + UD(0,6);
X(na).c = X(r1).c + UD(-3,0);
X(nb).c = X(r2).c + UD(-3,0);
X(n1).c = X(r4).c + UD(6,0);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(r8),X(na),X(nb));
pcsimple(X(na))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r4))(1);
pcsimple(X(r1))(2)(X(r6))(2);
pcsimple(X(r6))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(r7))(2);
pcsimple(X(r3))(2)(X(n1))(-90);
pcsimple(X(r4))(2)(X(r7))(1);
pcsimple(X(r4))(2)(X(r8))(2);
pcsimple(X(nb))(0)(X(r2))(1);
pcsimple(X(r2))(2)(X(r6))(1);
pcsimple(X(r2))(2)(X(r5))(1);
pcsimple(X(r5))(2)(X(r8))(1);
pcsimple(X(r5))(2)(X(n1))(90);
