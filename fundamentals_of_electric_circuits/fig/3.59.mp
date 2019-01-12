XnewRa.r1;
XObjMLP.r1("1 \Omega")(in)(top);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("8 \Omega")(is)(lft);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("2 \Omega")(in)(rt);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("4 \Omega")(in)(rt);

XnewICS.u1;
XObjMLP.u1("4 A")(in)(top);
XnewDCS.u2;
XObjMLP.u2("2 I_o")(in)(top);

XnewNode.n1;
XnewNode.n2;

XnewCDM.m1 "angle(-90)";
XObjMLP.m1("I_o")(is)(lft);

X(r3).c = origin;
X(n1).c = X(r3).c + UD(0,4);
X(n2).c = X(r3).c + UD(0,-3);
X(u1).c = X(n1).c + UD(-3,0);
X(u2).c = X(n1).c + UD(3,0);
X(r1).c = X(n1).c + UD(0,4);
X(r2).c = X(r3).c + UD(-6,0);
X(r4).c = X(r3).c + UD(6,0);
X(m1).ne = X(r2).w;

Xpclist(
	"r2,1,r1,1",
	"r2,1,u1,1",
	"r1,2,r4,1",
	"u1,2,r3,1",
	"u1,2,u2,1",
	"u2,2,r4,1",
	"r2,2,n2,0",
	"r3,2,n2,-90",
	"n2,0,r4,2"
);

XdrawObj(u1,u2,r1,r2,r3,r4,m1);
