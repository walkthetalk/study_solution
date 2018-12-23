XnewRa.r1;
XObjMLP.r1("72\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("24\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("80\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("20\Omega")(in)(top);
XnewRa.r5;
XObjMLP.r5("14\Omega")(in)(top);
XnewRa.r6;
XObjMLP.r6("36\Omega")(in)(top);
XnewRa.r7;
XObjMLP.r7("36\Omega")(in)(top);
XnewRa.r8;
XObjMLP.r8("36\Omega")(in)(top);
XnewRa.r9 "angle(90)";
XObjMLP.r9("10\Omega")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("140V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("I")(in)(top);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;

X(u1).c = origin;
X(m1).s = X(u1).c + UD(3,4);
X(n1).c = X(m1).s + UD(3,0);
X(n2).c = X(n1).c + UD(6,0);
X(r1).c = (X(n1).c + X(n2).c)/2 + UD(0,1.5);
X(r2).c = (X(n1).c + X(n2).c)/2 + UD(0,-1.5);
X(n3).c = X(n2).c + UD(3,0);
X(n4).c = X(n3).c + UD(6,0);
X(r3).c = (X(n3).c + X(n4).c)/2 + UD(0,1.5);
X(r4).c = (X(n3).c + X(n4).c)/2 + UD(0,-1.5);

X(r5).c = X(u1).c + UD(3,-4);
X(r7).c = (xpart (X(n2).c+X(n3).c)/2, ypart X(r5).c);
X(n6).c = X(r7).c + UD(3,0);
X(n5).c = X(r7).c + UD(-3,0);
X(r6).c = X(r7).c + UD(0,3);
X(r8).c = X(r7).c + UD(0,-3);
X(r9).c = X(n4).c + UD(2,-3);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,r9,u1,m1);
Xpclist(
	"u1,2,n1,0",
	"n1,90,r1,1",
	"n1,-90,r2,1",
	"r1,2,n2,-90",
	"r2,2,n2,90",
	"n2,0,n3,0",
	"n3,90,r3,1",
	"n3,-90,r4,1",
	"r3,2,n4,-90",
	"r4,2,n4,90",
	"n4,0,r9,2",
	"u1,1,r5,1",
	"r5,2,n5,0",
	"n5,90,r6,1",
	"n5,0,r7,1",
	"n5,-90,r8,1",
	"r6,2,n6,-90",
	"r7,2,n6,0",
	"r8,2,n6,90",
	"n6,0,r9,1"
);
