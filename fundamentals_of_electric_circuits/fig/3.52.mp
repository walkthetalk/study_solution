XnewRa.r1 "angle(-90)";
XObjMLP.r1("10 \Omega")(is)(lft);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("20 \Omega")(is)(lft);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("30 \Omega")(is)(lft);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("60 \Omega")(is)(lft);

XnewICS.u1 "angle(90)";
XObjMLP.u1("8 A")(in)(lft);
XnewICS.u2 "angle(-90)";
XObjMLP.u2("20 A")(is)(lft);

XnewDEarth.u3;

XnewCDM.m1 "angle(-90)";
XObjMLP.m1("I_1")(in)(rt);
XnewCDM.m2 "angle(-90)";
XObjMLP.m2("I_2")(in)(rt);
XnewCDM.m3 "angle(-90)";
XObjMLP.m3("I_3")(in)(rt);
XnewCDM.m4 "angle(-90)";
XObjMLP.m4("I_4")(is)(lft);

XnewNode.n1 "visible(false)";
XObjMLP.n1("v_0")(in)(top);
XnewNode.n2 "visible(false)";

XnewNode.no;

X(no).c = origin;
X(r2).c = X(no).c + UD(-3,0);
X(r3).c = X(no).c + UD(3,0);
X(n1).c = X(no).c + UD(0,4);
X(n2).c = X(no).c + UD(0,-4);
X(r1).c = X(r2).c + UD(-6,0);
X(u1).c = X(r1).c + UD(-6,0);
X(u2).c = X(r3).c + UD(6,0);
X(r4).c = X(u2).c + UD(6,0);
X(u3).c = X(n2).c + UD(0,-1);
X(m1).se = X(r1).iw;
X(m2).se = X(r2).iw;
X(m3).se = X(r3).iw;
X(m4).ne = X(r4).iw;

Xpclist(
	"u1,2,n1,0",
	"r1,1,n1,0",
	"r2,1,n1,0",
	"n1,0,r3,1",
	"n1,0,u2,1",
	"n1,0,r4,1",
	"u1,1,n2,0",
	"r1,2,n2,0",
	"r2,2,n2,0",
	"n2,0,r3,2",
	"n2,0,u2,2",
	"n2,0,r4,2",
	"n2,-90,u3,1"
);

XdrawObj(u1,u2,u3,r1,r2,r3,r4,n1,n2,m1,m2,m3,m4);
