XnewIVS.v0"angle(90)";
XObjMLP.v0("12V")(in)(lft);
XnewRa.r0;
XObjMLP.r0("1\Omega")(in)(top);
XnewRa.r1 "angle(90)";
XObjMLP.r1("8\Omega")(is)(rt);
XnewRa.r2;
XObjMLP.r2("4\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("5\Omega")(is)(rt);
XnewICS.c0 "angle(-90)";
XObjMLP.c0("2A")(in)(rt);

X(v0).c = origin;
X(r0).c = X(v0).c + UD(3,3);
X(r1).c = X(v0).c + UD(6,0);
X(r2).c = X(r0).c + UD(6,0);
X(r3).c = X(r1).c + UD(6,0);
X(c0).c = X(r3).c + UD(6,0);

XdrawObj(v0,r0,r1,r2,r3,c0);
Xpclist(
	"v0,2,r0,1",
	"r0,2,r2,1",
	"r2,2,c0,1",
	"r0,2,r1,2",
	"r2,2,r3,2",
	"r1,1,v0,1",
	"r1,1,r3,1",
	"r3,1,c0,2",
);
