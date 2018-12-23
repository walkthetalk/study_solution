XnewRa.r1;
XObjMLP.r1("4S")(in)(top);
XnewRa.r2;
XObjMLP.r2("6S")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("1S")(is)(rt);
XObjMLP.r3("+")(ine)(lft);
XObjMLP.r3("-")(inw)(lft);
XObjMLP.r3("v")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("2S")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("3S")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("i")(in)(top);

XnewICS.u1 "angle(90)";
XObjMLP.u1("9A")(in)(lft);


XnewNode.n1;
XnewNode.n2;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0, 3);
X(n2).c = X(u1).c + UD(0,-3);

X(r1).c = (xpart (X(r3).c + X(r4).c)/2, ypart X(n1).c);
X(r2).c = (xpart (X(r4).c + X(r5).c)/2, ypart X(n1).c);

X(r3).c = X(u1).c + UD(4,0);
X(r4).c = X(r3).c + UD(8,0);
X(r5).c = X(r4).c + UD(6,0);

X(m1).se = X(r1).w;

XdrawObj(r1,r2,r3,r4,r5,u1,m1);
Xpclist(
	"n1,0,r1,1",
	"n1,0,r3,2",
	"n1,-90,u1,2",
	"r4,2,r1,2",
	"r4,2,r2,1",
	"r2,2,r5,2",
	"n2,90,u1,1",
	"n2,0,r3,1",
	"n2,0,r4,1",
	"n2,0,r5,1"
);
