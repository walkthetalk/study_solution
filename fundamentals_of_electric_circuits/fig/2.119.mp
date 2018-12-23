XnewRa.r1 "angle(90)";
XObjMLP.r1("400\Omega")(is)(rt);
XnewRa.r2 "angle(90)";
XObjMLP.r2("700\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("800\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("1.7k\Omega")(is)(rt);
XnewRa.r5;
XObjMLP.r5("200\Omega")(in)(top);
XnewRa.r6;
XObjMLP.r6("400\Omega")(in)(top);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("100V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("I_o")(in)(top);

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
X(n2).c = X(n1).c + UD(3,0);
X(n3).c = X(n2).c + UD(6,0);
X(n4).c = (X(n1).c + X(n7).c)/2;
X(n5).c = (xpart X(n2).c, ypart X(n4).c);
X(n6).c = (xpart X(n3).c, ypart X(n4).c);
X(n7).c = X(n1).c + UD(0,-12);
X(n8).c = (xpart X(n2).c, ypart X(n7).c);
X(n9).c = (xpart X(n3).c, ypart X(n7).c);

X(r1).c = (X(n2).c + X(n5).c)/2;
X(r2).c = (X(n3).c + X(n6).c)/2;
X(r3).c = (X(n5).c + X(n8).c)/2;
X(r4).c = (X(n6).c + X(n9).c)/2;
X(r5).c = (X(n5).c + X(n6).c)/2;
X(r6).c = (X(n8).c + X(n9).c)/2;
X(u1).c = X(n4).c;

X(m1).ssw = X(n1).c;

XdrawObj(r1,r2,r3,r4,r5,r6,u1,m1);
Xpclist(
	"u1,2,n1,90",
	"n1,0,r1,2",
	"n1,0,r2,2",
	"r1,1,r5,1",
	"r1,1,r3,2",
	"r5,2,r2,1",
	"r5,2,r4,2",
	"u1,1,n7,-90",
	"n7,0,r3,1",
	"n7,0,r6,1",
	"r6,2,r4,1"
);
