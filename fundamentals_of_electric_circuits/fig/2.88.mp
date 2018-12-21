newRa.X(r1);
ObjMLP.X(r1)("R_1")(in)(top);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("R_2")(in)(lft);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("R_3")(in)(lft);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("R_4")(in)(lft);
ObjMLP.X(r4)("+")(isw)(rt);
ObjMLP.X(r4)("-")(ise)(rt);
ObjMLP.X(r4)("V_o")(is)(rt);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("V_s")(in)(lft);
newDCS.X(u2) "angle(-90)";
ObjMLP.X(u2)("\alpha I_o")(is)(lft);

newCDM.X(m0);
ObjMLP.X(m0)("I_o")(in)(top);

newNode.X(n1);
newNode.X(n2);

X(u1).c = origin;
X(n1).c = UD(0,-3);
X(r1).c = UD(5,3);
X(r2).c = X(u1).c + UD(8,0);
X(u2).c = X(r2).c + UD(5,0);
X(r3).c = X(u2).c + UD(4,0);
X(r4).c = X(r3).c + UD(4,0);
X(n2).c = X(u2).c + UD(0,3);
X(m0).sw = (xpart X(u1).c, ypart X(r1).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(u1),X(u2),X(m0));
pcsimple(X(u1))(2)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(u1))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(r2))(1);
pcsimple(X(n1))(0)(X(u2))(2);
pcsimple(X(n1))(0)(X(r3))(1);
pcsimple(X(n1))(0)(X(r4))(1);
pcsimple(X(u2))(1)(X(n2))(90);
pcsimple(X(n2))(0)(X(r3))(2);
pcsimple(X(n2))(0)(X(r4))(2);
