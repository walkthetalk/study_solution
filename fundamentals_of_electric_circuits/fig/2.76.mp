XnewR.r1 "angle(90)";
XObjMLP.r1("+")(ise)(rt);
XObjMLP.r1("-")(isw)(rt);
XObjMLP.r1("40V")(is)(rt);

XnewR.r2;
XObjMLP.r2("+")(inw)(top);
XObjMLP.r2("-")(ine)(top);
XObjMLP.r2("50V")(in)(top) "labshift(UD(0,1))";

XnewR.r3;
XObjMLP.r3("+")(inw)(top);
XObjMLP.r3("-")(ine)(top);
XObjMLP.r3("20V")(in)(top) "labshift(UD(0,1))";

XnewR.r4;
XObjMLP.r4("+")(inw)(top);
XObjMLP.r4("-")(ine)(top);
XObjMLP.r4("30V")(in)(top) "labshift(UD(0,1))";

XnewR.r5 "angle(90)";
XObjMLP.r5("v_1")(in)(lft);
XObjMLP.r5("+")(ine)(lft);
XObjMLP.r5("-")(inw)(lft);

XnewR.r6;
XObjMLP.r6("v_2")(in)(top) "labshift(UD(0,1))";
XObjMLP.r6("+")(inw)(top);
XObjMLP.r6("-")(ine)(top);

XnewR.r7 "angle(90)";
XObjMLP.r7("v_3")(in)(lft);
XObjMLP.r7("+")(ine)(lft);
XObjMLP.r7("-")(inw)(lft);

XnewNode.n1;
XnewNode.n2;

X(r1).c = origin;
X(r2).c = X(r1).c+UD(3,4);
X(r3).c = X(r2).c+UD(6,0);
X(r4).c = X(r3).c+UD(3,4);
X(r5).c = X(r1).c+UD(12,0);
X(r6).c = X(r3).c+UD(6,0);
X(r7).c = X(r5).c+UD(6,0);
X(n1).c = X(r1).c+UD(0,-3);
X(n2).c = (X(r2).c + X(r3).c)/2;
Xpclist(
	"r1,2,r2,1",
	"r2,2,r3,1",
	"n2,90,r4,1",
	"r3,2,r5,2",
	"r3,2,r6,1",
	"r4,2,r7,2",
	"r6,2,r7,2",
	"r1,1,n1,-90",
	"n1,0,r5,1",
	"n1,0,r7,1"
);

XdrawObj(r1,r2,r3,r4,r5,r6,r7); 
