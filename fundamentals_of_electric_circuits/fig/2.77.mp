XnewR.r1 "angle(90)";
XnewCDM.m1 "angle(90)";
XObjMLP.m1("I_1")(in)(lft);
XnewR.r2 "angle(90)";
XnewCDM.m2 "angle(-90)";
XObjMLP.m2("3A")(in)(rt);
XnewR.r3 "angle(90)";
XnewCDM.m3 "angle(-90)";
XObjMLP.m3("I_3")(in)(rt);
XnewR.r4 "angle(90)";
XnewCDM.m4 "angle(-90)";
XObjMLP.m4("4A")(in)(rt);
XnewR.r5;
XnewCDM.m5 "angle(180)";
XObjMLP.m5("I_2")(is)(top);
XnewR.r6;
XnewCDM.m6;
XObjMLP.m6("7A")(in)(top);
XnewR.r7;
XnewCDM.m7 "angle(180)";
XObjMLP.m7("I_4")(is)(top);
XnewR.r8;
XnewCDM.m8;
XObjMLP.m8("2A")(in)(top);

XnewNode.n1;

X(r1).c = origin;
X(r2).c = X(r1).c+UD(6,0);
X(r3).c = X(r2).c+UD(6,0);
X(r4).c = X(r3).c+UD(6,0);
X(r5).c = X(r1).c+UD(3,3);
X(r6).c = X(r5).c+UD(6,0);
X(r7).c = X(r6).c+UD(6,0);
X(r8).c = X(r6).c+UD(0,3);
X(n1).c = X(r1).c + UD(0,-3);
X(m1).is = X(r1).n;
X(m2).is = X(r2).s;
X(m3).is = X(r3).s;
X(m4).is = X(r4).s;
X(m5).in = X(r5).n;
X(m6).is = X(r6).n;
X(m7).in = X(r7).n;
X(m8).is = X(r8).n;
Xpclist(
	"r1,2,r5,1",
	"r1,2,r8,1",
	"r2,2,r5,2",
	"r2,2,r6,1",
	"r3,2,r6,2",
	"r3,2,r7,1",
	"r4,2,r7,2",
	"r4,2,r8,2",
	"r1,1,n1,-90",
	"n1,0,r2,1",
	"n1,0,r3,1",
	"n1,0,r4,1"
);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8);
XdrawObj(m1,m2,m3,m4,m5,m6,m7,m8);
