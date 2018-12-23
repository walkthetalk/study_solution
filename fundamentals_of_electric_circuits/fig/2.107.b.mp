XnewRa.r1;
XObjMLP.r1("10\Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("80\Omega")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("60\Omega")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("20\Omega")(in)(lft);
XnewRa.r5 "angle(90)";
XObjMLP.r5("30\Omega")(in)(lft);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(iw)(lft);

XnewNode.n1;
XnewNode.n2;

X(na).c = origin;
X(nb).c = X(na).c + UD(0,-8);
X(r2).c = (X(na).c + X(nb).c)/2 + UD(3,0);
X(r1).c = X(na).c + UD(8,0);
X(n2).c = X(nb).c + UD(14,0);
X(n1).c = X(n2).c + UD(0,6);
X(r4).c = (X(n1).c + X(n2).c)/2;
X(r3).c = X(r4).c + UD(-5,0);
X(r5).c = X(r4).c + UD(5,0);

XdrawObj(r1,r2,r3,r4,r5,na,nb);
Xpclist(
	"na,0,r2,2",
	"na,0,r1,1",
	"r1,2,n1,-90",
	"n1,180,r3,2",
	"n1,-90,r4,2",
	"n1,0,r5,2",
	"nb,0,r2,1",
	"nb,0,r3,1",
	"nb,0,r4,1",
	"nb,0,r5,1"
);
