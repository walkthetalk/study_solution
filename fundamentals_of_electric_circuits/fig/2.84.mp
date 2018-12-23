XnewRa.r1;
XObjMLP.r1("22\Omega")(in)(top);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("54V")(in)(lft);
XnewDVS.u2 "angle(90)";
XObjMLP.u2("5i_0")(is)(rt);

XnewCDM.m0;
XObjMLP.m0("i_0")(in)(top);

XnewNode.n1;
XnewNode.n2;

X(n1).c = origin;
X(u1).c = X(n1).c + UD(0,-3);
X(n2).c = X(u1).c + UD(0,-3);
X(r1).c = X(n1).c + UD(4,0);
X(u2).c = X(u1).c + UD(8,0);
X(m0).sw = X(n1).c;

XdrawObj(r1,u1,u2,m0);
Xpclist(
	"r1,2,u2,2",
	"r1,1,u1,2",
	"u1,1,n2,-90",
	"n2,0,u2,1"
);
