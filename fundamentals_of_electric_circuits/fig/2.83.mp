newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("3\Omega") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(r1)("p_4") "labpoint(in)", "labdir(lft)";
newIVS.X(u1) "angle(180)";
ObjMLabel.X(u1)("10V") "labpoint(is)", "labdir(top)";
ObjMLabel.X(u1)("p_1") "labpoint(in)", "labdir(bot)";
newIVS.X(u2) "angle(90)";
ObjMLabel.X(u2)("12V") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(u2)("p_2") "labpoint(is)", "labdir(rt)";
newIVS.X(u3) "angle(180)";
ObjMLabel.X(u3)("-8V") "labpoint(in)", "labdir(bot)";
ObjMLabel.X(u3)("p_3") "labpoint(is)", "labdir(top)";

newCDM.X(m0) "angle(-90)";
ObjMLabel.X(m0)("I") "labpoint(in)", "labdir(rt)";

numeric uc;
uc := 30;
X(r1).c = (uc,0);
X(u1).c = (0,uc);
X(u2).c = (-uc,0);
X(u3).c = (0,-uc);
X(m0).se = X(r1).ie;

drawObj(X(r1),X(u1),X(u2),X(u3),X(m0));
pcsimple(X(r1))(2)(X(u1))(1);
pcsimple(X(r1))(1)(X(u3))(1);
pcsimple(X(u2))(2)(X(u1))(2);
pcsimple(X(u2))(1)(X(u3))(2);
