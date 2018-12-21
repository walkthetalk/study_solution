newIVS.X(v0)"angle(90)";
ObjMLP.X(v0)("12V")(in)(lft);
newRa.X(r0);
ObjMLP.X(r0)("1\Omega")(in)(top);
newRa.X(r1) "angle(90)";
ObjMLP.X(r1)("8\Omega")(is)(rt);
newRa.X(r2);
ObjMLP.X(r2)("4\Omega")(in)(top);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("5\Omega")(is)(rt);
newICS.X(c0) "angle(-90)";
ObjMLP.X(c0)("2A")(in)(rt);

X(v0).c = origin;
X(r0).c = X(v0).c + UD(3,3);
X(r1).c = X(v0).c + UD(6,0);
X(r2).c = X(r0).c + UD(6,0);
X(r3).c = X(r1).c + UD(6,0);
X(c0).c = X(r3).c + UD(6,0);

drawObj(X(v0),X(r0),X(r1),X(r2),X(r3),X(c0));
pcsimple(X(v0))(2)(X(r0))(1);
pcsimple(X(r0))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(c0))(1);
pcsimple(X(r0))(2)(X(r1))(2);
pcsimple(X(r2))(2)(X(r3))(2);
pcsimple(X(r1))(1)(X(v0))(1);
pcsimple(X(r1))(1)(X(r3))(1);
pcsimple(X(r3))(1)(X(c0))(2); 
