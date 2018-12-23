XnewR.r1 "angle(90)";
XObjMLP.r1("+")(ise)(rt);
XObjMLP.r1("-")(isw)(rt);
XObjMLP.r1("V_1")(is)(rt);

XnewR.r2;
XObjMLP.r2("+")(inw)(top);
XObjMLP.r2("-")(ine)(top);
XObjMLP.r2("1V")(in)(top) "labshift(UD(0,1))";

XnewR.r3 "angle(90)";
XObjMLP.r3("+")(ise)(rt);
XObjMLP.r3("-")(isw)(rt);
XObjMLP.r3("5V")(is)(rt);

XnewR.r4;
XObjMLP.r4("+")(inw)(top);
XObjMLP.r4("-")(ine)(top);
XObjMLP.r4("2V")(in)(top) "labshift(UD(0,1))";

XnewR.r5 "angle(90)";
XObjMLP.r5("V_2")(is)(rt);
XObjMLP.r5("+")(ise)(rt);
XObjMLP.r5("-")(isw)(rt);

XnewNode.n1;

X(r3).c = origin;
X(r1).c = X(r3).c+UD(-6,0);
X(r5).c = X(r3).c+UD( 6,0);
X(r2).c = X(r3).c+UD(-3,4);
X(r4).c = X(r3).c+UD( 3,4);
X(n1).c = X(r3).c + UD(0,-3);
Xpclist(
	"r5,2,r4,2",
	"r3,1,n1,-90",
	"n1,0,r5,1",
	"n1,180,r1,1",
	"r3,2,r4,1",
	"r3,2,r2,2",
	"r1,2,r2,1"
);
XdrawObj(r1,r2,r3,r4,r5); 
