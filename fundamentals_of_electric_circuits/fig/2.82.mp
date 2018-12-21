newRa.X(r1) "angle(90)";
ObjMLP.X(r1)("20\Omega")(is)(rt);
newRa.X(r2) "angle(90)";
ObjMLP.X(r2)("10\Omega")(is)(rt);
newRa.X(r3) "angle(90)";
ObjMLP.X(r3)("20\Omega")(is)(rt);
newICS.X(u1) "angle(90)";
ObjMLP.X(u1)("3A")(in)(lft);
newICS.X(u2) "angle(-90)";
ObjMLP.X(u2)("4A")(in)(rt);
newICS.X(u3) "angle(90)";
ObjMLP.X(u3)("-2A")(in)(lft);
ObjMLP.X(u3)("V")(is)(rt);
ObjMLP.X(u3)("+")(ise)(rt);
ObjMLP.X(u3)("-")(isw)(rt);

newCDM.X(m0);
ObjMLP.X(m0)("I")(in)(top);

newNode.X(n1);
newNode.X(n2);

X(u1).c = origin;
X(r1).c = X(u1).c + UD(5,0);
X(r2).c = X(r1).c + UD(5,0);
X(u2).c = X(r2).c + UD(5,0);
X(r3).c = X(u2).c + UD(5,0);
X(u3).c = X(r3).c + UD(7,0);
X(n1).c = X(u1).c + UD(0,3);
X(n2).c = X(u1).c + UD(0,-3);
X(m0).s = (xpart (X(r2).c + X(u2).c)/2, ypart X(n1).c);

drawObj(X(r1),X(r2),X(r3),X(u1),X(u2),X(u3),X(m0));
pcsimple(X(n1))(-90)(X(u1))(2);
pcsimple(X(n1))(0)(X(r1))(2);
pcsimple(X(n1))(0)(X(r2))(2);
pcsimple(X(n1))(0)(X(r3))(2);
pcsimple(X(n1))(0)(X(u2))(1);
pcsimple(X(n1))(0)(X(u3))(2);
pcsimple(X(n2))(90)(X(u1))(1);
pcsimple(X(n2))(0)(X(r1))(1);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
pcsimple(X(n2))(0)(X(u2))(2);
pcsimple(X(n2))(0)(X(u3))(1);
