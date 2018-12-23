XnewRa.r1;
XObjMLP.r1("25\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("10\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("20\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("30\Omega")(in)(top);
XnewRa.r5 "angle(90)";
XObjMLP.r5("5\Omega")(in)(lft);
XnewRa.r6 "angle(90)";
XObjMLP.r6("15\Omega")(in)(lft);

XnewNode.n1 "pathfilled(false)";
XObjMLP.n1("a")(iw)(lft);
XnewNode.n2 "pathfilled(false)";
XObjMLP.n2("b")(iw)(lft);
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);
X(r1).c = X(n1).c + UD(3,0);
X(n3).c = X(r1).c + UD(3,0);
X(r2).c = X(n3).c + UD(3,0);
X(n4).c = X(r2).c + UD(3,0);
X(r3).c = X(n4).c + UD(3,0);
X(n5).c = X(r3).c + UD(3,0);
X(r4).c = X(n4).c + UD(0,3);
X(r5).c = (xpart X(n4).c, ypart (X(n1).c + X(n2).c)/2);
X(r6).c = X(r5).c + UD(6,0);

XdrawObj(r1,r2,r3,r4,r5,r6,n1,n2);
Xpclist(
	"n1,0,r1,1",
	"r1,2,r2,1",
	"r2,2,r5,2",
	"r3,1,r5,2",
	"n3,90,r4,1",
	"r4,2,r6,2",
	"r3,2,r6,2",
	"n2,0,r5,1",
	"n2,0,r6,1"
);
