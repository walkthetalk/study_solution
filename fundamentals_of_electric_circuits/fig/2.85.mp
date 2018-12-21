newRa.X(r1);
ObjMLP.X(r1)("1\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("2\Omega")(is)(bot);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("5\Omega")(in)(lft);
ObjMLP.X(r3)("+")(ise)(rt);
ObjMLP.X(r3)("V_x")(is)(rt);
ObjMLP.X(r3)("-")(isw)(rt);
newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("15V")(in)(lft);
newDVS.X(u2) "angle(180)";
ObjMLP.X(u2)("2V_x")(is)(top);

X(r1).c = UD(-3, 3);
X(u2).c = UD(3, 3);
X(r2).c = UD(0, -3);
X(r3).c = UD(6, 0);
X(u1).c = UD(-6,0);

drawObj(X(r1),X(r2),X(r3),X(u1),X(u2));
pcsimple(X(r1))(2)(X(u2))(2);
pcsimple(X(r1))(1)(X(u1))(2);
pcsimple(X(u1))(1)(X(r2))(1);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(u2))(1);
