XnewR.r1 "angle(90)";
XObjMLP.r1("4V")(in)(lft);
XObjMLP.r1("+")(ine)(lft);
XObjMLP.r1("-")(inw)(lft);
XnewR.r2;
XObjMLP.r2("16V")(in)(top) "labshift(UD(0,1))";
XObjMLP.r2("+")(inw)(top);
XObjMLP.r2("-")(ine)(top);
XnewRa.r3;
XObjMLP.r3("v")(in)(top) "labshift(UD(0,1))";
XObjMLP.r3("+")(inw)(top);
XObjMLP.r3("-")(ine)(top);
XObjMLP.r3("12\Omega")(is)(bot);
XnewIVS.u0 "angle(90)";
XObjMLP.u0("10V")(in)(lft);
XnewDVS.u1 "angle(90)";
XObjMLP.u1("3i_x")(is)(rt);

XnewCDM.m0 "angle(-90)";
XObjMLP.m0("i_x")(in)(rt);

XnewNode.n1;

X(r1).c = origin;
X(r2).c = X(r1).c + UD(3, 4);
X(r3).c = X(r1).c + UD(-3,4);
X(u0).c = X(r1).c + UD(-6,0);
X(u1).c = X(r1).c + UD(6,0);
X(m0).se = X(r1).ie;
X(n1).c = X(r1).c + UD(0,-3);

Xpclist(
	"r1,2,r2,1",
	"r1,2,r3,2",
	"u0,2,r3,1",
	"u1,2,r2,2",
	"r1,1,n1,-90",
	"n1,180,u0,1",
	"n1,0,u1,1"
);
XdrawObj(r1,r2,r3,u0,u1,m0);
