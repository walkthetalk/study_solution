XnewRa.r1;
XObjMLP.r1("2.5\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("6\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("12\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("60\Omega")(in)(top);

XnewRa.r5 "angle(90)";
XObjMLP.r5("15\Omega")(is)(rt);
XnewRa.r6 "angle(90)";
XObjMLP.r6("20\Omega")(is)(rt);
XnewRa.r7 "angle(135)";
XObjMLP.r7("80\Omega")(is)(urt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("35V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("i_o")(in)(top);
XnewCDM.m2;
XObjMLP.m2("R_{eq}")(iw)(lft);

XnewNode.n1;
XnewNode.n2;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(9,-9);

X(r7).c = (X(n1).c + X(n2).c)/2;
X(r4).c = X(n1).c + UD(0, 3);
X(r3).c = X(n1).c + UD(-3,0);
X(r2).c = X(r3).c + UD(0,-3);
X(r6).c = X(n1).c + UD(0,-6);
X(r5).c = X(r6).c + UD(-6,0);
X(r1).c = X(r2).c + UD(-6,0);
X(u1).c = X(r5).c + UD(-6,0);
X(m1).se = X(r1).iw;
X(m2).e = X(r5).n;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,m1,m2,u1);
Xpclist(
	"n1,180,r3,2",
	"n1,-90,r2,2",
	"n1,-90,r6,2",
	"n1,-45,r7,2",
	"r7,1,n2,-45",
	"r4,2,n2,-90",
	"n2,180,r6,1",
	"n2,180,r5,1",
	"n2,180,u1,1",
	"u1,2,r1,1",
	"r1,2,r2,1",
	"r5,2,r3,1",
	"r5,2,r4,1"
);
