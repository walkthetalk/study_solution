newRa.X(r1);
ObjMLP.X(r1)("8\Omega")(in)(top);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("3\Omega")(is)(rt);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("6\Omega")(is)(rt);

newCDM.X(m1);
ObjMLP.X(m1)("I_o")(is)(bot);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("10V")(in)(lft);


newNode.X(n1);
newNode.X(n2);

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0, 3);
X(n2).c = X(u1).c + UD(0,-3);
X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(u1).c + UD(6,0);
X(r3).c = X(r2).c + UD(4,0);

X(m1).n = X(r1).is;

drawObj(X(r1),X(r2),X(r3),X(u1),X(m1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
