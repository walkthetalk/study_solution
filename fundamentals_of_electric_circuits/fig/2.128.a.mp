XnewRa.r1;
XObjMLP.r1("16 \Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("40 \Omega")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("60 \Omega")(in)(lft);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("4 V")(in)(lft);
XnewNode.n1;

XnewCDM.m1;
XObjMLP.m1("I")(in)(top);

X(u1).c = origin;
X(r1).c = X(u1).c + UD(3,3);
X(r2).c = X(u1).c + UD(6,0);
X(r3).c = X(r2).c + UD(4,0);
X(n1).c = X(u1).c + UD(0,-3);
X(m1).se = X(r1).nw;

XdrawObj(r1,r2,r3,u1,m1);
Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,2",
	"r1,2,r3,2",
	"u1,1,n1,-90",
	"n1,0,r2,1",
	"n1,0,r3,1"
);
