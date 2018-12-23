XnewR.r1 "angle(90)";
XObjMLP.r1("3V")(in)(lft);
XObjMLP.r1("+")(ine)(lft);
XObjMLP.r1("-")(inw)(lft);
XnewR.r2 "angle(90)";
XObjMLP.r2("V_1")(in)(lft);
XObjMLP.r2("+")(ine)(lft);
XObjMLP.r2("-")(inw)(lft);
XnewR.r3 "angle(90)";
XObjMLP.r3("V_2")(is)(rt);
XObjMLP.r3("-")(ise)(rt);
XObjMLP.r3("+")(isw)(rt);
XnewR.r4 "angle(90)";
XObjMLP.r4("4V")(in)(lft);
XObjMLP.r4("-")(ine)(lft);
XObjMLP.r4("+")(inw)(lft);
XnewR.r5 "angle(90)";
XObjMLP.r5("V_4")(is)(rt);
XObjMLP.r5("+")(ise)(rt);
XObjMLP.r5("-")(isw)(rt);
XnewR.r6 "angle(90)";
XObjMLP.r6("5V")(is)(rt);
XObjMLP.r6("+")(ise)(rt);
XObjMLP.r6("-")(isw)(rt);
XnewR.r7;
XObjMLP.r7("V_3")(is)(bot);
XObjMLP.r7("+")(isw)(bot);
XObjMLP.r7("-")(ise)(bot);
XnewR.r8;
XObjMLP.r8("2V")(in)(top);
XObjMLP.r8("+")(inw)(top);
XObjMLP.r8("-")(ine)(top);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

X(n1).c = origin;
X(r2).c = X(n1).c + UD(0,3);
X(r5).c = X(n1).c + UD(0,-3);
X(r7).c = X(n1).c + UD(-3,0);
X(r8).c = X(n1).c + UD(3,0);
X(n2).c = X(r2).c + UD(0,3);
X(n3).c = X(r5).c + UD(0,-3);
X(r1).c = X(r2).c+UD(-6,0);
X(r3).c = X(r2).c+UD(6,0);
X(r4).c = X(r5).c+UD(-6,0);
X(r6).c = X(r5).c+UD(6,0);

Xpclist(
	"r2,2,n2,90",
	"r1,2,n2,0",
	"r3,2,n2,180",
	"r4,1,n3,0",
	"r5,1,n3,-90",
	"r6,1,n3,180",
	"r7,1,r1,1",
	"r7,1,r4,2",
	"r8,2,r3,1",
	"r8,2,r6,2",
	"r2,1,r5,2",
	"r7,2,r8,1"
);

XdrawObj(r1,r2,r3,r4,r5,r6,r7,r8);
