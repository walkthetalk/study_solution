newRa.X(r1);
ObjMLP.X(r1)("2.5\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("6\Omega")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("12\Omega")(in)(top);
newRa.X(r4);
ObjMLP.X(r4)("60\Omega")(in)(top);

newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("15\Omega")(is)(rt);
newRa.X(r6) "angle(90)";
ObjMLP.X(r6)("20\Omega")(is)(rt);
newRa.X(r7) "angle(135)";
ObjMLP.X(r7)("80\Omega")(is)(urt);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("35V")(in)(lft);

newCDM.X(m1);
ObjMLP.X(m1)("i_o")(in)(top);
newCDM.X(m2);
ObjMLP.X(m2)("R_{eq}")(iw)(lft);

newNode.X(n1);
newNode.X(n2);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(9,-9);

X(r7).c = (X(n1).c + X(n2).c)/2;
X(r4).c = X(n1).c + UD(0, 3);
X(r3).c = X(n1).c + UD(-3,0);
X(r2).c = X(r3).c + UD(0,-3);
X(r6).c = X(n1).c + UD(0,-6);
X(r5).c = X(r6).c + UD(-6,0);
X(r1).c = X(r2).c + UD(-6,0);
X(u1).c = X(r5).c + UD(-6,0);
X(m1).se = X(r1).iw;
X(m2).e = X(r5).n;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(m1),X(m2),X(u1));
pcsimple(X(n1))(180)(X(r3))(2);
pcsimple(X(n1))(-90)(X(r2))(2);
pcsimple(X(n1))(-90)(X(r6))(2);
pcsimple(X(n1))(-45)(X(r7))(2);
pcsimple(X(r7))(1)(X(n2))(-45);
pcsimple(X(r4))(2)(X(n2))(-90);
pcsimple(X(n2))(180)(X(r6))(1);
pcsimple(X(n2))(180)(X(r5))(1);
pcsimple(X(n2))(180)(X(u1))(1);
pcsimple(X(u1))(2)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r5))(2)(X(r3))(1);
pcsimple(X(r5))(2)(X(r4))(1);
