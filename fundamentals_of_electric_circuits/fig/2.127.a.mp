XnewRa.r1;
XObjMLP.r1("1 k\Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("5 k\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("4 k\Omega")(in)(lft);
XObjMLP.r3("+")(ise)(rt);
XObjMLP.r3("-")(isw)(rt);
XObjMLP.r3("V_o")(is)(rt);

XnewICS.u1 "angle(90)";
XObjMLP.u1("2 mA")(in)(lft);

XnewNode.n1;

X(u1).c = origin;
X(r2).c = X(u1).c + UD(6,0);
X(r3).c = X(r2).c + UD(6,0);
X(r1).c = (X(r2).c+X(r3).c)/2 + UD(0,3);
X(n1).c = X(u1).c + UD(0,-3);

XdrawObj(r1,r2,r3,u1);
Xpclist(
	"u1,2,r1,1",
	"r2,2,r1,1",
	"r1,2,r3,2",
	"u1,1,n1,-90",
	"n1,0,r2,1",
	"n1,0,r3,1"
);
