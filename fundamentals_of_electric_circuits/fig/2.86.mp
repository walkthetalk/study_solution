XnewRa.r1 "angle(90)";
XObjMLP.r1("10\Omega")(is)(rt);
XnewRa.r2;
XObjMLP.r2("10\Omega")(is)(bot);
XObjMLP.r2("+")(inw)(top);
XObjMLP.r2("V_0")(in)(top) "labshift(UD(0,1))";
XObjMLP.r2("-")(ine)(top);
XnewICS.u1 "angle(90)";
XObjMLP.u1("25A")(in)(lft);
XnewDCS.u2 "angle(90)";
XObjMLP.u2("2V_0")(is)(rt);

XnewNode.n1;
XnewNode.n2;

X(n1).c = origin;
X(r1).c = X(n1).c + UD(0,-3);
X(n2).c = X(r1).c + UD(0,-3);

X(r2).c = X(n1).c + UD(4, 0);
X(u1).c = X(r1).c + UD(8, 0);
X(u2).c = X(u1).c + UD(3,0);

XdrawObj(r1,r2,u1,u2);
Xpclist(
	"r1,2,n1,90",
	"n1,0,r2,1",
	"r2,2,u1,2",
	"r2,2,u2,2",
	"r1,1,n2,-90",
	"n2,0,u1,1",
	"n2,0,u2,1"
);
