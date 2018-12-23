XnewRa.r1;
XObjMLP.r1("8\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("2\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("1\Omega")(in)(top);
XnewRa.r4 "angle(90)";
XObjMLP.r4("4\Omega")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("6\Omega")(is)(rt);
XnewRa.r6 "angle(90)";
XObjMLP.r6("2\Omega")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("15V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("I")(in)(top);
XnewCDM.m2;
XObjMLP.m2("R_{eq}")(in)(top);

XnewNode.n1;
XnewNode.n2;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);
X(u1).c = (X(n1).c + X(n2).c)/2;

X(r1).c = X(n1).c + UD(5,0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = X(r2).c + UD(6,0);
X(r4).c = (xpart (X(r1).c+X(r2).c)/2, ypart X(u1).c);
X(r5).c = (xpart (X(r2).c+X(r3).c)/2, ypart X(u1).c);
ypart X(r6).c = ypart X(u1).c;
xpart X(r3).c = xpart (X(r5).c+X(r6).c)/2;
X(m1).se = X(r1).w;
X(m2).e = X(r4).nw;

XdrawObj(r1,r2,r3,r4,r5,r6,u1,m1,m2);
Xpclist(
	"n1,0,r1,1",
	"n1,-90,u1,2",
	"r1,2,r2,1",
	"r1,2,r4,2",
	"r2,2,r3,1",
	"r2,2,r5,2",
	"r3,2,r6,2",
	"u1,1,n2,-90",
	"n2,0,r4,1",
	"n2,0,r5,1",
	"n2,0,r6,1"
);
