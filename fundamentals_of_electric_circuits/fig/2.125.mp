XnewIVS.u1 "angle(90)";
XObjMLP.u1("110V")(in)(lft);
XnewIVS.u2 "angle(90)";
XObjMLP.u2("110V")(in)(lft);

XnewRa.r1 "angle(90)";
XObjMLP.r1("A")(is)(rt);
XnewRa.r2 "angle(90)";
XObjMLP.r2("B")(is)(rt);

XnewDEarth.de1;

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(n2).c = origin;
X(n1).c = X(n2).c + UD(0,6);
X(n3).c = X(n2).c + UD(0,-6);
X(u1).c = (X(n1).c + X(n2).c)/2;
X(u2).c = (X(n2).c + X(n3).c)/2;
X(r1).c = X(u1).c + UD(8,0);
X(r2).c = X(u2).c + UD(8,0);
X(de1).in = X(n2).c + UD(4,-1);

XdrawObj(u1,u2,r1,r2,de1);
Xpclist(
	"u1,2,n1,90",
	"n1,0,r1,2",
	"u1,1,n2,-90",
	"u2,2,n2,90",
	"u2,1,n3,90",
	"n3,0,r2,1",
	"n2,0,r1,1",
	"n2,0,r2,2",
	"n2,0,de1,1"
);
