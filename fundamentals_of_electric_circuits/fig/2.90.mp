XnewRa.r1;
XObjMLP.r1("25\Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("20\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("10\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("50\Omega")(is)(rt);
XnewRa.r5 "angle(90)";
XObjMLP.r5("40\Omega")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("i_x")(in)(top);
XnewCDM.m2;
XObjMLP.m2("i_o")(in)(top);

XnewNode.n1;
XnewNode.n2;

X(n1).c = UD(0,3);
X(n2).c = UD(0,-3);
X(r1).c = X(n1).c + UD(4,0);
X(r2).c = UD(7,0);
X(r3).c = X(r2).c + UD(4,0);
X(r4).c = X(r3).c + UD(4,0);
X(r5).c = X(r4).c + UD(4,0);

X(m1).sw = X(n1).c;
X(m2).s = (xpart (X(r4).c + X(r5).c)/2, ypart X(n1).c);

XdrawObj(r1,r2,r3,r4,r5,m1,m2);
Xpclist(
	"n1,0,r1,1",
	"r1,2,r2,2",
	"r1,2,r3,2",
	"r1,2,r4,2",
	"r1,2,r5,2",
	"n2,0,r2,1",
	"n2,0,r3,1",
	"n2,0,r4,1",
	"n2,0,r5,1"
);
