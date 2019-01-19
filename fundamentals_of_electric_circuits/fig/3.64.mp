XnewRa.r1 "angle(-90)";
XObjMLP.r1("6S")(in)(rt);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("5S")(in)(rt);
XnewRa.r3;
XObjMLP.r3("3S")(in)(top);

XnewCDM.m1 "angle(-90)";
XObjMLP.m1("i_o")(is)(lft);

XnewIVS.u1 "angle(-180)";
XObjMLP.u1("10 V")(is)(top);
XnewICS.u2;
XObjMLP.u2("2 A")(in)(top);
XnewICS.u3 "angle(90)";
XObjMLP.u3("4 A")(is)(rt);

XnewNode.n1 "visible(false)";

X(r2).c = origin;
X(r1).c = X(r2).c + UD(-6,0);
X(u3).c = X(r2).c + UD(6,0);
X(n1).c = X(r2).c + UD(0,-3);
X(u1).c = (X(r1).c + X(r2).c)/2 + UD(0,4);
X(r3).c = (X(r2).c + X(u3).c)/2 + UD(0,4);
X(u2).c = (X(u1).c + X(r3).c)/2 + UD(0,3);
X(m1).ine = X(r1).isw;

Xpclist(
	"r1,1,u1,2",
	"r1,1,u2,1",
	"u1,1,r2,1",
	"u1,1,r3,1",
	"u2,2,u3,2",
	"r3,2,u3,2",
	"r1,2,n1,0",
	"r2,2,n1,-90",
	"n1,0,u3,1"
);

XdrawObj(r1,r2,r3,u1,u2,u3,m1);
