XnewRa.r1;
XObjMLP.r1("80\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("24\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("50\Omega")(in)(top);

XnewRa.r4 "angle(90)";
XObjMLP.r4("25\Omega")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("20\Omega")(is)(rt);
XnewRa.r6 "angle(90)";
XObjMLP.r6("30\Omega")(in)(lft);
XObjMLP.r6("+")(ise)(rt);
XObjMLP.r6("-")(isw)(rt);
XObjMLP.r6("V_o")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("60\Omega")(in)(lft);
XnewRa.r8 "angle(90)";
XObjMLP.r8("20\Omega")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("20V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("i")(in)(top);


XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(n3).c = origin;

X(u1).c = X(n3).c + UD(-6,0);
X(n1).c = X(u1).c + UD(0,6);
X(n2).c = X(u1).c + UD(0,-6);
X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = X(r2).c + UD(6,0);
X(r4).c = X(n3).c + UD(0,3);
X(r5).c = X(n3).c + UD(6,0);
X(r6).c = X(r5).c + UD(6,0);
X(r7).c = X(n3).c + UD(-2,-3);
X(r8).c = X(n3).c + UD(2,-3);

X(m1).se = X(r1).iw;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,u1,m1);
Xpclist(
	"u1,2,n1,90",
	"u1,1,n2,-90",
	"n1,0,r1,1",
	"r1,2,r4,2",
	"r1,2,r2,1",
	"r2,2,r5,2",
	"r2,2,r3,1",
	"r3,2,r6,2",
	"n3,90,r4,1",
	"n3,180,r7,2",
	"n3,0,r8,2",
	"n2,0,r7,1",
	"n2,0,r8,1",
	"n2,0,r5,1",
	"n2,0,r6,1"
);
