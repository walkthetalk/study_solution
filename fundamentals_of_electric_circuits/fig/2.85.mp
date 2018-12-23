XnewRa.r1;
XObjMLP.r1("1\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("2\Omega")(is)(bot);
XnewRa.r3 "angle(90)";
XObjMLP.r3("5\Omega")(in)(lft);
XObjMLP.r3("+")(ise)(rt);
XObjMLP.r3("V_x")(is)(rt);
XObjMLP.r3("-")(isw)(rt);
XnewIVS.u1 "angle(90)";
XObjMLP.u1("15V")(in)(lft);
XnewDVS.u2 "angle(180)";
XObjMLP.u2("2V_x")(is)(top);

X(r1).c = UD(-3, 3);
X(u2).c = UD(3, 3);
X(r2).c = UD(0, -3);
X(r3).c = UD(6, 0);
X(u1).c = UD(-6,0);

XdrawObj(r1,r2,r3,u1,u2);
Xpclist(
	"r1,2,u2,2",
	"r1,1,u1,2",
	"u1,1,r2,1",
	"r2,2,r3,1",
	"r3,2,u2,1"
);
