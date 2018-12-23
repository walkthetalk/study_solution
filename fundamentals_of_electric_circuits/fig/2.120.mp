XnewRa.r1;
XObjMLP.r1("16\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("15\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("10\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("30\Omega")(in)(top);
XnewRa.r5 "angle(90)";
XObjMLP.r5("35\Omega")(is)(rt);
XObjMLP.r5("V")(in)(lft);
XObjMLP.r5("+")(ine)(lft);
XObjMLP.r5("-")(inw)(lft);
XnewRa.r6 "angle(90)";
XObjMLP.r6("12\Omega")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("20\Omega")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("100V")(in)(lft);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;
XnewNode.n7;
XnewNode.n8;
XnewNode.n9;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(n2).c + (X(n2).c-X(n1).c);
X(n4).c = X(n3).c + (X(n2).c-X(n1).c);
X(n5).c = X(n1).c + UD(0,-6);
X(n6).c = (xpart X(n2).c, ypart X(n5).c);
X(n7).c = (xpart X(n3).c, ypart X(n5).c);
X(n8).c = (xpart X(n4).c, ypart X(n5).c);
X(n9).c = X(n3).c + UD(0,3);

X(r1).c = (X(n1).c + X(n2).c)/2;
X(r2).c = (X(n2).c + X(n3).c)/2;
X(r3).c = (X(n3).c + X(n4).c)/2;
X(r4).c = X(n9).c;
X(r5).c = (X(n2).c + X(n6).c)/2;
X(r6).c = (X(n3).c + X(n7).c)/2;
X(r7).c = (X(n4).c + X(n8).c)/2;
X(u1).c = (X(n1).c + X(n5).c)/2;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,u1);
Xpclist(
	"u1,2,n1,90",
	"n1,0,r1,1",
	"r1,2,r5,2",
	"r1,2,r2,1",
	"n2,90,r4,1",
	"r2,2,r6,2",
	"r2,2,r3,1",
	"r3,2,r7,2",
	"r4,2,r7,2",
	"u1,1,n5,-90",
	"n5,0,r5,1",
	"n5,0,r6,1",
	"n5,0,r7,1"
);
