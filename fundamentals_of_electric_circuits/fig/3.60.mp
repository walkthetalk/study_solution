XnewRa.r1;
XObjMLP.r1("12 \Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("6 \Omega")(in)(top);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("12 \Omega")(in)(rt);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("60 V")(in)(lft);
XnewDVS.u2 "angle(-90)";
XObjMLP.u2("24 V")(in)(rt);

XnewDEarth.de1;

XnewNode.n1 "visible(false)";
XObjMLP.n1("V_o")(in)(top);
XnewNode.n2;

X(r3).c = origin;
X(n1).c = X(r3).c + UD(0,3);
X(n2).c = X(r3).c + UD(0,-3);
X(r1).c = X(r3).c + UD(-4,3);
X(r2).c = X(r3).c + UD(4,3);
X(u1).c = X(r3).c + UD(-7,0);
X(u2).c = X(r3).c + UD(7,0);
X(de1).c = X(n2).c + UD(0,-1);

Xpclist(
	"u1,2,r1,1",
	"r1,2,r3,1",
	"r2,1,r3,1",
	"r2,2,u2,1",
	"u1,1,n2,0",
	"r3,2,n2,-90",
	"n2,0,u2,2",
	"n2,-90,de1,1"
);

XdrawObj(u1,u2,r1,r2,r3,de1,n1);
