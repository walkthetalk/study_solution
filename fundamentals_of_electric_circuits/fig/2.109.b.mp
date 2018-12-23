XnewRa.r1;
XObjMLP.r1("5\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("15\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("30\Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("20\Omega")(in)(top);
XnewRa.r5;
XObjMLP.r5("10\Omega")(in)(top);

XnewRa.r6 "angle(90)";
XObjMLP.r6("25\Omega")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("12\Omega")(is)(rt);
XnewRa.r8 "angle(90)";
XObjMLP.r8("60\Omega")(is)(rt);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(iw)(lft);

XnewNode.n1;

X(r6).c = origin;
X(r1).c = X(r6).c + UD(-3,3);
X(r2).c = X(r6).c + UD(-3,-3);
X(r4).c = X(r6).c + UD(3,3);
X(r5).c = X(r6).c + UD(3,-3);
X(r3).c = X(r4).c + UD(0,6);
X(r8).c = X(r6).c + UD(6,0);
X(r7).c = X(r8).c + UD(0,6);
X(na).c = X(r1).c + UD(-3,0);
X(nb).c = X(r2).c + UD(-3,0);
X(n1).c = X(r4).c + UD(6,0);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,na,nb);
Xpclist(
	"na,0,r1,1",
	"r1,2,r4,1",
	"r1,2,r6,2",
	"r6,2,r3,1",
	"r3,2,r7,2",
	"r3,2,n1,-90",
	"r4,2,r7,1",
	"r4,2,r8,2",
	"nb,0,r2,1",
	"r2,2,r6,1",
	"r2,2,r5,1",
	"r5,2,r8,1",
	"r5,2,n1,90"
);
