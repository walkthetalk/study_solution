newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("20\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("10\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("20\Omega") "labpoint(is)", "labdir(rt)";
newICS.X(u1) "angle(90)";
ObjMLabel.X(u1)("3A") "labpoint(in)", "labdir(lft)";
newICS.X(u2) "angle(-90)";
ObjMLabel.X(u2)("4A") "labpoint(in)", "labdir(rt)";
newICS.X(u3) "angle(90)";
ObjMLabel.X(u3)("-2A") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(u3)("V") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(u3)("+") "labpoint(ise)", "labdir(rt)";
ObjMLabel.X(u3)("-") "labpoint(isw)", "labdir(rt)";

newCDM.X(m0);
ObjMLabel.X(m0)("I") "labpoint(in)", "labdir(top)";

newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 15;
X(u1).c = origin;
X(r1).c = X(u1).c + (3uc,0);
X(r2).c = X(r1).c + (3uc,0);
X(u2).c = X(r2).c + (3uc,0);
X(r3).c = X(u2).c + (3uc,0);
X(u3).c = X(r3).c + (4.5uc,0);
X(n1).c = X(u1).c + (0,2uc);
X(n2).c = X(u1).c + (0,-2uc);
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
