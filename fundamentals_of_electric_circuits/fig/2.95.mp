newRa.X(r1);
ObjMLabel.X(r1)("3\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2) "angle(-90)";
ObjMLabel.X(r2)("4\Omega") "labpoint(is)", "labdir(lft)";
newRa.X(r4) "angle(-90)";
ObjMLabel.X(r4)("1\Omega") "labpoint(is)", "labdir(lft)";
newRa.X(r5) "angle(-90)";
ObjMLabel.X(r5)("2\Omega") "labpoint(is)", "labdir(lft)";

newCDM.X(m1);
ObjMLabel.X(m1)("i_1") "labpoint(in)", "labdir(top)";
newCDM.X(m2) "angle(-90)";
ObjMLabel.X(m2)("i_2") "labpoint(in)", "labdir(rt)";
newCDM.X(m3) "angle(-90)";
ObjMLabel.X(m3)("i_3") "labpoint(in)", "labdir(rt)";
newCDM.X(m4) "angle(-90)";
ObjMLabel.X(m4)("i_4") "labpoint(in)", "labdir(rt)";
newCDM.X(m5) "angle(-90)";
ObjMLabel.X(m5)("i_5") "labpoint(in)", "labdir(rt)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("200V") "labpoint(in)", "labdir(lft)";


newNode.X(n1);
newNode.X(n2);
newNode.X(n3);
newNode.X(n4);
newNode.X(n5);

numeric uc;
uc := 10;
X(u1).c = origin;
X(n1).c = X(u1).c + (0, 6uc);
X(n2).c = X(u1).c + (0, -4uc);
X(r1).c = X(n1).c + (3uc,0);
X(n3).c = X(r4).c + (-uc, 5uc);
X(n4).c = X(n3).c + (4uc, -uc);
X(r2).c = X(u1).c + (5uc,0);
X(r4).c = X(r2).c + (5uc,0);
X(r5).c = X(r4).c + (5uc,0);
X(n5).c = X(r4).c + (-uc,-3uc);
X(m1).sw = X(r1).e;
X(m2).se = X(r2).w;
X(m3).se = X(n4).c;
X(m4).s = X(r4).n;
X(m5).s = X(r5).n;

drawObj(X(r1),X(r2),X(r4),X(r5),X(u1),X(m1),X(m2),X(m3),X(m4),X(m5));
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(n3))(-90);
pcsimple(X(n3))(180)(X(r2))(1);
pcsimple(X(n3))(0)(X(n4))(-90);
pcsimple(X(n4))(180)(X(r4))(1);
pcsimple(X(n4))(0)(X(r5))(1);
pcsimple(X(n5))(180)(X(r2))(2);
pcsimple(X(n5))(0)(X(r4))(2);
pcsimple(X(n5))(0)(X(r5))(2);
pcsimple(X(n2))(0)(X(n5))(90);
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(u1))(1)(X(n2))(-90);
