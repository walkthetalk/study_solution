XnewRa.r1;
XObjMLP.r1("10\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("40\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("20\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("30\Omega")(in)(top);
XnewRa.r5;
XObjMLP.r5("50\Omega")(in)(top);
XnewRa.r6 "angle(90)";
XObjMLP.r6("5\Omega")(is)(rt);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(iw)(lft);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(n2).c = UD(-3,0);
X(n3).c = UD(3,0);
X(r3).c = (X(n2).c+X(n3).c)/2 + UD(0,2);
X(r2).c = X(r3).c + UD(0,3);
X(r1).c = X(r2).c + UD(0,3);
X(r4).c = (X(n2).c+X(n3).c)/2 + UD(0,-2);
X(r5).c = X(r4).c + UD(0,-4);
X(n1).c = X(n2).c + UD(-2,0);
X(n4).c = X(n3).c + UD(2,0);
X(na).c = X(n1).c + UD(-2,0);
X(nb).c = (xpart X(na).c, ypart X(r5).c);
X(r6).c = X(n4).c + UD(0,-3);

XdrawObj(r1,r2,r3,r4,r5,r6,na,nb);
Xpclist(
	"na,0,n1,0",
	"n1,0,n2,0",
	"n1,90,r1,1",
	"n1,90,r2,1",
	"n2,90,r3,1",
	"n2,-90,r4,1",
	"r1,2,n4,-90",
	"r2,2,n4,-90",
	"r3,2,n3,-90",
	"r4,2,n3,90",
	"n3,0,n4,0",
	"n4,-90,r6,2",
	"nb,0,r5,1",
	"r5,2,r6,1"
);
