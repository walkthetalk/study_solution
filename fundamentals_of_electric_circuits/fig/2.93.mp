newRa.X(r1);
ObjMLP.X(r1)("R")(in)(top);
newRa.X(r2);
ObjMLP.X(r2)("R")(in)(top);
newRa.X(r3);
ObjMLP.X(r3)("R")(in)(top);
newRa.X(r4) "angle(90)";
ObjMLP.X(r4)("R")(is)(rt);
newRa.X(r5) "angle(90)";
ObjMLP.X(r5)("R")(is)(rt);
newRa.X(r6) "angle(90)";
ObjMLP.X(r6)("R")(is)(rt);
newRa.X(r7) "angle(90)";
ObjMLP.X(r7)("R")(is)(rt);

newCDM.X(m1);
ObjMLP.X(m1)("R_{eq}")(in)(top);


newNode.X(n1);
newNode.X(n2);

X(n1).c = X(n2).c + UD(0, 9);
X(n2).c = UD(0, -6);
X(r4).c = X(n2).c + UD(3, 3);
X(r5).c = X(r4).c + UD(5,0);
X(r6).c = X(r5).c + UD(6,0);
X(r7).c = X(r6).c + UD(6,0);
X(r3).c = (xpart (X(r6).c+X(r7).c)/2, ypart X(n2).c);
X(r2).c = (X(r6).c+X(r5).c)/2 + UD(0,3);
X(r1).c = (xpart X(r2).c, ypart X(n1).c);
X(m1).e = (xpart X(r4).c, ypart X(r2).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(m1));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(n1))(0)(X(r4))(2);
pcsimple(X(r1))(2)(X(r7))(2);
pcsimple(X(r2))(1)(X(r4))(2);
pcsimple(X(r2))(1)(X(r5))(2);
pcsimple(X(r2))(2)(X(r6))(2);
pcsimple(X(r2))(2)(X(r7))(2);
pcsimple(X(n2))(0)(X(r4))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(r3))(2)(X(r7))(1);
