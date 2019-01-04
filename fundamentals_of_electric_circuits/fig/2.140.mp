XnewICS.u1 "angle(90)";
XObjMLP.u1("1A")(in)(lft);
XnewRa.r1;
XObjMLP.r1("R_1")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_2")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("5 k\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("10 k\Omega")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("10 k\Omega")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("R_{in}")(iw)(lft);
XnewCDM.m2;
XObjMLP.m2("I_L")(n)(top);

XnewNode.n1 "pathfilled(true)", "pathfillcolor(White)";
XnewNode.n2 "pathfilled(true)", "pathfillcolor(White)";

X(u1).c = origin;
X(r3).c = X(u1).c + UD(3,0);
X(n1).c = X(r3).c + UD(6,3);
X(n2).c = X(r3).c + UD(6,-3);
X(r4).c = X(r3).c + UD(9,0);
X(r2).c = X(r4).c + UD(6,0);
X(r5).c = X(r2).c + UD(6,0);
X(r1).c = (X(r4).c + X(r2).c)/2 + UD(0,3);
X(m2).s = (X(r2).c + X(r5).c)/2 + UD(0,3);
X(m1).ie = X(r4).n;

Xpclist(
	"u1,2,n1,0",
	"r3,2,n1,0",
	"n1,0,r4,2",
	"n1,0,r1,1",
	"r1,2,r2,2",
	"r1,2,r5,2",
	"u1,1,n2,0",
	"r3,1,n2,0",
	"n2,0,r4,1",
	"n2,0,r2,1",
	"n2,0,r5,1"
);

XdrawObj(u1,r1,r2,r3,r4,r5,n1,n2,m1,m2);
