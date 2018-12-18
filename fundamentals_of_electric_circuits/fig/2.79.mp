newR.X(r1) "angle(90)";
ObjMLabel.X(r1)("4V") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(r1)("+") "labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r1)("-") "labpoint(inw)", "labdir(lft)";
newR.X(r2);
ObjMLabel.X(r2)("16V") "labpoint(in)", "labdir(top)", "labshift((0,10))";
ObjMLabel.X(r2)("+") "labpoint(inw)", "labdir(top)";
ObjMLabel.X(r2)("-") "labpoint(ine)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("v") "labpoint(in)", "labdir(top)", "labshift((0,10))";
ObjMLabel.X(r3)("+") "labpoint(inw)", "labdir(top)";
ObjMLabel.X(r3)("-") "labpoint(ine)", "labdir(top)";
ObjMLabel.X(r3)("12\Omega") "labpoint(is)", "labdir(bot)";
newIVS.X(u0) "angle(90)";
ObjMLabel.X(u0)("10V") "labpoint(in)", "labdir(lft)";
newDVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("3i_x") "labpoint(is)", "labdir(rt)";

newCDM.X(m0) "angle(-90)";
ObjMLabel.X(m0)("i_x") "labpoint(in)", "labdir(rt)";

numeric uc;
uc := 10;
X(r1).c = origin;
X(r2).c = X(r1).c + (3uc, 4uc);
X(r3).c = X(r1).c + (-3uc,4uc);
X(u0).c = X(r1).c + (-6uc,0);
X(u1).c = X(r1).c + (6uc,0);
X(m0).se = X(r1).ie;

numeric strarm;
strarm := 3uc + ypart (X(r1).iw - X(r1).c);

pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(u0))(2)(X(r3))(1);
pcsimple(X(u1))(2)(X(r2))(2);
pcsimple(X(r1))(1)(X(u0))(1) "armA(strarm)";
pcsimple(X(r1))(1)(X(u1))(1) "armA(strarm)";

drawObj(X(r1),X(r2),X(r3),X(u0),X(u1),X(m0));
