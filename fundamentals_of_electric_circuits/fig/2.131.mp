XnewRa.r1;
XObjMLP.r1("R_1")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_L")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("V_s")(in)(lft);

XnewCDM.m1 "angle(-90)";
XObjMLP.m1("i_L")(in)(rt);

XnewNode.n1;
XnewNode.n2;

X(n1).c = origin;
X(u1).c = X(n1).c + UD(-4,0);
X(r1).c = X(n1).c + UD(0,4);
X(r2).c = X(n1).c + UD(4,0);
X(n2).c = X(n1).c + UD(0,-4);
X(m1).se = X(r2).ie;

Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,2",
	"u1,1,n2,0",
	"n2,0,r2,1"
);
XdrawObj(r1,r2,u1,m1);
