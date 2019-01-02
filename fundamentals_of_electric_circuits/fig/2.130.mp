XnewRa.r1 "angle(45)";
XObjMLP.r1("8 k\Omega")(in)(ulft);
XnewRa.r2 "angle(-45)";
XObjMLP.r2("15 k\Omega")(in)(urt);
XnewRa.r3 "angle(-45)";
XObjMLP.r3("12 k\Omega")(is)(llft);
XnewRa.r4 "angle(45)";
XObjMLP.r4("10 k\Omega")(is)(lrt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("25 V")(in)(lft);

XnewDEarth.de1;

XnewNode.n1 "visible(false)";
XnewNode.n2 "visible(false)";
XnewNode.n3 "visible(false)";
XnewNode.n4 "visible(false)";
XnewNode.n5 "visible(false)";
XObjMLP.n5("a")(ic)(rt);
XnewNode.n6 "visible(false)";
XObjMLP.n6("b")(ic)(lft);
XnewNode.n7 "visible(false)";
XObjMLP.n7("o")(ic)(ulft);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(-6,-6);
X(n3).c = X(n2).c + UD(6,-6);
X(n4).c = X(n3).c + UD(6,6);
X(n5).c = X(n2).c + UD(3,0);
X(n6).c = X(n4).c + UD(-3,0);
X(u1).c = X(n2).c + UD(-6,0);
X(n7).c = (xpart X(u1).c, ypart X(n3).c);
X(de1).c = X(n7).c + UD(0,-1);

X(r1).c = (X(n1).c + X(n2).c)/2;
X(r2).c = (X(n1).c + X(n4).c)/2;
X(r3).c = (X(n2).c + X(n3).c)/2;
X(r4).c = (X(n3).c + X(n4).c)/2;

Xpclist(
	"u1,2,n1,0",
	"r1,2,n1,45",
	"n1,-45,r2,1",
	"r2,2,n4,-45",
	"n2,45,r1,1",
	"n2,-45,r3,1",
	"r3,2,n3,-45",
	"n3,45,r4,1",
	"r4,2,n4,45",
	"n2,0,n5,0",
	"n6,0,n4,0",
	"u1,1,n7,-90",
	"n7,0,n3,0",
	"n7,-90,de1,1"
);
XdrawObj(r1,r2,r3,r4,u1,n5,n6,n7,de1);
