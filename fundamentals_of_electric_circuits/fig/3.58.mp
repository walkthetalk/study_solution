XnewRa.r1;
XObjMLP.r1("250 \Omega")(in)(top);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("50 \Omega")(in)(rt);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("150 \Omega")(in)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("24 V")(in)(lft);
XnewDVS.u2 "angle(180)";
XObjMLP.u2("60 I_b")(is)(top);

XnewNode.n1;

XnewCDM.m1;
XObjMLP.m1("I_b")(in)(top);

X(r2).c = origin;
X(r1).c = X(r2).c + UD(-4,3);
X(u1).c = X(r2).c + UD(-8,0);
X(u2).c = X(r2).c + UD(4,3);
X(r3).c = X(r2).c + UD(8,0);
X(n1).c = X(r2).c + UD(0,-3);
X(m1).se = X(r1).w;

Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,1",
	"r1,2,u2,2",
	"u2,1,r3,1",
	"u1,1,n1,0",
	"r2,2,n1,-90",
	"n1,0,r3,2"
);

XdrawObj(u1,u2,r1,r2,r3,m1);
