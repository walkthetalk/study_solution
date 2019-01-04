XnewBattery.u1;
XObjMLP.u1("9 V")(iw)(lft);

XnewSSwitch.u2(false);
XObjTLP.u2("Switch")(in)(rt);

XnewRa.r1;
XObjMLP.r1("R_x")(in)(top);

XnewLabelNode.u3("Sharpener")("");

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0,-3);
X(u2).c = X(u1).c + UD(3,3);
X(r1).c = X(u2).c + UD(6,0);
X(u3).c = X(u1).c + UD(12,0);
X(n2).c = X(u3).in;
X(n3).c = X(u3).is;

Xpclist(
	"u1,1,u2,1",
	"u2,2,r1,1",
	"r1,2,n2,-90",
	"u1,2,n1,-90",
	"n1,0,n3,90"
);

XdrawObj(u1,u2,u3,r1);
