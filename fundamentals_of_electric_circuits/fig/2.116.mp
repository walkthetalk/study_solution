XnewRa.r1;
XnewRa.r2;
XnewRa.r3;
XnewRa.r4;
XnewRa.r5;
XnewRa.r6 "angle(90)";
XnewRa.r7 "angle(90)";
XnewRa.r8 "angle(90)";
XnewRa.r9 "angle(90)";
XnewRa.r10 "angle(45)";
XnewRa.r11 "angle(45)";

XnewCDM.m1;
XObjMLP.m1("R_{eq}")(in)(top);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;
XnewNode.n7;
XnewNode.n8;

X(n4).c = origin;
X(n3).c = X(n4).c + UD(0, 6);
X(n5).c = X(n4).c + UD(0,-6);
X(n7).c = X(n4).c + UD(6, 0);
X(n6).c = X(n7).c + UD(0, 6);
X(n8).c = X(n7).c + UD(0,-6);
X(n1).c = X(n3).c + UD(-6,0);
X(n2).c = X(n5).c + UD(-6,0);

X(r1).c = (X(n1).c + X(n3).c)/2;
X(r2).c = (X(n2).c + X(n5).c)/2;
X(r3).c = (X(n3).c + X(n6).c)/2;
X(r4).c = (X(n4).c + X(n7).c)/2;
X(r5).c = (X(n5).c + X(n8).c)/2;
X(r6).c = (X(n3).c + X(n4).c)/2;
X(r7).c = (X(n4).c + X(n5).c)/2;
X(r8).c = (X(n6).c + X(n7).c)/2;
X(r9).c = (X(n7).c + X(n8).c)/2;
X(r10).c = (X(n4).c + X(n6).c)/2;
X(r11).c = (X(n5).c + X(n7).c)/2;

X(m1).iw = (X(n1).c + X(n2).c)/2;

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,m1);
Xpclist(
	"n1,0,r1,1",
	"r1,2,r6,2",
	"r6,2,r3,1",
	"r3,2,n6,0",
	"r10,2,n6,45",
	"r8,2,n6,90",
	"r6,1,n4,-90",
	"r7,2,n4,90",
	"r10,1,n4,-135",
	"r4,1,n4,180",
	"r4,2,n7,0",
	"r8,1,n7,-90",
	"r9,2,n7,90",
	"r11,2,n7,45",
	"n2,0,r2,1",
	"r2,2,n5,0",
	"r7,1,n5,-90",
	"r5,1,n5,180",
	"r11,1,n5,-135",
	"r5,2,r9,1"
);
