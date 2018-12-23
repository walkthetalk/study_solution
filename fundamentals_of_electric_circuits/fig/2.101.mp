XnewRa.r1;
XObjMLP.r1("R_1")(in)(top);
XnewRa.r2;
XObjMLP.r2("R_1")(in)(top);

XnewRa.r3 "angle(90)";
XObjMLP.r3("R_1")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("R_1")(in)(lft);

XnewNode.n1;
XnewNode.n2;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-6);

X(r1).c = X(n1).c + UD(3,0);
X(r2).c = X(r1).c + UD(6,0);
X(r3).c = (X(n1).c+X(n2).c)/2 + UD(6,0);
X(r4).c = X(r3).c + UD(6,0);

XdrawObj(r1,r2,r3,r4);
Xpclist(
	"n1,0,r1,1",
	"r1,2,r3,2",
	"r1,2,r2,1",
	"r2,2,r4,2",
	"n2,0,r3,1",
	"n2,0,r4,1"
);
