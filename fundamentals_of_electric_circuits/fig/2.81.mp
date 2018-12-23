XnewRa.r1;
XObjMLP.r1("+")(inw)(top);
XObjMLP.r1("-")(ine)(top);
XObjMLP.r1("v_1")(in)(top) "labshift(UD(0,1))";
XnewRa.r2 "angle(45)";
XObjMLP.r2("+")(inw)(lft);
XObjMLP.r2("-")(ine)(top);
XObjMLP.r2("v_2")(in)(ulft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("+")(ise)(rt);
XObjMLP.r3("-")(isw)(rt);
XObjMLP.r3("v_3")(is)(rt);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("24V")(in)(lft);
XnewIVS.u2;
XObjMLP.u2("12V")(is)(bot);
XnewIVS.u3 "angle(90)";
XObjMLP.u3("10V")(is)(rt);

XnewNode.n1;
XnewNode.n2;

X(r2).c = origin;
X(r1).c = X(r2).c + UD(0,4);
X(r3).c = X(r2).c + UD(4,0);
X(u1).c = X(r2).c + UD(-4,0);
X(u2).c = X(r2).c + UD(0,-4);
X(u3).c = X(r3).c + UD(4, 0);
X(n1).c = X(r3).c + UD(0,4);
X(n2).c = X(u1).c + UD(0,-4);

XdrawObj(r1,r2,r3,u1,u2,u3);
Xpclist(
	"u1,2,r1,1",
	"u1,1,n2,-90",
	"n2,45,r2,1",
	"n2,0,u2,1",
	"r1,2,n1,0",
	"r2,2,n1,45",
	"r3,2,n1,90",
	"n1,0,u3,2",
	"u2,2,r3,1",
	"u2,2,u3,1",
);
