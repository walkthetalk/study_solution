XnewRa.r1;
XObjMLP.r1("20\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("30\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("30\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("8\Omega")(is)(rt);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(iw)(lft);

X(na).c = origin;
X(nb).c = X(na).c + UD(0,-6);
X(r3).c = (X(na).c + X(nb).c)/2 + UD(3,0);
X(r4).c = X(r3).c + UD(6,0);
X(r2).c = (X(r3).c + X(r4).c)/2 + UD(0,3);
X(r1).c = X(r2).c + UD(0,3);

XdrawObj(r1,r2,r3,r4,na,nb);
Xpclist(
	"na,0,r2,1",
	"na,0,r3,2",
	"r3,2,r1,1",
	"r1,2,r4,2",
	"r2,2,r4,2",
	"nb,0,r3,1",
	"nb,0,r4,1"
);
