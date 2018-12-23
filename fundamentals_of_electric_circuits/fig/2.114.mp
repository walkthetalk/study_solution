XnewRa.r1 "angle(90)";
XObjMLP.r1("R")(in)(lft);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("R")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("R")(in)(lft);
XnewRa.r5;
XObjMLP.r5("R")(in)(top);

XnewICS.u1 "angle(90)";
XObjMLP.u1("9mA")(in)(lft);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-12);
X(u1).c = (X(n1).c + X(n2).c)/2;
X(n3).c = X(u1).c + UD(4,0);
X(n4).c = X(n3).c + UD(6,0);
X(r5).c = (X(n3).c+X(n4).c)/2;
X(r1).c = X(n3).c + UD(0,3);
X(r2).c = X(n3).c + UD(0,-3);
X(r3).c = X(n4).c + UD(0,3);
X(r4).c = X(n4).c + UD(0,-3);

XdrawObj(r1,r2,r3,r4,r5,u1);
Xpclist(
	"u1,2,n1,90",
	"u1,1,n2,-90",
	"n1,0,r1,2",
	"n1,0,r3,2",
	"r1,1,r5,1",
	"r3,1,r5,2",
	"r2,2,r5,1",
	"r4,2,r5,2",
	"n2,0,r2,1",
	"n2,0,r4,1"
);
