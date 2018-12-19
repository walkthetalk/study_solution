newRa.X(r1);
ObjMLabel.X(r1)("R_1") "labpoint(in)", "labdir(top)";
ObjMLabel.X(r1)("+") "labpoint(isw)", "labdir(bot)";
ObjMLabel.X(r1)("-") "labpoint(ise)", "labdir(bot)";
ObjMLabel.X(r1)("v_1") "labpoint(is)", "labdir(bot)", "labshift((0,-10))";
newRa.X(r2) "angle(90)";
ObjMLabel.X(r2)("R_2") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(r2)("+") "labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r2)("-") "labpoint(inw)", "labdir(lft)";
ObjMLabel.X(r2)("v_2") "labpoint(in)", "labdir(lft)";
newRa.X(r3) "angle(90)";
ObjMLabel.X(r3)("R_3") "labpoint(is)", "labdir(rt)";
ObjMLabel.X(r3)("+") "labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r3)("-") "labpoint(inw)", "labdir(lft)";
ObjMLabel.X(r3)("v_3") "labpoint(in)", "labdir(lft)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("V_s") "labpoint(in)", "labdir(lft)";


newNode.X(n1);
newNode.X(n2);

numeric uc;
uc := 10;
X(u1).c = origin;
X(n1).c = X(u1).c + (0, 4uc);
X(n2).c = X(u1).c + (0,-4uc);
X(r1).c = X(n1).c + (4uc,0);
X(r2).c = X(u1).c + (8uc,0);
X(r3).c = X(r2).c + (6uc,0);

drawObj(X(r1),X(r2),X(r3),X(u1));
pcsimple(X(u1))(2)(X(n1))(90);
pcsimple(X(n1))(0)(X(r1))(1);
pcsimple(X(r1))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r3))(2);
pcsimple(X(u1))(1)(X(n2))(-90);
pcsimple(X(n2))(0)(X(r2))(1);
pcsimple(X(n2))(0)(X(r3))(1);
