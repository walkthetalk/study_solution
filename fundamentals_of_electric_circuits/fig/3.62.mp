XnewRa.r1 "angle(-90)";
XObjMLP.r1("50 \Omega")(is)(lft);
XnewRa.r2;
XObjMLP.r2("10 \Omega")(in)(top);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("30 \Omega")(is)(lft);

XnewIVS.u1 "angle(-180)";
XObjMLP.u1("600 V")(is)(top);
XnewICS.u2 "angle(90)";
XObjMLP.u2("15 A")(is)(rt);

XnewDEarth.de1;

XnewNode.n1 "visible(false)";
XObjMLP.n1("v_1")(in)(top);
XnewNode.n2 "visible(false)";
XObjMLP.n2("v_2")(in)(top);
XnewNode.n3 "visible(false)";

X(n1).c = origin;
X(r1).c = X(n1).c + UD(0,-3);
X(r2).c = X(n1).c + UD(3,0);
X(u1).c = X(r2).c + UD(5,0);
X(n2).c = X(u1).c + UD(3,0);
X(r3).c = (xpart X(n2).c, ypart X(r1).c);
X(u2).c = X(r3).c + UD(3,0);
X(n3).c = X(r3).c + UD(0,-3);
X(de1).c = X(n3).c + UD(0,-1);

Xpclist(
	"r1,1,r2,1",
	"r2,2,u1,2",
	"u1,1,r3,1",
	"u1,1,u2,2",
	"r1,2,n3,0",
	"r3,2,n3,-90",
	"n3,0,u2,1",
	"n3,-90,de1,1"
);

XdrawObj(r1,r2,r3,u1,u2,de1,n1,n2,n3);
