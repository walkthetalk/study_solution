XnewRa.r1;
XObjMLP.r1("R_1")(in)(top);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_2")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("R_3")(in)(lft);
XnewRa.r4 "angle(90)";
XObjMLP.r4("R_4")(in)(lft);
XObjMLP.r4("+")(isw)(rt);
XObjMLP.r4("-")(ise)(rt);
XObjMLP.r4("V_o")(is)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("V_s")(in)(lft);
XnewDCS.u2 "angle(-90)";
XObjMLP.u2("\alpha I_o")(is)(lft);

XnewCDM.m0;
XObjMLP.m0("I_o")(in)(top);

XnewNode.n1;
XnewNode.n2;

X(u1).c = origin;
X(n1).c = UD(0,-3);
X(r1).c = UD(5,3);
X(r2).c = X(u1).c + UD(8,0);
X(u2).c = X(r2).c + UD(5,0);
X(r3).c = X(u2).c + UD(4,0);
X(r4).c = X(r3).c + UD(4,0);
X(n2).c = X(u2).c + UD(0,3);
X(m0).sw = (xpart X(u1).c, ypart X(r1).c);

XdrawObj(r1,r2,r3,r4,u1,u2,m0);
Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,2",
	"u1,1,n1,-90",
	"n1,0,r2,1",
	"n1,0,u2,2",
	"n1,0,r3,1",
	"n1,0,r4,1",
	"u2,1,n2,90",
	"n2,0,r3,2",
	"n2,0,r4,2"
);
