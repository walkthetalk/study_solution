newRa.X(r1);
ObjMLabel.X(r1)("80\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("24\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("50\Omega") "labpoint(in)", "labdir(top)";

newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("25\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("20\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r6) "angle(90)";
ObjMLabel.X(r6)("30\Omega") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(r6)("+") "labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r6)("-") "labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r6)("V_o")"labpoint(is)", "labdir(rt)";
newRa.X(r7) "angle(90)";
ObjMLabel.X(r7)("60\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r8) "angle(90)";
ObjMLabel.X(r8)("20\Omega") "labpoint(is)", "labdir(rt)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("20V") "labpoint(in)", "labdir(lft)";

newCDM.X(m1);
ObjMLabel.X(m1)("i") "labpoint(in)", "labdir(top)";


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

numeric uc;
uc := 10;
X(n3).c = origin;

X(u1).c = X(n3).c + (-6uc,0);
X(n1).c = X(u1).c + (0,6uc);
X(n2).c = X(u1).c + (0,-6uc);

X(r1).c = X(n1).c + (3uc,0);
X(r2).c = X(r1).c + (6uc,0);
X(r3).c = X(r2).c + (6uc,0);
X(r4).c = X(n3).c + (0,3uc);
X(r5).c = X(n3).c + (6uc,0);
X(r6).c = X(r5).c + (6uc,0);
X(r7).c = X(n3).c + (-2uc,-3uc);
X(r8).c = X(n3).c + (2uc,-3uc);

X(m1).se = X(r1).iw;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(r8),X(u1),X(m1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(u1))(1)(X(n2))(-90);

pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r4))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r5))(2);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(r6))(2);

pcsimple(X(n3))(90)(X(r4))(1);
pcsimple(X(n3))(180)(X(r7))(2);
pcsimple(X(n3))(0)(X(r8))(2);

pcsimple(X(n2))(0)(X(r7))(1);
pcsimple(X(n2))(0)(X(r8))(1);
pcsimple(X(n2))(0)(X(r5))(1);
pcsimple(X(n2))(0)(X(r6))(1);
