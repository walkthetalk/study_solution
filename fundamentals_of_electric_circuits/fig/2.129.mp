XnewRa.r1;
XObjMLP.r1("R_s")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_1")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("R_2")(in)(lft);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("4 V")(in)(lft);

XnewVmeter.u2 "angle(-90)";
XObjMLP.u2("250 k\Omega")(is)(lft);

XnewNode.n1 "pathfillcolor(white)";
XnewNode.n2 "pathfillcolor(white)";
XnewNode.n3 "pathfillcolor(white)";
XnewNode.n4 "pathfillcolor(white)";
XnewNode.n5 "visible(false)";

XObjMLP.n1("+")(is)(bot);
XObjMLP.n3("-")(in)(top);
XObjMLP.n5("V_o")(c)(c);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(3,0);
X(n3).c = X(n1).c + UD(0,-6);
X(n4).c = X(n3).c + UD(3,0);
X(n5).c = (X(n1).c + X(n3).c)/2;

X(u2).c = (X(n2).c + X(n4).c)/2 + UD(6,0);

X(r3).c = X(n5).c + UD(-3,0);
X(r2).c = X(r3).c + UD(0,6);
X(u1).c = (X(r2).c + X(r3).c)/2 + UD(-6,0);
X(r1).c = X(r2).c + UD(-3,3);

Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,2",
	"r2,1,r3,2",
	"r2,1,n1,0",
	"u1,1,n3,0",
	"r3,1,n3,0",
	"n2,0,u2,1",
	"n4,0,u2,2"
);
XdrawObj(r1,r2,r3,u1,u2,n1,n2,n3,n4,n5);
