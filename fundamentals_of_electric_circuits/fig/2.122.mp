XnewLightBulb.lb1;
XObjMLP.lb1("150 \text{Watt}")(ie)(rt);
XnewRa.r1;
XObjMLP.r1("100\Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("50\Omega")(is)(rt);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("V_s")(in)(lft);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(lb1).isw = origin;
X(r1).c = X(lb1).is + UD(0, -3);
X(r2).c = X(r1).c + UD(6,0);
X(u1).c = X(r1).c + UD(-6,0);
X(n1).c = X(lb1).pin[1] + UD(-2,0);
X(n2).c = X(lb1).pin[2] + UD(2,0);
X(n3).c = X(u1).c + UD(0,-3);

XdrawObj(lb1, u1, r1, r2);

Xpclist(
	"lb1,1,u1,2",
	"lb1,2,r2,2",
	"n1,-90,r1,1",
	"r1,2,n2,90",
	"u1,1,n3,-90",
	"n3,0,r2,1"
);
