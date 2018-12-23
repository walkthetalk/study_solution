XnewRa.r1 "angle(-120)";
XnewRa.r2 "angle(-60)";
XObjMLP.r2("30\Omega")(in)(rt);
XnewRa.r3;
XnewRa.r4 "angle(-120)";
XnewRa.r5 "angle(-60)";
XnewRa.r6 "angle(-120)";
XnewRa.r7 "angle(-60)";
XnewRa.r8;
XnewRa.r9;

XnewNode.n1 "pathfilled(false)";
XObjMLP.n1("a")(iw)(lft);
XnewNode.n2 "pathfilled(false)";
XObjMLP.n2("b")(iw)(lft);
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;
XnewNode.n7;
XnewNode.n8;

X(n4).c = origin;
X(n5).c = X(n4).c + UD(8,0);
X(n3).c = X(n4).c + (X(n5).c-X(n4).c) rotated 60;
X(n7).c = X(n4).c + (X(n5).c-X(n4).c) rotated -60;
X(n6).c = X(n7).c + (X(n4).c-X(n5).c);
X(n8).c = X(n7).c + (X(n5).c-X(n4).c);
X(n2).c = X(n6).c + UD(-2,0);
X(n1).c = (xpart X(n2).c, ypart X(n3).c);

X(r1).c = (X(n3).c + X(n4).c)/2;
X(r2).c = (X(n3).c + X(n5).c)/2;
X(r3).c = (X(n4).c + X(n5).c)/2;
X(r4).c = (X(n4).c + X(n6).c)/2;
X(r5).c = (X(n4).c + X(n7).c)/2;
X(r6).c = (X(n5).c + X(n7).c)/2;
X(r7).c = (X(n5).c + X(n8).c)/2;
X(r8).c = (X(n6).c + X(n7).c)/2;
X(r9).c = (X(n7).c + X(n8).c)/2;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,r9,n1,n2);
Xpclist(
	"n1,0,n3,0",
	"r1,1,n3,60",
	"n3,-60,r2,1",
	"n4,60,r1,2",
	"n4,0,r3,1",
	"n4,-60,r5,1",
	"n4,-120,r4,1",
	"n5,120,r2,2",
	"n5,180,r3,2",
	"n5,-120,r6,1",
	"n5,-60,r7,1",
	"n2,0,n6,0",
	"n6,60,r4,2",
	"n6,0,r8,1",
	"n7,0,r9,1",
	"n7,60,r6,2",
	"n7,120,r5,2",
	"n7,180,r8,2",
	"n8,120,r7,2",
	"r9,2,n8,0"
);
