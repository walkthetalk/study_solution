newRa.X(r1) "angle(90)";
ObjMLP.X(r1)("3\Omega")(is)(rt);
ObjMLP.X(r1)("p_4")(in)(lft);
newIVS.X(u1) "angle(180)";
ObjMLP.X(u1)("10V")(is)(top);
ObjMLP.X(u1)("p_1")(in)(bot);
newIVS.X(u2) "angle(90)";
ObjMLP.X(u2)("12V")(in)(lft);
ObjMLP.X(u2)("p_2")(is)(rt);
newIVS.X(u3) "angle(180)";
ObjMLP.X(u3)("-8V")(in)(bot);
ObjMLP.X(u3)("p_3")(is)(top);

newCDM.X(m0) "angle(-90)";
ObjMLP.X(m0)("I")(in)(rt);

X(r1).c = UD(3,0);
X(u1).c = UD(0,3);
X(u2).c = UD(-3,0);
X(u3).c = UD(0,-3);
X(m0).se = X(r1).ie;

drawObj(X(r1),X(u1),X(u2),X(u3),X(m0));
pcsimple(X(r1))(2)(X(u1))(1);
pcsimple(X(r1))(1)(X(u3))(1);
pcsimple(X(u2))(2)(X(u1))(2);
pcsimple(X(u2))(1)(X(u3))(2);
