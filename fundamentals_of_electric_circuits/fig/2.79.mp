newR.X(r1) "angle(90)";
ObjMLP.X(r1)("4V")(in)(lft);
ObjMLP.X(r1)("+")(ine)(lft);
ObjMLP.X(r1)("-")(inw)(lft);
newR.X(r2);
ObjMLP.X(r2)("16V")(in)(top) "labshift(UD(0,1))";
ObjMLP.X(r2)("+")(inw)(top);
ObjMLP.X(r2)("-")(ine)(top);
newRa.X(r3);
ObjMLP.X(r3)("v")(in)(top) "labshift(UD(0,1))";
ObjMLP.X(r3)("+")(inw)(top);
ObjMLP.X(r3)("-")(ine)(top);
ObjMLP.X(r3)("12\Omega")(is)(bot);
newIVS.X(u0) "angle(90)";
ObjMLP.X(u0)("10V")(in)(lft);
newDVS.X(u1) "angle(90)";
ObjMLP.X(u1)("3i_x")(is)(rt);

newCDM.X(m0) "angle(-90)";
ObjMLP.X(m0)("i_x")(in)(rt);

newNode.X(n1);

X(r1).c = origin;
X(r2).c = X(r1).c + UD(3, 4);
X(r3).c = X(r1).c + UD(-3,4);
X(u0).c = X(r1).c + UD(-6,0);
X(u1).c = X(r1).c + UD(6,0);
X(m0).se = X(r1).ie;
X(n1).c = X(r1).c + UD(0,-3);

pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(u0))(2)(X(r3))(1);
pcsimple(X(u1))(2)(X(r2))(2);
pcsimple(X(r1))(1)(X(n1))(-90);
pcsimple(X(n1))(180)(X(u0))(1);
pcsimple(X(n1))(0)(X(u1))(1);

drawObj(X(r1),X(r2),X(r3),X(u0),X(u1),X(m0));
