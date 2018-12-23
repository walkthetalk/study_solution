XnewRa.r1;
XObjMLP.r1("8\Omega")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("3\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("6\Omega")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("I_o")(is)(bot);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("10V")(in)(lft);


XnewNode.n1;
XnewNode.n2;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0, 3);
X(n2).c = X(u1).c + UD(0,-3);
X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(u1).c + UD(6,0);
X(r3).c = X(r2).c + UD(4,0);

X(m1).n = X(r1).is;

XdrawObj(r1,r2,r3,u1,m1);
Xpclist(
	"u1,2,n1,90",
	"n1,0,r1,1",
	"r1,2,r2,2",
	"r1,2,r3,2",
	"u1,1,n2,-90",
	"n2,0,r2,1",
	"n2,0,r3,1"
);
