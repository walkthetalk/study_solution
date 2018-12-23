XnewR.r1;
XObjMLP.r1("16\Omega")(in)(top);
XnewR.r2;
XObjMLP.r2("14\Omega")(in)(top);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("10V")(in)(lft);
XnewIVS.u2 "angle(90)";
XObjMLP.u2("25V")(is)(rt);

XnewNode.n1;
XObjMLP.n1("+")(is)(bot);
XnewNode.n2;
XObjMLP.n2("-")(in)(top);

X(n1).c = UD(0, 3);
X(n2).c = UD(0,-3);
X(r1).c = X(n1).c + UD(-3, 0);
X(r2).c = X(n1).c + UD( 3, 0);
X(u1).c = UD(-6, 0);
X(u2).c = UD( 6, 0);

XObjMLP.n2("V_0")(c)(c) "labshift((X(n1).c - X(n2).c) / 2)";

XdrawObj(r1,r2,u1,u2);
Xpclist(
	"r1,2,n1,0",
	"n1,0,r2,1",
	"r2,2,u2,2",
	"u2,1,n2,180",
	"n2,180,u1,1",
	"u1,2,r1,1"
);
XdrawObj(n1,n2);
