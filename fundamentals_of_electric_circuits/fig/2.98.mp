newRa.X(r1);
ObjMLabel.X(r1)("50\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r2);
ObjMLabel.X(r2)("70\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r3);
ObjMLabel.X(r3)("150\Omega") "labpoint(in)", "labdir(top)";
newRa.X(r4) "angle(90)";
ObjMLabel.X(r4)("400\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r5) "angle(90)";
ObjMLabel.X(r5)("400\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r6) "angle(90)";
ObjMLabel.X(r6)("200\Omega") "labpoint(in)", "labdir(lft)";
newRa.X(r7);
ObjMLabel.X(r7)("130\Omega") "labpoint(is)", "labdir(bot)";
newRa.X(r8);
ObjMLabel.X(r8)("50\Omega") "labpoint(is)", "labdir(bot)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("600V") "labpoint(in)", "labdir(lft)";


newNode.X(n1);

numeric uc;
uc := 10;
X(n1).c = origin;

X(r2).c = X(n1).c + (0,3uc);
X(r7).c = X(n1).c + (0,-3uc);
X(r4).c = X(n1).c + (-3uc,0);
X(r5).c = X(n1).c + (3uc,0);
X(r6).c = X(r5).c + (6uc,0);
X(u1).c = X(r4).c + (-6uc,0);

X(r1).c = (xpart (X(u1).c + X(r4).c)/2, ypart X(r2).c);
X(r3).c = (xpart (X(r5).c + X(r6).c)/2, ypart X(r2).c);
X(r8).c = (xpart (X(r5).c + X(r6).c)/2, ypart X(r7).c);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7),X(r8),X(u1));
pcsimple(X(u1))(2)(X(r1))(1);
pcsimple(X(u1))(1)(X(r7))(1);

pcsimple(X(r4))(2)(X(r1))(2);
pcsimple(X(r4))(2)(X(r2))(1);
pcsimple(X(r5))(2)(X(r2))(2);
pcsimple(X(r5))(2)(X(r3))(1);
pcsimple(X(r6))(2)(X(r3))(2);
pcsimple(X(r6))(1)(X(r8))(2);
pcsimple(X(r4))(1)(X(r7))(1);
pcsimple(X(r5))(1)(X(r7))(2);
pcsimple(X(r5))(1)(X(r8))(1);
