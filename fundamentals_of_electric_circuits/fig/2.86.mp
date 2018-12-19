newRa.X(r1) "angle(90)";
ObjMLabel.X(r1)("10\Omega") "labpoint(is)", "labdir(rt)";
newRa.X(r2);
ObjMLabel.X(r2)("10\Omega") "labpoint(is)", "labdir(bot)";
ObjMLabel.X(r2)("+") "labpoint(inw)", "labdir(top)";
ObjMLabel.X(r2)("V_0") "labpoint(in)", "labdir(top)", "labshift((0,10))";
ObjMLabel.X(r2)("-") "labpoint(ine)", "labdir(top)";
newICS.X(u1) "angle(90)";
ObjMLabel.X(u1)("25A") "labpoint(in)", "labdir(lft)";
newDCS.X(u2) "angle(90)";
ObjMLabel.X(u2)("2V_0") "labpoint(is)", "labdir(rt)";

numeric uc;
uc := 10;
X(r1).c = (-4uc, 0);
X(r2).c = (0, 3uc);
X(u1).c = (4uc, 0);
X(u2).c = X(u1).c + (3uc,0);

drawObj(X(r1),X(r2),X(u1),X(u2));
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(u1))(2);
pcsimple(X(r2))(2)(X(u2))(2);
pcsimple(X(r1))(1)(X(u1))(1) "armA(uc)";
pcsimple(X(r1))(1)(X(u2))(1) "armA(uc)";
