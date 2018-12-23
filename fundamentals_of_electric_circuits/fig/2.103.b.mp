XnewRa.r1;
XObjMLP.r1("3k\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("2k\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("6k\Omega")(in)(top);
XnewRa.r4 "angle(90)";
XObjMLP.r4("6k\Omega")(in)(lft);

XnewNode.n1 "pathfilled(false)";
XnewNode.n2 "pathfilled(false)";
XnewNode.n3;
XnewNode.n4;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);
X(n3).c = X(n1).c + UD(1.5,3);
X(n4).c = (xpart X(n3).c + UD(6), ypart X(n1).c);

X(r1).c = (xpart X(n4).c, ypart X(n3).c);
X(r2).c = X(n4).c + UD(-3, 0);
X(r3).c = X(n4).c + UD(3,0);
X(r4).c = X(n4).c + UD(6,-3);

XdrawObj(r1,r2,r3,r4,n1,n2);
Xpclist(
	"n1,0,r2,1",
	"n1,0,n3,90",
	"n3,0,r1,1",
	"r1,2,r4,2",
	"r2,2,n4,0",
	"n4,0,r3,1",
	"r3,2,r4,2",
	"n2,0,n4,90",
	"n2,0,r4,1"
);
