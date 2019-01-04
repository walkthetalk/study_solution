XnewRa.r1 "angle(-90)";
XObjMLP.r1("R_1")(is)(lft);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("R_2")(is)(lft);

XnewBattery.u1;
XObjMLP.u1("36 V")(iw)(lft);

XnewFuse.u2;
XObjMLP.u2("60 mA, 2\Omega")(in)(top);

XnewLabelNode.dev1("Device 1")("");
XObjMLP.dev1("12 V, 75 mW")(is)(lrt);
XnewLabelNode.dev2("Device 2")("");
XObjMLP.dev2("36 V, 720 mW")(in)(ulft);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;

X(u1).c = origin;
X(u2).c = X(u1).c + UD(3,6);
X(n1).c = X(u1).c + UD(6,0);
X(r1).c = X(n1).c + UD(0,3);
X(r2).c = X(n1).c + UD(0,-3);
X(dev1).c = X(r2).c + UD(6, 0);
X(dev2).c = X(r1).c + UD(12,0);
X(n2).c = X(u1).c + UD(0,-6);

X(n3).c = X(dev1).in;
X(n4).c = X(dev1).is;
X(n5).c = X(dev2).in;
X(n6).c = X(dev2).is;

Xpclist(
	"u1,1,u2,1",
	"u2,2,r1,1",
	"u2,2,n5,-90",
	"u1,2,n2,-90",
	"n2,0,r2,2",
	"r1,2,r2,1",
	"n1,0,n3,-90",
	"n2,0,n4,90",
	"n2,0,n6,90"
);

XdrawObj(u1,u2,r1,r2,dev1,dev2);
