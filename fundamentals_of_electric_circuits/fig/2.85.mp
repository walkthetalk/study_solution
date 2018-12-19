newRa.X(r1);
ObjMLabel.X(r1)("1\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("2\Omega") "labpoint(is)", "labdir(bot)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("5\Omega") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(r3)("+") "labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r3)("V_x") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(r3)("-") "labpoint(isw)", "labdir(rt)";
newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("15V") "labpoint(in)", "labdir(lft)";
newDVS.X(u2) "angle(180)";
ObjMLabel.X(u2)("2V_x") "labpoint(is)", "labdir(top)";

numeric uc;
uc := 10;
X(r1).c = (-3uc, 3uc);
X(u2).c = (3uc, 3uc);
X(r2).c = (0, -3uc);
X(r3).c = (6uc, 0);
X(u1).c = (-6uc,0);

drawObj(X(r1),X(r2),X(r3),X(u1),X(u2));
pcsimple(X(r1))(2)(X(u2))(2);
pcsimple(X(r1))(1)(X(u1))(2);
pcsimple(X(u1))(1)(X(r2))(1);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(2)(X(u2))(1);
