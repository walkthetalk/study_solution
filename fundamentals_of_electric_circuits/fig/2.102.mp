newRa.X(r1);
ObjMLabel.X(r1)("2.5\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("6\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("12\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r4);
ObjMLabel.X(r4)("60\Omega") "labpoint(in)", "labdir(top)";

newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("15\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r6) "angle(90)";
ObjMLabel.X(r6)("20\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r7) "angle(135)";
ObjMLabel.X(r7)("80\Omega") "labpoint(is)", "labdir(urt)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("35V") "labpoint(in)", "labdir(lft)";

newCDM.X(m1);
ObjMLabel.X(m1)("i_o") "labpoint(in)", "labdir(top)";
newCDM.X(m2);
ObjMLabel.X(m2)("R_{eq}") "labpoint(iw)", "labdir(lft)";

newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(n1).c = origin;
X(n2).c = X(n1).c + (9uc,-9uc);

X(r7).c = (X(n1).c + X(n2).c)/2;
X(r4).c = X(n1).c + (0, 3uc);
X(r3).c = X(n1).c + (-3uc,0);
X(r2).c = X(r3).c + (0,-3uc);
X(r6).c = X(n1).c + (0,-6uc);
X(r5).c = X(r6).c + (-6uc,0);
X(r1).c = X(r2).c + (-6uc,0);
X(u1).c = X(r5).c + (-6uc,0);
X(m1).se = X(r1).iw;
X(m2).e = X(r5).n;

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(m1),X(m2),X(u1));
pcsimple(X(n1))(180)(X(r3))(2);
pcsimple(X(n1))(-90)(X(r2))(2);
pcsimple(X(n1))(-90)(X(r6))(2);
pcsimple(X(n1))(-45)(X(r7))(2);
pcsimple(X(r7))(1)(X(n2))(-45);
pcsimple(X(r4))(2)(X(n2))(-90);
pcsimple(X(n2))(180)(X(r6))(1);
pcsimple(X(n2))(180)(X(r5))(1);
pcsimple(X(n2))(180)(X(u1))(1);
pcsimple(X(u1))(2)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r5))(2)(X(r3))(1);
pcsimple(X(r5))(2)(X(r4))(1);
