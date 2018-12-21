newRa.X(r1);
ObjMLP.X(r1)("25\Omega")(in)(top);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("20\Omega")(is)(rt);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("10\Omega")(is)(rt);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("50\Omega")(is)(rt);
newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("40\Omega")(is)(rt);

newCDM.X(m1);
ObjMLP.X(m1)("i_x")(in)(top);
newCDM.X(m2);
ObjMLP.X(m2)("i_o")(in)(top);

newNode.X(n1);
newNode.X(n2);

X(n1).c = UD(0,3);
X(n2).c = UD(0,-3);
X(r1).c = X(n1).c + UD(4,0);
X(r2).c = UD(7,0);
X(r3).c = X(r2).c + UD(4,0);
X(r4).c = X(r3).c + UD(4,0);
X(r5).c = X(r4).c + UD(4,0);

X(m1).sw = X(n1).c;
X(m2).s = (xpart (X(r4).c + X(r5).c)/2, ypart X(n1).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(m1),X(m2));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r1))(2)(X(r5))(2);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(r4))(1);
pcsimple(X(n2))(0)(X(r5))(1);
