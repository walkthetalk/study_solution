XnewRa.r1;
XObjMLP.r1("R")(in)(top);
XnewRa.r2;
XObjMLP.r2("R")(in)(top);
XnewRa.r3;
XObjMLP.r3("R")(in)(top);
XnewRa.r4 "angle(90)";
XObjMLP.r4("R")(is)(rt);

XnewRa.r5;
XObjMLP.r5("R")(in)(top);
XnewRa.r6;
XObjMLP.r6("R")(in)(top);
XnewRa.r7;
XObjMLP.r7("R")(in)(top);
XnewRa.r8;
XObjMLP.r8("R")(in)(top);
XnewRa.r9 "angle(90)";
XObjMLP.r9("R")(is)(rt);

XnewRa.r10;
XObjMLP.r10("R")(in)(top);
XnewRa.r11;
XObjMLP.r11("R")(in)(top);
XnewRa.r12;
XObjMLP.r12("R")(in)(top);
XnewRa.r13;
XObjMLP.r13("R")(in)(top);
XnewRa.r14 "angle(90)";
XObjMLP.r14("R")(is)(rt);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;

XnewNode.na "pathfillcolor(White)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfillcolor(White)";
XObjMLP.nb("b")(iw)(lft);

X(r1).c = origin;
X(n1).c = X(r1).c + UD(3,0);
X(r4).c = X(n1).c + UD(6,0);
X(r2).c = (X(n1).c + X(r4).c)/2 + UD(0,3);
X(r3).c = (X(n1).c + X(r4).c)/2 + UD(0,-3);
X(n2).c = X(r2).c + UD(6,0);
X(n3).c = X(r3).c + UD(6,0);

X(r9).c = X(n2).c + UD(6,3);
X(r5).c = X(r9).c + UD(-3,3);
X(r6).c = X(r9).c + UD(3,3);
X(r7).c = X(r9).c + UD(-3,-3);
X(r8).c = X(r9).c + UD(3,-3);
X(n4).c = X(r9).c + UD(6,0);

X(r14).c = X(n3).c + UD(6,-3);
X(r10).c = X(r14).c + UD(-3,3);
X(r11).c = X(r14).c + UD(3,3);
X(r12).c = X(r14).c + UD(-3,-3);
X(r13).c = X(r14).c + UD(3,-3);
X(n5).c = X(r14).c + UD(6,0);

X(n6).c = (X(n4).c + X(n5).c)/2 + UD(3,0);

X(na).c = X(r1).c + UD(-3,0);
X(nb).c = X(na).c + UD(0,-12);

Xpclist(
	"r1,2,n1,0",
	"n1,90,r2,1",
	"n1,-90,r3,1",
	"r2,2,n2,0",
	"r3,2,n3,0",
	"r4,2,n2,0",
	"r4,1,n3,0",
	"n2,90,r5,1",
	"n2,-90,r7,1",
	"r5,2,r6,1",
	"r7,2,r8,1",
	"r9,1,r8,1",
	"r9,2,r6,1",
	"r6,2,n4,-90",
	"r8,2,n4,90",
	"n3,90,r10,1",
	"n3,-90,r12,1",
	"r10,2,r11,1",
	"r10,2,r14,2",
	"r12,2,r13,1",
	"r12,2,r14,1",
	"r11,2,n5,-90",
	"r13,2,n5,90",
	"n4,0,n6,-90",
	"n5,0,n6,90",
	"na,0,r1,1",
	"nb,0,n6,90"
);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,na,nb);
