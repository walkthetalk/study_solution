newR.X(r0);
ObjMLabel.X(r0)("-")
	"labpoint(ine)", "labdir(ulft)";
ObjMLabel.X(r0)("+")
	"labpoint(inw)", "labdir(urt)";
ObjMLabel.X(r0)("12V")
	"labpoint(n)", "labdir(top)", "labshift((0,10))";
ObjMLabel.X(r0)("p_2")
	"labpoint(is)", "labdir(bot)";

newR.X(r1) "angle(90)";
ObjMLabel.X(r1)("+")
	"labpoint(ine)", "labdir(lft)";
ObjMLabel.X(r1)("-")
	"labpoint(inw)", "labdir(lft)";
ObjMLabel.X(r1)("V_0")
	"labpoint(n)", "labdir(lft)";
ObjMLabel.X(r1)("p_3")
	"labpoint(is)", "labdir(rt)";

newR.X(r2);
ObjMLabel.X(r2)("-")
	"labpoint(ise)", "labdir(llft)";
ObjMLabel.X(r2)("+")
	"labpoint(isw)", "labdir(lrt)";
ObjMLabel.X(r2)("28V")
	"labpoint(is)", "labdir(bot)", "labshift((0,-10))";
ObjMLabel.X(r2)("p_4")
	"labpoint(ie)", "labdir(urt)";

newR.X(r3);
ObjMLabel.X(r3)("-")
	"labpoint(ise)", "labdir(llft)";
ObjMLabel.X(r3)("+")
	"labpoint(isw)", "labdir(lrt)";
ObjMLabel.X(r3)("28V")
	"labpoint(is)", "labdir(bot)", "labshift((0,-10))";
ObjMLabel.X(r3)("p_5")
	"labpoint(ie)", "labdir(urt)";

newDVS.X(u2) "angle(-90)";
ObjMLabel.X(u2)("5I_0")
	"labpoint(in)", "labdir(rt)";
ObjMLabel.X(u2)("p_6")
	"labpoint(is)", "labdir(lft)";

newIVS.X(u1) "angle(90)";
ObjMLabel.X(u1)("30V")
	"labpoint(in)", "labdir(lft)";
ObjMLabel.X(u1)("p_1")
	"labpoint(is)", "labdir(rt)";

newCDM.X(cdm0) "angle(90)";
ObjMLabel.X(cdm0)("6A")
	"labpoint(in)", "labdir(lft)";
newCDM.X(cdm1);
ObjMLabel.X(cdm1)("6A")
	"labpoint(in)", "labdir(top)";
newCDM.X(cdm2) "angle(-90)";
ObjMLabel.X(cdm2)("3A")
	"labpoint(is)", "labdir(lft)";
newCDM.X(cdm3);
ObjMLabel.X(cdm3)("1A")
	"labpoint(in)", "labdir(top)";
newCDM.X(cdm4);
ObjMLabel.X(cdm4)("I_0=2A")
	"labpoint(in)", "labdir(top)";
newCDM.X(cdm5) "angle(-90)";
ObjMLabel.X(cdm5)("3A")
	"labpoint(in)", "labdir(rt)";

numeric uc;
uc := 10;
X(r1).c = origin;
X(r0).c = X(r1).c + (-5uc, 4uc);
X(r2).c = X(r1).c + ( 5uc, 4uc);
X(r3).c = X(r2).c + (   0, 5uc);
X(u1).c = X(r1).c + (-10uc,0);
X(u2).c = X(r1).c + ( 10uc,0);
X(cdm0).ssw = (xpart X(u1).c, ypart X(r1).c - 4uc);
X(cdm1).ssw = (xpart X(u1).c, ypart X(r1).c + 4uc);
X(cdm2).ne  = X(r1).e;
X(cdm3).sw  = (xpart X(r1).c, ypart X(r2).c);
X(cdm4).sw  = (xpart X(r1).c, ypart X(r3).c);
X(cdm5).sse = (xpart X(u2).c, ypart X(r1).c - 4uc);

drawObj(X(r0),X(r1),X(r2),X(r3),X(u1),X(u2));

save _sl; string _sl; _sl := "armA(4uc - ypart(X(r1).c - X(r1).iw))";
pcsimple(X(u1))(2)(X(r0))(1);
pcsimple(X(r0))(2)(X(r1))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r3))(1);
pcsimple(X(r2))(2)(X(u2))(1);
pcsimple(X(r3))(2)(X(u2))(1);
pcsimple(X(r1))(1)(X(u2))(2) _sl;
pcsimple(X(r1))(1)(X(u1))(1) _sl;
drawObj(X(cdm0), X(cdm1), X(cdm2), X(cdm3), X(cdm4), X(cdm5)); 
