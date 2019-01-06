XnewRa.r1;
XObjMLP.r1("10 \Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("5 \Omega")(is)(bot);
XnewRa.r3;
XObjMLP.r3("4 \Omega")(in)(top);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("10 \Omega")(in)(rt);
XObjMLP.r4("+")(isw)(lft);
XObjMLP.r4("-")(ise)(lft);
XObjMLP.r4("V_1")(is)(lft);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("10 V")(in)(lft);
XnewIVS.u2 "angle(90)";
XObjMLP.u2("20 V")(is)(rt);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(r4).c = origin;
X(u2).c = X(r4).c + UD(6,0);
X(r3).c = (X(r4).c + X(u2).c)/2 + UD(0,4);
X(n2).c = (xpart (X(r4).c + UD(-1.5,0)), ypart X(r3).c);
X(n1).c = X(n2).c + UD(-6,0);
X(r1).c = (X(n1).c + X(n2).c)/2 + UD(0,1);
X(r2).c = (X(n1).c + X(n2).c)/2 + UD(0,-1);
X(u1).c = (xpart (X(n1).c + UD(-1.5,0)), ypart X(r4).c);
X(n3).c = X(r4).c + UD(0,-3);

Xpclist(
	"u1,2,n1,0",
	"n1,90,r1,1",
	"n1,-90,r2,1",
	"r1,2,n2,-90",
	"r2,2,n2,90",
	"n2,0,r4,1",
	"n2,0,r3,1",
	"r3,2,u2,2",
	"u1,1,n3,0",
	"n3,90,r4,2",
	"n3,0,u2,1"
);

XdrawObj(u1,u2,r1,r2,r3,r4);
