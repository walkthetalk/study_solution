XnewRa.r1;
XObjMLP.r1("3\Omega")(in)(top);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("4\Omega")(is)(lft);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("1\Omega")(is)(lft);
XnewRa.r5 "angle(-90)";
XObjMLP.r5("2\Omega")(is)(lft);

XnewCDM.m1;
XObjMLP.m1("i_1")(in)(top);
XnewCDM.m2 "angle(-90)";
XObjMLP.m2("i_2")(in)(rt);
XnewCDM.m3 "angle(-90)";
XObjMLP.m3("i_3")(in)(rt);
XnewCDM.m4 "angle(-90)";
XObjMLP.m4("i_4")(in)(rt);
XnewCDM.m5 "angle(-90)";
XObjMLP.m5("i_5")(in)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("200V")(in)(lft);


XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0, 6);
X(n2).c = X(u1).c + UD(0,-4);
X(r1).c = X(n1).c + UD(3,0);
X(n3).c = X(r4).c + UD(-1,5);
X(n4).c = X(n3).c + UD(4,-1);
X(r2).c = X(u1).c + UD(5,0);
X(r4).c = X(r2).c + UD(5,0);
X(r5).c = X(r4).c + UD(5,0);
X(n5).c = X(r4).c + UD(-1,-3);
X(m1).sw = X(r1).e;
X(m2).se = X(r2).w;
X(m3).se = X(n4).c;
X(m4).se = X(r4).w;
X(m5).se = X(r5).w;

XdrawObj(r1,r2,r4,r5,u1,m1,m2,m3,m4,m5);
Xpclist(
	"n1,0,r1,1",
	"r1,2,n3,-90",
	"n3,180,r2,1",
	"n3,0,n4,-90",
	"n4,180,r4,1",
	"n4,0,r5,1",
	"n5,180,r2,2",
	"n5,0,r4,2",
	"n5,0,r5,2",
	"n2,0,n5,90",
	"u1,2,n1,90",
	"u1,1,n2,-90"
);
