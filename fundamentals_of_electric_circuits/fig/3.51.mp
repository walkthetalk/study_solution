XnewRa.r1;
XObjMLP.r1("2 \Omega")(in)(top);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("10 \Omega")(is)(lft);
XnewRa.r3 "angle(-90)";
XObjMLP.r3("5 \Omega")(in)(rt);
XnewRa.r4 "angle(-90)";
XObjMLP.r4("4 \Omega")(is)(lft);

XnewICS.u1;
XObjMLP.u1("6 A")(in)(top);
XnewICS.u2 "angle(90)";
XObjMLP.u2("3 A")(is)(rt);

XnewDEarth.u3;


XnewNode.n1 "visible(false)";
XObjMLP.n1("v_1")(ic)(ulft);
XnewNode.n2 "visible(false)";
XObjMLP.n2("v_2")(ic)(urt);
XnewNode.n3 "visible(false)";
XnewNode.n4 "visible(false)";

X(n4).c = origin;
X(n1).c = X(n4).c + UD(-3,3);
X(n2).c = X(n4).c + UD(3,3);
X(n3).c = X(n4).c + UD(0,-3);

X(u1).c = (X(n1).c + X(n2).c)/2;
X(r1).c = X(u1).c + UD(0,3);
X(r3).c = X(n1).c + UD(0,-3);
X(r4).c = X(n2).c + UD(0,-3);
X(r2).c = X(r3).c + UD(-3,0);
X(u2).c = X(r4).c + UD(3,0);

X(u3).c = X(n3).c + UD(0,-1);

Xpclist(
	"n1,90,r1,1",
	"n1,0,u1,1",
	"r1,2,n2,-90",
	"u1,2,n2,0",
	"r2,1,n1,0",
	"r3,1,n1,90",
	"r2,2,n3,0",
	"r3,2,n3,0",
	"n2,0,u2,2",
	"n2,-90,r4,1",
	"n3,0,r4,2",
	"n3,0,u2,1",
	"n3,-90,u3,1"
);

XdrawObj(u1,u2,u3,r1,r2,r3,r4,n1,n2);
