XnewRa.r1;
XObjMLP.r1("R")(in)(top);
XnewARa.r2 "angle(-90)";
XObjMLP.r2("R_x")(is)(lft);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("110V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("i_x")(in)(top);
XnewCDM.m2 "angle(-90)";
XObjMLP.m2("i_x")(in)(rt);

XnewNode.n1;

X(u1).c = origin;
X(r1).c = X(u1).c + UD(4,6);
X(r2).c = X(u1).c + UD(8,0);
X(n1).c = X(u1).c + UD(0,-6);
X(m1).se = X(r1).iw;
X(m2).sw = X(r2).ie;

XdrawObj(u1,r1,r2,m1,m2);

Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,1",
	"u1,1,n1,-90",
	"n1,0,r2,2"
);
