XnewRa.r1;
XObjMLP.r1("20\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("30\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("40\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("60\Omega")(in)(top);
XnewRa.r5;
XObjMLP.r5("50\Omega")(in)(top);
XnewRa.r6 "angle(90)";
XObjMLP.r6("10\Omega")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("80\Omega")(is)(rt);

XnewNode.n1 "pathfilled(false)";
XObjMLP.n1("a")(iw)(lft);
XnewNode.n2 "pathfilled(false)";
XObjMLP.n2("b")(iw)(lft);
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;

X(r6).c = origin;
X(r2).c = X(r6).c + UD(-3,3);
X(r3).c = X(r6).c + UD(3,3);
X(r4).c = X(r6).c + UD(-3,-3);
X(r5).c = X(r6).c + UD(3,-3);
X(n3).c = X(r6).c + UD(-6,0);
X(n4).c = X(r6).c + UD(6,0);
X(r1).c = X(n3).c + UD(-3,0);
X(n1).c = X(r1).c + UD(-3,0);
X(n2).c = X(n1).c + UD(0,-6);
X(r7).c = (xpart (X(n4).c + UD(2,0)), ypart (X(n1).c+X(n2).c)/2);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,n1,n2);
Xpclist(
	"n1,0,r1,1",
	"r1,2,n3,0",
	"n3,90,r2,1",
	"n3,-90,r4,1",
	"r2,2,r6,2",
	"r6,2,r3,1",
	"r3,2,n4,-90",
	"r4,2,r6,1",
	"r6,1,r5,1",
	"r5,2,n4,90",
	"n4,0,r7,2",
	"n2,0,r7,1"
);
