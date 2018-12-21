newRa.X(r1);
ObjMLP.X(r1)("R_1")(in)(top);
ObjMLP.X(r1)("+")(isw)(bot);
ObjMLP.X(r1)("-")(ise)(bot);
ObjMLP.X(r1)("v_1")(is)(bot) "labshift(UD(0,-1))";
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("R_2")(is)(rt);
ObjMLP.X(r2)("+")(ine)(lft);
ObjMLP.X(r2)("-")(inw)(lft);
ObjMLP.X(r2)("v_2")(in)(lft);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("R_3")(is)(rt);
ObjMLP.X(r3)("+")(ine)(lft);
ObjMLP.X(r3)("-")(inw)(lft);
ObjMLP.X(r3)("v_3")(in)(lft);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("V_s")(in)(lft);


newNode.X(n1);
newNode.X(n2);

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0, 4);
X(n2).c = X(u1).c + UD(0,-4);
X(r1).c = X(n1).c + UD(4,0);
X(r2).c = X(u1).c + UD(8,0);
X(r3).c = X(r2).c + UD(6,0);

drawObj(X(r1),X(r2),X(r3),X(u1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
