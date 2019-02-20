XnewRa.r1;
XObjMLP.r1("40\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("40\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("20\Omega")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("40\Omega")(is)(rt);

XnewDVS.u1;
XObjMLP.u1("300 V")(in)(top);
XnewDCS.u2 "angle(90)";
XObjMLP.u2("15 A")(is)(rt);

XnewDEarth.de1;

XnewNode.n1 "visible(false)";
XObjMLP.n1("1")(iw)(lft);
XnewNode.n2 "visible(false)";
XObjMLP.n2("2")(in)(top);
XnewNode.n3 "visible(false)";
XObjMLP.n3("3")(ie)(rt);
XnewNode.n4 "visible(false)";

X(n2).c = origin;
X(r1).c = X(n2).c + UD(-3,0);
X(r2).c = X(n2).c + UD(3,0);
X(n1).c = X(r1).c + UD(-3,0);
X(n3).c = X(r2).c + UD(3,0);

X(u1).c = X(n2).c + UD(0,4);
X(u2).c = X(n2).c + UD(0,-3);
X(r3).c = X(n1).c + UD(0,-3);
X(r4).c = X(n3).c + UD(0,-3);
X(n4).c = X(u2).c + UD(0,-3);
X(de1).c = X(n4).c + UD(0,-2);

Xpclist(
	"n1,0,r1,1",
	"r1,2,r2,1",
	"r2,2,n3,0",
	"n1,90,u1,1",
	"u1,2,n3,-90",
	"n1,-90,r3,2",
	"r3,1,n4,0",
	"n3,-90,r4,2",
	"r4,1,n4,180",
	"n2,-90,u2,2",
	"u2,1,n4,-90",
	"n4,-90,de1,1"
);

XdrawObj(r1,r2,r3,r4,u1,u2,de1,n1,n2,n3,n4);
