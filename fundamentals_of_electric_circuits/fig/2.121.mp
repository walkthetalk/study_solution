XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;
XnewNode.n7;
XnewNode.n8;
XnewNode.n9;
XnewNode.n10;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(n1).c + UD(0,-6);
X(n4).c = X(n1).c + UD(6,-6);
X(n5).c = X(n3).c + UD(0,-6);
X(n6).c = X(n3).c + UD(6,-6);
X(n7).c = X(n5).c + UD(0,-6);
X(n8).c = X(n5).c + UD(6,-6);
X(n9).c = X(n1).c + UD(-8,0);
X(n10).c = X(n7).c + UD(-8,0);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("50V")(in)(lft);
X(u1).c = (X(n9).c + X(n10).c)/2;

XnewRa.r1;
XObjMLP.r1("10\Omega")(in)(top);
X(r1).c = (X(n9).c + X(n1).c)/2;
XnewRa.r2;
XObjMLP.r2("25\Omega")(in)(top);
X(r2).c = (X(n1).c + X(n2).c)/2;
XnewRa.r3 "angle(90)";
XObjMLP.r3("10\Omega")(in)(lft);
X(r3).c = (X(n1).c + X(n3).c)/2;
XnewRa.r4 "angle(90)";
XObjMLP.r4("5\Omega")(is)(rt);
X(r4).c = (X(n2).c + X(n4).c)/2;

XnewRa.r5;
XObjMLP.r5("10\Omega")(in)(top);
X(r5).c = (X(n3).c + X(n4).c)/2;

XnewRa.r6 "angle(90)";
XObjMLP.r6("10\Omega")(in)(lft);
X(r6).c = (X(n3).c + X(n5).c)/2;
XnewRa.r7 "angle(90)";
XObjMLP.r7("20\Omega")(is)(rt);
X(r7).c = (X(n4).c + X(n6).c)/2;
XnewRa.r8;
XObjMLP.r8("80\Omega")(in)(top);
X(r8).c = (X(n5).c + X(n6).c)/2;

XnewRa.r9 "angle(90)";
XObjMLP.r9("10\Omega")(in)(lft);
X(r9).c = (X(n5).c + X(n7).c)/2;
XnewRa.r10 "angle(90)";
XObjMLP.r10("15\Omega")(is)(rt);
X(r10).c = (X(n6).c + X(n8).c)/2;

XnewRa.r11;
XObjMLP.r11("25\Omega")(in)(top);
X(r11).c = (X(n7).c + X(n8).c)/2;

XnewCDM.m1;
XObjMLP.m1("I")(in)(top);
X(m1).ssw = X(n9).c;
XnewCDM.m2;
XObjMLP.m2("R_{eq}")(in)(top);
X(m2).e = (X(u1).c + X(r6).c)/2;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,u1,m1,m2);
Xpclist(
	"u1,2,r1,1",
	"r2,1,r1,2",
	"r2,1,r3,2",
	"r2,2,r4,2",
	"r5,1,r3,1",
	"r5,1,r6,2",
	"r5,2,r4,1",
	"r5,2,r7,2",
	"r8,1,r6,1",
	"r8,1,r9,2",
	"r8,2,r7,1",
	"r8,2,r10,2",
	"r11,1,r9,1",
	"r11,1,u1,1",
	"r11,2,r10,1"
);
