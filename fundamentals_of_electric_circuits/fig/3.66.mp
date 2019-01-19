XnewRa.r1 "angle(-90)";
XObjMLP.r1("4\Omega")(is)(lft);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("2\Omega")(in)(rt);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("8\Omega")(in)(rt);
XnewRa.r4;
XObjMLP.r4("10\Omega")(in)(top);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("60 V")(in)(lft);
XnewDCS.u2 "angle(90)";
XObjMLP.u2("3 i_o")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("i_o")(in)(top);

XnewNode.n1 "visible(false)";
XnewNode.n2 "visible(false)";

X(r4).c = origin;
X(r1).c = X(r4).c + UD(-3,3);
X(r2).c = X(r4).c + UD(3,3);
X(u1).c = X(r4).c + UD(-3,-3);
X(u2).c = X(r4).c + UD(3,-3);
X(n1).c = X(r1).c + UD(0,3);
X(r3).c = X(r4).c + UD(8,0);
X(n2).c = X(u2).c + UD(0,-3);
X(m1).sw = X(n1).c;

Xpclist(
	"u1,2,r4,1",
	"u1,2,r1,2",
	"r1,1,n1,90",
	"n1,0,r2,1",
	"n1,0,r3,1",
	"r4,2,r2,2",
	"r4,2,u2,2",
	"u1,1,n2,0",
	"u2,1,n2,-90",
	"n2,0,r3,2"
);

XdrawObj(r1,r2,r3,r4,u1,u2,m1);
