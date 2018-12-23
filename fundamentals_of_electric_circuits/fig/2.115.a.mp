XnewRa.r1 "angle(90)";
XObjMLP.r1("10\Omega")(in)(lft);
XnewRa.r2 "angle(90)";
XObjMLP.r2("10\Omega")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("20\Omega")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("20\Omega")(in)(lft);
XnewRa.r5;
XObjMLP.r5("10\Omega")(in)(top);
XnewRa.r6 "angle(90)";
XObjMLP.r6("30\Omega")(in)(lft);

XnewNode.n1 "pathfilled(false)";
XObjMLP.n1("a")(iw)(lft);
XnewNode.n2 "pathfilled(false)";
XObjMLP.n2("b")(iw)(lft);
XnewNode.n3;
XnewNode.n4;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-12);
X(r6).c = (X(n1).c + X(n2).c)/2 + UD(3,0);
X(n3).c = X(r6).c + UD(4,0);
X(n4).c = X(n3).c + UD(6,0);
X(r5).c = (X(n3).c+X(n4).c)/2;
X(r1).c = X(n3).c + UD(0,3);
X(r2).c = X(n3).c + UD(0,-3);
X(r3).c = X(n4).c + UD(0,3);
X(r4).c = X(n4).c + UD(0,-3);

XdrawObj(r1,r2,r3,r4,r5,r6,n1,n2);
Xpclist(
	"r6,2,n1,180",
	"r6,1,n2,180",
	"n1,0,r1,2",
	"n1,0,r3,2",
	"r1,1,r5,1",
	"r3,1,r5,2",
	"r2,2,r5,1",
	"r4,2,r5,2",
	"n2,0,r2,1",
	"n2,0,r4,1"
);
