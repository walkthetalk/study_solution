XnewRa.r1 "angle(90)";
XObjMLP.r1("10 k\Omega")(in)(lft);
XObjMLP.r1("+")(ise)(rt);
XObjMLP.r1("-")(isw)(rt);
XObjMLP.r1("V_o")(is)(rt);
XnewRa.r2 "angle(90)";
XObjMLP.r2("5 k\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("20 k\Omega")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("5 mA")(in)(lft);
XnewDVS.u2 "angle(90)";
XObjMLP.u2("0.01 V_o")(is)(rt);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(u1).c = origin;
X(r1).c = X(u1).c + UD(5,0);
X(u2).c = X(r1).c + UD(5,0);
X(r2).c = X(u2).c + UD(5,0);
X(r3).c = X(r2).c + UD(5,0);

X(n1).c = X(u1).c + UD(0,3);
X(n2).c = X(u1).c + UD(0,-3);
X(n3).c = X(u2).c + UD(0,3);
X(n4).c = X(u2).c + UD(0,-3);

XdrawObj(r1,r2,r3,u1,u2);
Xpclist(
	"u1,2,n1,90",
	"u1,1,n2,-90",
	"n1,0,r1,2",
	"n2,0,r1,1",
	"u2,2,n3,90",
	"u2,1,n4,-90",
	"n3,0,r2,2",
	"n3,0,r3,2",
	"n4,0,r2,1",
	"n4,0,r3,1",
	"n2,0,n4,0"
);
