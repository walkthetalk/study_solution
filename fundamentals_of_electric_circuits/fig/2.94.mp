XnewRa.r1;
XObjMLP.r1("25\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("180\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("60\Omega")(is)(rt);
XnewRa.r4 "angle(90)";
XObjMLP.r4("60\Omega")(is)(rt);

XnewCDM.m1;
XObjMLP.m1("R_{eq}")(iw)(lft);


XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(n1).c = X(n2).c + UD(0, 6);
X(n2).c = UD(0, -3);
X(n3).c = X(n1).c + UD(6, 3);

X(r1).c = X(n1).c + UD(3, 0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = X(r2).c + UD(3,-3);
X(r4).c = X(r2).c + UD(7,0);
X(m1).w = origin;

XdrawObj(r1,r2,r3,r4,m1);
Xpclist(
	"n1,0,r1,1",
	"r1,2,n3,90",
	"r2,1,n3,90",
	"n3,0,r4,2",
	"r2,2,r3,2",
	"n2,0,r3,1",
	"n2,0,r4,1"
);
