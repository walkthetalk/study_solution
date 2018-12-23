XnewRa.r1 "angle(90)";
XObjMLP.r1("6\Omega")(in)(lft);
XnewRa.r2 "angle(90)";
XObjMLP.r2("6\Omega")(in)(lft);
XnewRa.r3;
XObjMLP.r3("3\Omega")(in)(top);
XnewRa.r4 "angle(90)";
XObjMLP.r4("3\Omega")(is)(rt);

XnewNode.n1 "pathfilled(false)";
XnewNode.n2 "pathfilled(false)";

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-12);

X(r1).c = X(n1).c + UD(3,-3);
X(r2).c = X(n2).c + UD(3, 3);
X(r4).c = X(r2).c + UD(6, 0);
X(r3).c = (xpart (X(r2).c + X(r4).c)/2, ypart (X(r1).c + X(r2).c)/2);

XdrawObj(r1,r2,r3,r4,n1,n2);
Xpclist(
	"n1,0,r1,2",
	"n1,0,r4,2",
	"r1,1,r3,1",
	"r2,2,r3,1",
	"r3,2,r4,2",
	"n2,0,r2,1",
	"n2,0,r4,1"
);
