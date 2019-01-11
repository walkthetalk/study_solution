XnewRa.r1;
XObjMLP.r1("6 \Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("20 \Omega")(in)(top);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("4 \Omega")(in)(rt);
XObjMLP.r3("+")(isw)(lft);
XObjMLP.r3("v_o")(is)(lft);
XObjMLP.r3("-")(ise)(lft);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("20 \Omega")(in)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("60 V")(in)(lft);
XnewDVS.u2 "angle(90)";
XObjMLP.u2("5 v_o")(is)(rt);

XnewNode.n1 "visible(false)";
XnewNode.n2 "visible(false)";
XnewNode.n3 "visible(false)";

X(n2).c = origin;
X(u1).c = X(n2).c + UD(0,2);
X(r4).c = X(n2).c + UD(0,-2);
X(n1).c = X(u1).c + UD(0,3);
X(n3).c = X(r4).c + UD(0,-3);
X(r1).c = X(n1).c + UD(-3,0);
X(r2).c = X(n1).c + UD(3,0);
X(r3).c = X(n2).c + UD(-6,0);
X(u2).c = X(n2).c + UD(6,0);

Xpclist(
	"u1,2,r1,2",
	"u1,2,r2,1",
	"r3,1,r1,1",
	"r3,2,n3,0",
	"u1,1,r4,1",
	"r4,2,n3,-90",
	"n3,0,u2,1",
	"u2,2,r2,2"
);

XdrawObj(u1,u2,r1,r2,r3,r4);
