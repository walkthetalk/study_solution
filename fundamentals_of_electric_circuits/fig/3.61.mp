XnewRa.r1;
XObjMLP.r1("20 \Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("10 \Omega")(in)(top);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("20 \Omega")(in)(rt);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("10 \Omega")(is)(lft);
XObjMLP.r4("+")(inw)(rt);
XObjMLP.r4("V_o")(in)(rt);
XObjMLP.r4("-")(ine)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("40 V")(in)(lft);
XnewDCS.u2 "angle(90)";
XObjMLP.u2("4 I_x")(is)(lrt);

XnewDEarth.de1;

XnewNode.n1 "visible(false)";
XnewNode.n2 "visible(false)";

XnewCDM.m1 "angle(-90)";
XObjMLP.m1("I_x")(in)(rt);

X(n1).c = origin;
X(n2).c = X(n1).c + UD(0,-3);
X(r2).c = X(n1).c + UD(0,4);
X(r1).c = (X(u1).c + X(r3).c)/2 + UD(0,4);
X(r3).c = X(n1).c + UD(-4,0);
X(u2).c = X(n1).c + UD(4,0);
X(u1).c = X(r3).c + UD(-6,0);
X(r4).c = X(u2).c + UD(6,0);
X(de1).c = X(n2).c + UD(0,-1);
X(m1).se = X(r3).inw;

Xpclist(
	"u1,2,r1,1",
	"r1,2,r3,1",
	"r1,2,r2,1",
	"r2,2,u2,2",
	"r2,2,r4,1",
	"u1,1,n2,0",
	"r3,2,n2,0",
	"n2,0,u2,1",
	"n2,0,r4,2",
	"n2,-90,de1,1"
);

XdrawObj(r1,r2,r3,r4,u1,u2,de1,m1);
