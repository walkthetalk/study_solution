XnewRa.r1;
XObjMLP.r1("2\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("4\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("5\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("5\Omega")(in)(top);
XnewRa.r5;
XObjMLP.r5("3\Omega")(in)(top);
XnewRa.r6;
XObjMLP.r6("10\Omega")(in)(top);
XnewRa.r7;
XObjMLP.r7("8\Omega")(in)(top);
XnewRa.r8;
XObjMLP.r8("4\Omega")(in)(top);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(ie)(rt);
XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(na).c = origin;
X(r1).c = X(na).c + UD(3, 0);
X(n1).c = X(r1).c + UD(3, -3);
X(r4).c = X(n1).c + UD(3,0);
X(r5).c = X(r4).c + UD(5,0);
X(n2).c = X(r5).c + UD(3,0);
X(r6).c = X(n2).c + UD(3,0);
X(n3).c = X(r6).c + UD(3,0);
X(r2).c = (xpart (X(r4).c+X(r5).c)/2, ypart X(r1).c);
X(r3).c = (xpart X(r6).c, ypart (X(r2).c));
X(nb).c = X(r3).c + UD(5,0);
X(r7).c = (X(r4).c+X(r5).c)/2 + UD(0,-3);
X(r8).c = (xpart X(r6).c, ypart X(r7).c);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,na,nb);
Xpclist(
	"na,0,r1,1",
	"r1,2,r2,1",
	"r2,2,r3,1",
	"r3,2,nb,0",
	"n1,90,r1,2",
	"n1,0,r4,1",
	"n1,-90,r7,1",
	"r4,2,r5,1",
	"r5,2,n2,0",
	"n2,90,r2,2",
	"n2,0,r6,1",
	"n2,-90,r7,2",
	"n2,-90,r8,1",
	"n3,90,nb,0",
	"n3,-90,r8,2",
	"n3,180,r6,2"
);
