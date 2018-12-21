newRa.X(r1);
ObjMLP.X(r1)("30\Omega")(in)(top);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("10\Omega")(in)(lft);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("60\Omega")(in)(lft);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("R")(is)(rt);
newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("12\Omega")(is)(rt);
newRa.X(r6) "angle(90)";
ObjMLP.X(r6)("12\Omega")(is)(rt);
newRa.X(r7) "angle(90)";
ObjMLP.X(r7)("12\Omega")(is)(rt);

newCDM.X(m1);
ObjMLP.X(m1)("R_{eq}")(in)(top);

newNode.X(n1) "pathfilled(false)";
newNode.X(n2) "pathfilled(false)";
newNode.X(n3);
newNode.X(n4);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);

X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(r1).c + UD(3,3);
X(n3).c = X(r2).c + UD(0,3);
X(r3).c = X(r1).c + UD(3,-3);
X(r4).c = X(r2).c + UD(8,0);
X(r6).c = X(n4).c + UD(0,-3);
X(r5).c = X(r6).c + UD(-4,0);
X(r7).c = X(r6).c + UD(4,0);
X(n4).c = (X(r4).c + X(r6).c)/2;

X(m1).w = (X(n1).c + X(n2).c)/2;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(n1),X(n2),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(r2))(2)(X(n3))(90);
pcsimple(X(n3))(0)(X(r4))(2);
pcsimple(X(r4))(1)(X(n4))(-90);
pcsimple(X(n4))(180)(X(r5))(2);
pcsimple(X(n4))(-90)(X(r6))(2);
pcsimple(X(n4))(  0)(X(r7))(2);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
pcsimple(X(n2))(0)(X(r7))(1);
