XnewRa.r1;
XObjMLP.r1("50\Omega")(is)(bot);
XnewRa.r2;
XObjMLP.r2("200\Omega")(in)(top);
XnewRa.r3;
XObjMLP.r3("40\Omega")(is)(bot);
XnewRa.r4;
XObjMLP.r4("60\Omega")(in)(top);

XnewCDM.m1;
XObjMLP.m1("i_1")(is)(bot);
XnewCDM.m2;
XObjMLP.m2("i_2")(in)(top);
XnewCDM.m3 "angle(180)";
XObjMLP.m3("i_3")(in)(bot);
XnewCDM.m4 "angle(180)";
XObjMLP.m4("i_4")(is)(top);

XnewICS.u1 "angle(-90)";
XObjMLP.u1("16A")(in)(rt);


XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(3, 5);
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(u1).c + UD(-3,5);
X(n4).c = X(n3).c + UD(-6,0);
X(n5).c = X(u1).c + UD(10,-3);
X(n6).c = X(u1).c + UD(-10,-3);
X(r1).c = X(n1).c + UD(3,-2);
X(r2).c = X(n1).c + UD(3, 2);
X(r3).c = X(n3).c + UD(-3,-2);
X(r4).c = X(n3).c + UD(-3,2);

X(m1).ne = X(r1).w;
X(m2).se = X(r2).w;
X(m3).se = X(r3).e;
X(m4).ne = X(r4).e;

XdrawObj(r1,r2,r3,r4,u1,m1,m2,m3,m4);
Xpclist(
	"n1,180,u1,1",
	"n1,90,r2,1",
	"n1,-90,r1,1",

	"n2,0,n5,-90",
	"n2,90,r2,2",
	"n2,-90,r1,2",

	"n3,0,u1,1",
	"n3,90,r4,2",
	"n3,-90,r3,2",

	"n4,180,n6,-90",
	"n4,90,r4,1",
	"n4,-90,r3,1",

	"n5,180,u1,2",
	"n6,0,u1,2"
);
