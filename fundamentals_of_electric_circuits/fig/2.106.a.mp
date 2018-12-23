XnewRa.r1;
XObjMLP.r1("5\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("8\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("20\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("30\Omega")(in)(top);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(ie)(rt);
XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(na).c = origin;
X(n1).c = X(na).c + UD(2, 0);
X(n3).c = X(n1).c + UD(6, -2);
X(n4).c = X(n3).c + UD(6,0);
X(n2).c = X(n4).c + UD(1, 3);
X(nb).c = X(n2).c + UD(2, 0);

X(r1).c = X(n1).c + UD(5,1);
X(r2).c = X(n3).c + UD(-3,0);
X(r3).c = (X(n3).c + X(n4).c)/2;
X(r4).c = X(r3).c + UD(0,-3);

XdrawObj(r1,r2,r3,r4,na,nb);
Xpclist(
	"na,0,n1,0",
	"n1,90,r1,1",
	"n1,-90,r2,1",
	"r1,2,n2,-90",
	"n2,0,nb,0",
	"n2,-90,n4,180",
	"n4,180,r3,2",
	"n4,-90,r4,2",
	"r4,1,n3,90",
	"r3,1,n3,180",
	"n3,180,r2,2"
);
