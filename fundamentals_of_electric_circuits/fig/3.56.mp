XnewRa.r1 "angle(90)";
XObjMLP.r1("60 \Omega")(in)(lft);
XnewRa.r2 "angle(90)";
XObjMLP.r2("30 \Omega")(is)(rt);
XObjMLP.r2("+")(ine)(lft);
XObjMLP.r2("-")(inw)(lft);
XObjMLP.r2("V_x")(in)(lft);

XnewICS.u1 "angle(90)";
XObjMLP.u1("2 A")(in)(lft);
XnewDCS.u2 "angle(-90)";
XObjMLP.u2("0.05 V_x")(in)(rt);

XnewNode.n1;
XnewNode.n2;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0,3);
X(n2).c = X(u1).c + UD(0,-3);
X(r1).c = X(u1).c + UD(6,0);
X(r2).c = X(r1).c + UD(6,0);
X(u2).c = X(r2).c + UD(6,0);

Xpclist(
	"u1,2,n1,90",
	"u1,1,n2,-90",
	"n1,0,r1,2",
	"n1,0,r2,2",
	"n1,0,u2,1",
	"n2,0,r1,1",
	"n2,0,r2,1",
	"n2,0,u2,2"
);

XdrawObj(u1,u2,r1,r2);
