XnewRa.r1;
XObjMLP.r1("R_1")(in)(top);
XnewRa.r2;
XObjMLP.r2("R_2")(in)(top);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("R_3")(in)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("12 V")(in)(lft);
XnewIVS.u2 "angle(90)";
XObjMLP.u2("9 V")(is)(rt);

XnewCDM.m1 "angle(-90)";
XObjMLP.m1("I_x")(in)(rt);

XnewNode.n1;

X(r3).c = origin;
X(r1).c = X(r3).c + UD(-3,5);
X(r2).c = X(r3).c + UD(3,5);
X(u1).c = X(r3).c + UD(-6,0);
X(u2).c = X(r3).c + UD(6,0);
X(n1).c = X(r3).c + UD(0,-3);
X(m1).se = X(r3).iw;

Xpclist(
	"u1,2,r1,1",
	"r1,2,r3,1",
	"r3,1,r2,1",
	"r2,2,u2,2",
	"u1,1,n1,0",
	"r3,2,n1,-90",
	"n1,0,u2,1"
);

XdrawObj(u1,u2,r1,r2,r3,m1);
