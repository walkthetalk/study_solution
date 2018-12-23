XnewRa.r1;
XObjMLP.r1("30\Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("10\Omega")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("60\Omega")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("R")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("12\Omega")(is)(rt);
XnewRa.r6 "angle(90)";
XObjMLP.r6("12\Omega")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("12\Omega")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("R_{eq}")(in)(top);

XnewNode.n1 "pathfilled(false)";
XnewNode.n2 "pathfilled(false)";
XnewNode.n3;
XnewNode.n4;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);

X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(r1).c + UD(3,3);
X(n3).c = X(r2).c + UD(0,3);
X(r3).c = X(r1).c + UD(3,-3);
X(r4).c = X(r2).c + UD(8,0);
X(r6).c = X(n4).c + UD(0,-3);
X(r5).c = X(r6).c + UD(-4,0);
X(r7).c = X(r6).c + UD(4,0);
X(n4).c = (X(r4).c + X(r6).c)/2;

X(m1).w = (X(n1).c + X(n2).c)/2;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,n1,n2,m1);
Xpclist(
	"n1,0,r1,1",
	"r1,2,r2,1",
	"r1,2,r3,2",
	"r2,2,n3,90",
	"n3,0,r4,2",
	"r4,1,n4,-90",
	"n4,180,r5,2",
	"n4,-90,r6,2",
	"n4,  0,r7,2",
	"n2,0,r3,1",
	"n2,0,r5,1",
	"n2,0,r6,1",
	"n2,0,r7,1"
);
