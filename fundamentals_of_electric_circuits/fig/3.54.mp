XnewRa.r1 "angle(-90)";
XObjMLP.r1("30 k\Omega")(is)(lft);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("120 k\Omega")(is)(lft);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("120 k\Omega")(is)(lft);
XObjMLP.r3("+")(inw)(rt);
XObjMLP.r3("-")(ine)(rt);
XObjMLP.r3("v_o")(in)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("60 V")(in)(lft);
XnewIVS.u2 "angle(180)";
XObjMLP.u2("120 V")(is)(top);

XnewNode.n1 "visible(false)";
XnewNode.n2 "visible(false)";

X(r2).c = origin;
X(r3).c = X(r2).c + UD(6,0);
X(u2).c = (X(r2).c + X(r3).c)/2 + UD(0,6);
X(n1).c = X(r2).c + UD(-6,0);
X(u1).c = X(n1).c + UD(0,3);
X(r1).c = X(n1).c + UD(0,-3);
X(n2).c = X(r1).c + UD(0,-3);

Xpclist(
	"u1,2,u2,2",
	"u1,1,r1,1",
	"r1,2,n2,-90",
	"n2,0,r2,2",
	"n2,0,r3,2",
	"r2,1,u2,2",
	"u2,1,r3,1"
);

XdrawObj(u1,u2,r1,r2,r3);
