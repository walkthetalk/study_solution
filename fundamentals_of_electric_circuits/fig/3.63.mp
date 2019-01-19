XnewRa.r1 "angle(-90)";
XObjMLP.r1("1 \Omega")(in)(rt);
XObjMLP.r1("+")(isw)(lft);
XObjMLP.r1("v_x")(is)(lft);
XObjMLP.r1("-")(ise)(lft);
XnewRa.r2;
XObjMLP.r2("2 \Omega")(is)(bot);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("4 \Omega")(in)(rt);
XObjMLP.r3("+")(isw)(lft);
XObjMLP.r3("v_o")(is)(lft);
XObjMLP.r3("-")(ise)(lft);
XnewRa.r4;
XObjMLP.r4("8 \Omega")(in)(top);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("100 V")(in)(lft);
XnewICS.u2;
XObjMLP.u2("12.5 A")(in)(top);
XnewIVS.u3 "angle(-90)";
XObjMLP.u3("50 V")(in)(rt);

XnewNode.n1 "visible(false)";
XnewNode.n2 "visible(false)";

X(n1).c = origin;
X(r1).c = X(n1).c + UD(-3,2);
X(u1).c = X(n1).c + UD(-3,-2);
X(r2).c = X(n1).c + UD(0,5);
X(u2).c = X(r2).c + UD(0,3);
X(r3).c = X(n1).c + UD(3,0);
X(r4).c = (xpart (X(r3).c + X(u3).c)/2, ypart X(r2).c);
X(u3).c = X(r3).c + UD(6,0);
X(n2).c = X(r3).c + UD(0,-4);

Xpclist(
	"u1,2,r1,2",
	"r1,1,r2,1",
	"r1,1,u2,1",
	"u2,2,r3,1",
	"r2,2,r3,1",
	"r4,1,r3,1",
	"r4,2,u3,1",
	"u1,1,n2,0",
	"r3,2,n2,-90",
	"n2,0,u3,2"
);

XdrawObj(r1,r2,r3,r4,u1,u2,u3);
