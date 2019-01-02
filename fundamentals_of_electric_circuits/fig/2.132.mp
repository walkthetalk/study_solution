XnewRa.r1;
XObjMLP.r1("1 \Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("1 \Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("1 \Omega")(in)(top);
XnewRa.r4;
XObjMLP.r4("1 \Omega")(in)(top);
XnewRa.r5;
XObjMLP.r5("1 \Omega")(in)(top);
XnewRa.r6 "angle(90)";
XObjMLP.r6("2 \Omega")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("10 V")(in)(lft);

XnewDEarth.de1;

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;

X(r6).c = origin;
X(r2).c = X(r6).c + UD(-3,3);
X(r3).c = X(r6).c + UD(3,3);
X(r4).c = X(r6).c + UD(-3,-3);
X(r5).c = X(r6).c + UD(3,-3);
X(n1).c = X(r6).c + UD(-6,0);
X(n2).c = X(r6).c + UD(6,0);
X(r1).c = X(n1).c + UD(-3,0);
X(n3).c = X(r4).c + UD(0,-3);
X(u1).c = X(r1).c + UD(-3,-3);
X(n4).c = X(n3).c + UD(12,0);
X(de1).c = X(n3).c + UD(0,-1);

Xpclist(
	"u1,2,r1,1",
	"r1,2,n1,0",
	"n1,90,r2,1",
	"n1,-90,r4,1",
	"r2,2,r6,2",
	"r6,2,r3,1",
	"r3,2,n2,-90",
	"n1,-90,r4,1",
	"r4,2,r6,1",
	"r5,1,r6,1",
	"r5,2,n2,90",
	"n2,0,n4,-90",
	"u1,1,n3,0",
	"n3,0,n4,0",
	"n3,-90,de1,1"
);
XdrawObj(r1,r2,r3,r4,r5,r6,u1,de1);
