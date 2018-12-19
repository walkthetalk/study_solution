newRa.X(r1);
ObjMLabel.X(r1)("22\Omega") "labpoint(in)", "labdir(top)";
newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("54V") "labpoint(in)", "labdir(lft)";
newDVS.X(u2) "angle(90)";
ObjMLabel.X(u2)("5i_0") "labpoint(is)", "labdir(rt)";

newCDM.X(m0);
ObjMLabel.X(m0)("i_0") "labpoint(in)", "labdir(top)";

numeric uc;
uc := 10;
X(r1).c = (0,3uc);
X(u1).c = (-4uc,0);
X(u2).c = (4uc,0);
X(m0).sw = (xpart X(u1).c, ypart X(r1).c);

drawObj(X(r1),X(u1),X(u2),X(m0));
pcsimple(X(r1))(2)(X(u2))(2);
pcsimple(X(r1))(1)(X(u1))(2);
pcsimple(X(u1))(1)(X(u2))(1) "armA(20)";
