XnewRa.r1;
XObjMLP.r1("5\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("20\Omega")(is)(bot);
XnewRa.r3 "angle(90)";
XObjMLP.r3("10\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("40\Omega")(is)(rt);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(iw)(lft);

XnewNode.n1;
XnewNode.n2;

X(na).c = origin;
X(nb).c = X(na).c + UD(0,-6);
X(n1).c = X(na).c + UD(2,0);
X(n2).c = X(n1).c + UD(6,0);
X(r1).c = (X(n1).c + X(n2).c)/2 + UD(0,1.5);
X(r2).c = (X(n1).c + X(n2).c)/2 + UD(0,-1.5);
X(r3).c = (xpart (X(n2).c + UD(2,0)),
		ypart (X(na).c + X(nb).c)/2);
X(r4).c = X(r3).c + UD(4,0);

XdrawObj(r1,r2,r3,r4,na,nb);
Xpclist(
	"na,0,n1,0",
	"n1,90,r1,1",
	"n1,-90,r2,1",
	"r1,2,n2,-90",
	"r2,2,n2,90",
	"n2,0,r3,2",
	"n2,0,r4,2",
	"nb,0,r3,1",
	"nb,0,r4,1"
);
