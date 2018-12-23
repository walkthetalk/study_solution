XnewRa.r1;
XObjMLP.r1("R_1")(in)(top);
XObjMLP.r1("+")(isw)(bot);
XObjMLP.r1("-")(ise)(bot);
XObjMLP.r1("v_1")(is)(bot) "labshift(UD(0,-1))";
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_2")(is)(rt);
XObjMLP.r2("+")(ine)(lft);
XObjMLP.r2("-")(inw)(lft);
XObjMLP.r2("v_2")(in)(lft);
XnewRa.r3 "angle(90)";
XObjMLP.r3("R_3")(is)(rt);
XObjMLP.r3("+")(ine)(lft);
XObjMLP.r3("-")(inw)(lft);
XObjMLP.r3("v_3")(in)(lft);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("V_s")(in)(lft);


XnewNode.n1;
XnewNode.n2;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0, 4);
X(n2).c = X(u1).c + UD(0,-4);
X(r1).c = X(n1).c + UD(4,0);
X(r2).c = X(u1).c + UD(8,0);
X(r3).c = X(r2).c + UD(6,0);

XdrawObj(r1,r2,r3,u1);
Xpclist(
	"u1,2,n1,90",
	"n1,0,r1,1",
	"r1,2,r2,2",
	"r1,2,r3,2",
	"u1,1,n2,-90",
	"n2,0,r2,1",
	"n2,0,r3,1"
);
