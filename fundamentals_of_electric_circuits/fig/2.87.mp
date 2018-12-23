XnewRa.r1;
XObjMLP.r1("5\Omega")(in)(top);
XObjMLP.r1("+")(isw)(bot);
XObjMLP.r1("-")(ise)(bot);
XObjMLP.r1("v_x")(is)(bot) "labshift(UD(0,-1))";
XnewRa.r2;
XObjMLP.r2("6\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("10\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("20\Omega")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("40\Omega")(in)(lft);
XnewRa.r6 "angle(90)";
XObjMLP.r6("60\Omega")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("15\Omega")(is)(rt);
XnewRa.r8 "angle(90)";
XObjMLP.r8("30\Omega")(is)(rt);

XnewICS.u1 "angle(-90)";
XObjMLP.u1("60A")(is)(lft);

XnewNode.n1;
XnewNode.n2;

X(r4).c = UD(0,3);
X(r7).c = UD(-2,-3);
X(r8).c = UD(2, -3);
X(r1).c = UD(-3, 6);
X(r2).c = UD(3, 6);
X(r3).c = UD(-6, 0);
X(r5).c = UD(6, 0);
X(r6).c = X(r5).c + UD(3, 0);
X(u1).c = X(r3).c + UD(-3, 0);
X(n1).c = origin;
X(n2).c = X(u1).c + UD(0,-6);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,u1);
Xpclist(
	"r1,2,r4,2",
	"r2,1,r4,2",
	"r2,2,r5,2",
	"r2,2,r6,2",
	"r4,1,n1,-90",
	"n1,180,r7,2",
	"n1,0,r8,2",
	"r1,1,r3,2",
	"r1,1,u1,1",
	"n2,90,u1,2",
	"n2,0,r3,1",
	"n2,0,r5,1",
	"n2,0,r6,1",
	"n2,0,r7,1",
	"n2,0,r8,1"
);
