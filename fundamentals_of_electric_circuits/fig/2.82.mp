XnewRa.r1 "angle(90)";
XObjMLP.r1("20\Omega")(is)(rt);
XnewRa.r2 "angle(90)";
XObjMLP.r2("10\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("20\Omega")(is)(rt);
XnewICS.u1 "angle(90)";
XObjMLP.u1("3A")(in)(lft);
XnewICS.u2 "angle(-90)";
XObjMLP.u2("4A")(in)(rt);
XnewICS.u3 "angle(90)";
XObjMLP.u3("-2A")(in)(lft);
XObjMLP.u3("V")(is)(rt);
XObjMLP.u3("+")(ise)(rt);
XObjMLP.u3("-")(isw)(rt);

XnewCDM.m0;
XObjMLP.m0("I")(in)(top);

XnewNode.n1;
XnewNode.n2;

X(u1).c = origin;
X(r1).c = X(u1).c + UD(5,0);
X(r2).c = X(r1).c + UD(5,0);
X(u2).c = X(r2).c + UD(5,0);
X(r3).c = X(u2).c + UD(5,0);
X(u3).c = X(r3).c + UD(7,0);
X(n1).c = X(u1).c + UD(0,3);
X(n2).c = X(u1).c + UD(0,-3);
X(m0).s = (xpart (X(r2).c + X(u2).c)/2, ypart X(n1).c);

XdrawObj(r1,r2,r3,u1,u2,u3,m0);
Xpclist(
	"n1,-90,u1,2",
	"n1,0,r1,2",
	"n1,0,r2,2",
	"n1,0,r3,2",
	"n1,0,u2,1",
	"n1,0,u3,2",
	"n2,90,u1,1",
	"n2,0,r1,1",
	"n2,0,r2,1",
	"n2,0,r3,1",
	"n2,0,u2,2",
	"n2,0,u3,1"
);
