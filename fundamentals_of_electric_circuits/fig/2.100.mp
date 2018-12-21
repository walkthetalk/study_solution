newRa.X(r1);
ObjMLP.X(r1)("80\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("24\Omega")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("50\Omega")(in)(top);

newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("25\Omega")(is)(rt);
newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("20\Omega")(is)(rt);
newRa.X(r6) "angle(90)";
ObjMLP.X(r6)("30\Omega")(in)(lft);
ObjMLP.X(r6)("+")(ise)(rt);
ObjMLP.X(r6)("-")(isw)(rt);
ObjMLP.X(r6)("V_o")(is)(rt);
newRa.X(r7) "angle(90)";
ObjMLP.X(r7)("60\Omega")(in)(lft);
newRa.X(r8) "angle(90)";
ObjMLP.X(r8)("20\Omega")(is)(rt);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("20V")(in)(lft);

newCDM.X(m1);
ObjMLP.X(m1)("i")(in)(top);


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

X(n3).c = origin;

X(u1).c = X(n3).c + UD(-6,0);
X(n1).c = X(u1).c + UD(0,6);
X(n2).c = X(u1).c + UD(0,-6);
X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = X(r2).c + UD(6,0);
X(r4).c = X(n3).c + UD(0,3);
X(r5).c = X(n3).c + UD(6,0);
X(r6).c = X(r5).c + UD(6,0);
X(r7).c = X(n3).c + UD(-2,-3);
X(r8).c = X(n3).c + UD(2,-3);

X(m1).se = X(r1).iw;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(r8),X(u1),X(m1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(u1))(1)(X(n2))(-90);

pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r5))(2);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(r6))(2);

pcsimple(X(n3))(90)(X(r4))(1);
pcsimple(X(n3))(180)(X(r7))(2);
pcsimple(X(n3))(0)(X(r8))(2);

pcsimple(X(n2))(0)(X(r7))(1);
pcsimple(X(n2))(0)(X(r8))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
