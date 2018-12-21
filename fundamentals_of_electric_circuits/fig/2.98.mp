newRa.X(r1);
ObjMLP.X(r1)("50\Omega")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("70\Omega")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("150\Omega")(in)(top);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("400\Omega")(in)(lft);
newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("400\Omega")(in)(lft);
newRa.X(r6) "angle(90)";
ObjMLP.X(r6)("200\Omega")(in)(lft);
newRa.X(r7);
ObjMLP.X(r7)("130\Omega")(is)(bot);
newRa.X(r8);
ObjMLP.X(r8)("50\Omega")(is)(bot);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("600V")(in)(lft);


newNode.X(n1);

X(n1).c = origin;

X(r2).c = X(n1).c + UD(0,3);
X(r7).c = X(n1).c + UD(0,-3);
X(r4).c = X(n1).c + UD(-3,0);
X(r5).c = X(n1).c + UD(3,0);
X(r6).c = X(r5).c + UD(6,0);
X(u1).c = X(r4).c + UD(-6,0);

X(r1).c = (xpart (X(u1).c + X(r4).c)/2, ypart X(r2).c);
X(r3).c = (xpart (X(r5).c + X(r6).c)/2, ypart X(r2).c);
X(r8).c = (xpart (X(r5).c + X(r6).c)/2, ypart X(r7).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(r8),X(u1));
pcsimple(X(u1))(2)(X(r1))(1);
pcsimple(X(u1))(1)(X(r7))(1);

pcsimple(X(r4))(2)(X(r1))(2);
pcsimple(X(r4))(2)(X(r2))(1);
pcsimple(X(r5))(2)(X(r2))(2);
pcsimple(X(r5))(2)(X(r3))(1);
pcsimple(X(r6))(2)(X(r3))(2);
pcsimple(X(r6))(1)(X(r8))(2);
pcsimple(X(r4))(1)(X(r7))(1);
pcsimple(X(r5))(1)(X(r7))(2);
pcsimple(X(r5))(1)(X(r8))(1);
