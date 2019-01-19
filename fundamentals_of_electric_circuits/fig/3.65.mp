XnewRa.r1 "angle(-90)";
XObjMLP.r1("1S")(in)(rt);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("4S")(in)(rt);
XObjMLP.r2("+")(isw)(lft);
XObjMLP.r2("v_o")(is)(lft);
XObjMLP.r2("-")(ise)(lft);
XnewRa.r3;
XObjMLP.r3("2S")(in)(top);
XnewRa.r4;
XObjMLP.r4("8S")(in)(top);

XnewICS.u1 "angle(90)";
XObjMLP.u1("2 A")(in)(lft);
XnewDVS.u2 "angle(-180)";
XObjMLP.u2("2 v_o")(is)(top);
XnewIVS.u3 "angle(90)";
XObjMLP.u3("13 V")(is)(rt);

XnewDEarth.de1;

XnewNode.n1 "visible(false)";
XObjMLP.n1("v_1")(inw)(ulft);
XnewNode.n2 "visible(false)";
XObjMLP.n2("v_2")(in)(top);
XnewNode.n3 "visible(false)";
XObjMLP.n3("v_3")(ie)(rt);
XnewNode.n4 "visible(false)";

X(n2).c = origin;
X(n1).c = X(n2).c + UD(-6,0);
X(n3).c = X(n2).c + UD(6,0);
X(n4).c = X(n2).c + UD(0,-6);

X(r2).c = (X(n2).c + X(n4).c)/2;
X(u2).c = (X(n1).c + X(n2).c)/2;
X(r4).c = (X(n2).c + X(n3).c)/2;
X(r3).c = X(n2).c + UD(0,4);

X(r1).c = (xpart X(n1).c, ypart X(r2).c);
X(u1).c = X(r1).c + UD(-3,0);
X(u3).c = (xpart X(n3).c, ypart X(r2).c);

X(de1).c = X(n4).c + UD(0,-1);

Xpclist(
	"u1,2,u2,2",
	"r1,1,r3,1",
	"u2,1,r2,1",
	"u2,1,r4,1",
	"r3,2,u3,2",
	"r4,2,u3,2",
	"u1,1,n4,0",
	"r1,2,n4,0",
	"r2,2,n4,-90",
	"n4,0,u3,1",
	"n4,-90,de1,1"
);

XdrawObj(r1,r2,r3,r4,u1,u2,u3,n1,n2,n3,de1);
