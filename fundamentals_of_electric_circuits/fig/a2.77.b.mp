XnewRa.r1;
XObjMLP.r1("300 \Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("20 \Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("20 \Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("1.8 \Omega")(in)(top);

XnewNode.na "pathfillcolor(White)";
XObjMLP.na("a")(in)(top);
XnewNode.nb "pathfillcolor(White)";
XObjMLP.nb("b")(in)(top);

XnewNode.no;
XnewNode.n1;
XnewNode.n2;

X(no).c = origin;
X(n1).c = X(no).c + UD(-3,0);
X(n2).c = X(no).c + UD(3,0);
X(r2).c = X(no).c + UD(0,1.5);
X(r3).c = X(no).c + UD(0,-1.5);
X(r1).c = X(n1).c + UD(-3,0);
X(r4).c = X(n2).c + UD(3,0);
X(na).c = X(r1).c + UD(-3,0);
X(nb).c = X(r4).c + UD(3,0);

Xpclist(
	"na,0,r1,1",
	"r1,2,n1,0",
	"n1,90,r2,1",
	"n1,-90,r3,1",
	"r2,2,n2,-90",
	"r3,2,n2,90",
	"n2,0,r4,1",
	"r4,2,nb,0"
);

XdrawObj(na,nb,r1,r2,r3,r4);
