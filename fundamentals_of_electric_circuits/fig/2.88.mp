newRa.X(r1);
ObjMLabel.X(r1)("R_1") "labpoint(in)", "labdir(top)";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("R_2") "labpoint(in)", "labdir(lft)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("R_3") "labpoint(in)", "labdir(lft)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("R_4") "labpoint(in)", "labdir(lft)";
ObjMLabel.X(r4)("+") "labpoint(isw)", "labdir(rt)";
ObjMLabel.X(r4)("-") "labpoint(ise)", "labdir(rt)";
ObjMLabel.X(r4)("V_o") "labpoint(is)", "labdir(rt)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("V_s") "labpoint(in)", "labdir(lft)";
newDCS.X(u2) "angle(-90)";
ObjMLabel.X(u2)("\alpha I_o") "labpoint(is)", "labdir(lft)";

newCDM.X(m0);
ObjMLabel.X(m0)("I_o") "labpoint(in)", "labdir(top)";

newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(u1).c = origin;
X(n1).c = (0,-3uc);
X(r1).c = (5uc,3uc);
X(r2).c = X(u1).c + (8uc,0);
X(u2).c = X(r2).c + (5uc,0);
X(r3).c = X(u2).c + (4uc,0);
X(r4).c = X(r3).c + (4uc,0);
X(n2).c = X(u2).c + (0,3uc);
X(m0).sw = (xpart X(u1).c, ypart X(r1).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(u1),X(u2),X(m0));
pcsimple(X(u1))(2)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(u1))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(r2))(1);
pcsimple(X(n1))(0)(X(u2))(2);
pcsimple(X(n1))(0)(X(r3))(1);
pcsimple(X(n1))(0)(X(r4))(1);
pcsimple(X(u2))(1)(X(n2))(90);
pcsimple(X(n2))(0)(X(r3))(2);
pcsimple(X(n2))(0)(X(r4))(2);
