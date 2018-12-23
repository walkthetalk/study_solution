XnewRa.r1 "angle(90)";
XObjMLP.r1("70\Omega")(in)(lft);
XnewRa.r2 "angle(90)";
XObjMLP.r2("30\Omega")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("20\Omega")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("5\Omega")(is)(rt);
XObjMLP.r4("+")(ine)(lft);
XObjMLP.r4("-")(inw)(lft);
XObjMLP.r4("V_o")(in)(lft);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("200V")(in)(lft);

XnewCDM.m1;
XObjMLP.m1("I_o")(in)(top);


XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(n3).c = origin;

X(u1).c = X(n3).c + UD(-6,0);
X(n1).c = X(u1).c + UD(0,6);
X(n2).c = X(u1).c + UD(0,-6);
X(r1).c = X(n3).c + UD(0,3);
X(r3).c = X(n3).c + UD(0,-3);
X(r2).c = X(r1).c + UD(4,0);
X(r4).c = X(r3).c + UD(4,0);
X(m1).s = X(n3).c + UD(2, 0);

XdrawObj(r1,r2,r3,r4,u1,m1);
Xpclist(
	"u1,2,n1,90",
	"u1,1,n2,-90",
	"n1,0,r1,2",
	"n1,0,r2,2",
	"n2,0,r3,1",
	"n2,0,r4,1",
	"n3,90,r1,1",
	"n3,-90,r3,2",
	"n3,0,r2,1",
	"n3,0,r4,2"
);
