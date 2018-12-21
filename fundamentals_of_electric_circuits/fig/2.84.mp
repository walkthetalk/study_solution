newRa.X(r1);
ObjMLP.X(r1)("22\Omega")(in)(top);
newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("54V")(in)(lft);
newDVS.X(u2) "angle(90)";
ObjMLP.X(u2)("5i_0")(is)(rt);

newCDM.X(m0);
ObjMLP.X(m0)("i_0")(in)(top);

newNode.X(n1);
newNode.X(n2);

X(n1).c = origin;
X(u1).c = X(n1).c + UD(0,-3);
X(n2).c = X(u1).c + UD(0,-3);
X(r1).c = X(n1).c + UD(4,0);
X(u2).c = X(u1).c + UD(8,0);
X(m0).sw = X(n1).c;

drawObj(X(r1),X(u1),X(u2),X(m0));
pcsimple(X(r1))(2)(X(u2))(2);
pcsimple(X(r1))(1)(X(u1))(2);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(u2))(1);
