XnewRa.r1 "angle(90)";
XObjMLP.r1("R_1")(is)(rt);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_2")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("R_3")(is)(rt);

XnewFuse.u1;
XObjMLP.u1("10A,0.01\Omega")(in)(top);
XnewTriSwitch.u2(1);
XObjTLP.u2("Low")(in)(ulft);
XObjTLP.u2("Medium")(ie)(lrt);
XObjTLP.u2("High")(is)(llft);
XnewBattery.u3;
XObjMLP.u3("6 V")(iw)(lft);
XnewLabelNode.u4("Motor")("");

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

% aux node for motor
XnewNode.n5;
XnewNode.n6;

X(u2).c = origin;

X(n2).c = X(u2).c + UD(6,0);
X(n1).c = X(n2).c + UD(0,6);
X(n3).c = X(n2).c + UD(0,-6);
X(n4).c = X(n3).c + UD(0,-6);

X(n5).c = X(u4).iw;
X(n6).c = X(u4).ie;

X(u1).c = X(u2).c + UD(-6,0);
X(u3).c = X(u2).c + UD(-9,-6);
X(u4).c = X(n4).c + UD(-9,0);

X(r1).c = (X(n1).c + X(n2).c)/2;
X(r2).c = (X(n2).c + X(n3).c)/2;
X(r3).c = (X(n3).c + X(n4).c)/2;

Xpclist(
	"u3,1,u1,1",
	"u1,2,u2,4",
	"u3,2,n5,0",
	"n6,0,r3,1",
	"r3,2,r2,1",
	"r2,2,r1,1",
	"r1,2,n1,90",
	"u2,1,n1,0",
	"u2,2,n2,0",
	"u2,3,n3,0"
);

XdrawObj(u1,u2,u3,u4,r1,r2,r3);
