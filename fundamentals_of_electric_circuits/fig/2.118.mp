XnewRa.r1;
XObjMLP.r1("10\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("450\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("300\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("300\Omega")(is)(rt);
XnewRa.r5;
XObjMLP.r5("450\Omega")(is)(bot);
XnewRa.r6;
XObjMLP.r6("60\Omega")(is)(bot);

XnewNode.n1;
XObjMLP.n1("a")(iw)(lft);
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XObjMLP.n4("c")(ie)(rt);
XnewNode.n5;
XObjMLP.n5("b")(iw)(lft);
XnewNode.n6;
XnewNode.n7;
XnewNode.n8;
XObjMLP.n8("d")(ie)(rt);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(n2).c + (X(n2).c - X(n1).c);
X(n4).c = X(n3).c + (X(n2).c - X(n1).c);
X(n5).c = X(n1).c + UD(0,-6);
X(n6).c = (xpart X(n2).c, ypart X(n5).c);
X(n7).c = (xpart X(n3).c, ypart X(n5).c);
X(n8).c = (xpart X(n4).c, ypart X(n5).c);

X(r1).c = (X(n1).c + X(n2).c)/2;
X(r2).c = (X(n2).c + X(n3).c)/2;
X(r3).c = (X(n2).c + X(n6).c)/2;
X(r4).c = (X(n3).c + X(n7).c)/2;
X(r5).c = (X(n6).c + X(n7).c)/2;
X(r6).c = (X(n7).c + X(n8).c)/2;

XdrawObj(r1,r2,r3,r4,r5,r6,n1,n4,n5,n8);
Xpclist(
	"n1,0,r1,1",
	"r1,2,r3,2",
	"r1,2,r2,1",
	"r2,2,n4,0",
	"r2,2,r4,2",
	"n5,0,r3,1",
	"n5,0,r5,1",
	"r5,2,r4,1",
	"r5,2,r6,1",
	"r6,2,n8,0"
);
