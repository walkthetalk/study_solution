XnewRa.r1;
XObjMLP.r1("50\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("70\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("150\Omega")(in)(top);
XnewRa.r4 "angle(90)";
XObjMLP.r4("400\Omega")(in)(lft);
XnewRa.r5 "angle(90)";
XObjMLP.r5("400\Omega")(in)(lft);
XnewRa.r6 "angle(90)";
XObjMLP.r6("200\Omega")(in)(lft);
XnewRa.r7;
XObjMLP.r7("130\Omega")(is)(bot);
XnewRa.r8;
XObjMLP.r8("50\Omega")(is)(bot);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("600V")(in)(lft);


XnewNode.n1;

X(n1).c = origin;

X(r2).c = X(n1).c + UD(0,3);
X(r7).c = X(n1).c + UD(0,-3);
X(r4).c = X(n1).c + UD(-3,0);
X(r5).c = X(n1).c + UD(3,0);
X(r6).c = X(r5).c + UD(6,0);
X(u1).c = X(r4).c + UD(-6,0);

X(r1).c = (xpart (X(u1).c + X(r4).c)/2, ypart X(r2).c);
X(r3).c = (xpart (X(r5).c + X(r6).c)/2, ypart X(r2).c);
X(r8).c = (xpart (X(r5).c + X(r6).c)/2, ypart X(r7).c);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,u1);
Xpclist(
	"u1,2,r1,1",
	"u1,1,r7,1",
	"r4,2,r1,2",
	"r4,2,r2,1",
	"r5,2,r2,2",
	"r5,2,r3,1",
	"r6,2,r3,2",
	"r6,1,r8,2",
	"r4,1,r7,1",
	"r5,1,r7,2",
	"r5,1,r8,1"
);
