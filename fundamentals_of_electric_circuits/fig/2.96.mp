newRa.X(r1);
ObjMLP.X(r1)("50\Omega")(is)(bot);
newRa.X(r2);
ObjMLP.X(r2)("200\Omega")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("40\Omega")(is)(bot);
newRa.X(r4);
ObjMLP.X(r4)("60\Omega")(in)(top);

newCDM.X(m1);
ObjMLP.X(m1)("i_1")(is)(bot);
newCDM.X(m2);
ObjMLP.X(m2)("i_2")(in)(top);
newCDM.X(m3) "angle(180)";
ObjMLP.X(m3)("i_3")(in)(bot);
newCDM.X(m4) "angle(180)";
ObjMLP.X(m4)("i_4")(is)(top);

newICS.X(u1) "angle(-90)";
ObjMLP.X(u1)("16A")(in)(rt);


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);
newNode.X(n4);
newNode.X(n5);
newNode.X(n6);

X(u1).c = origin;
X(n1).c = X(u1).c + UD(3, 5);
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(u1).c + UD(-3,5);
X(n4).c = X(n3).c + UD(-6,0);
X(n5).c = X(u1).c + UD(10,-3);
X(n6).c = X(u1).c + UD(-10,-3);
X(r1).c = X(n1).c + UD(3,-2);
X(r2).c = X(n1).c + UD(3, 2);
X(r3).c = X(n3).c + UD(-3,-2);
X(r4).c = X(n3).c + UD(-3,2);

X(m1).ne = X(r1).w;
X(m2).se = X(r2).w;
X(m3).se = X(r3).e;
X(m4).ne = X(r4).e;

drawObj(X(r1),X(r2),X(r3),X(r4),X(u1),X(m1),X(m2),X(m3),X(m4));
pcsimple(X(n1))(180)(X(u1))(1);
pcsimple(X(n1))(90)(X(r2))(1);
pcsimple(X(n1))(-90)(X(r1))(1);

pcsimple(X(n2))(0)(X(n5))(-90);
pcsimple(X(n2))(90)(X(r2))(2);
pcsimple(X(n2))(-90)(X(r1))(2);

pcsimple(X(n3))(0)(X(u1))(1);
pcsimple(X(n3))(90)(X(r4))(2);
pcsimple(X(n3))(-90)(X(r3))(2);

pcsimple(X(n4))(180)(X(n6))(-90);
pcsimple(X(n4))(90)(X(r4))(1);
pcsimple(X(n4))(-90)(X(r3))(1);

pcsimple(X(n5))(180)(X(u1))(2);
pcsimple(X(n6))(0)(X(u1))(2);
