XnewRa.r1;
XObjMLP.r1("R")(in)(top);
XnewRa.r2;
XObjMLP.r2("R")(in)(top);
XnewRa.r3;
XObjMLP.r3("R")(in)(top);
XnewRa.r4 "angle(90)";
XObjMLP.r4("R")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("R")(is)(rt);
XnewRa.r6 "angle(90)";
XObjMLP.r6("R")(is)(rt);
XnewRa.r7 "angle(90)";
XObjMLP.r7("R")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("R_{eq}")(in)(top);


XnewNode.n1;
XnewNode.n2;

X(n1).c = X(n2).c + UD(0, 9);
X(n2).c = UD(0, -6);
X(r4).c = X(n2).c + UD(3, 3);
X(r5).c = X(r4).c + UD(5,0);
X(r6).c = X(r5).c + UD(6,0);
X(r7).c = X(r6).c + UD(6,0);
X(r3).c = (xpart (X(r6).c+X(r7).c)/2, ypart X(n2).c);
X(r2).c = (X(r6).c+X(r5).c)/2 + UD(0,3);
X(r1).c = (xpart X(r2).c, ypart X(n1).c);
X(m1).e = (xpart X(r4).c, ypart X(r2).c);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,m1);
Xpclist(
	"n1,0,r1,1",
	"n1,0,r4,2",
	"r1,2,r7,2",
	"r2,1,r4,2",
	"r2,1,r5,2",
	"r2,2,r6,2",
	"r2,2,r7,2",
	"n2,0,r4,1",
	"n2,0,r5,1",
	"n2,0,r6,1",
	"n2,0,r3,1",
	"r3,2,r7,1"
);
