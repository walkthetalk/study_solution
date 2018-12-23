XnewRa.r1 "angle(90)";
XObjMLP.r1("3\Omega")(is)(rt);
XObjMLP.r1("p_4")(in)(lft);
XnewIVS.u1 "angle(180)";
XObjMLP.u1("10V")(is)(top);
XObjMLP.u1("p_1")(in)(bot);
XnewIVS.u2 "angle(90)";
XObjMLP.u2("12V")(in)(lft);
XObjMLP.u2("p_2")(is)(rt);
XnewIVS.u3 "angle(180)";
XObjMLP.u3("-8V")(in)(bot);
XObjMLP.u3("p_3")(is)(top);

XnewCDM.m0 "angle(-90)";
XObjMLP.m0("I")(in)(rt);

X(r1).c = UD(4,0);
X(u1).c = UD(0,4);
X(u2).c = UD(-4,0);
X(u3).c = UD(0,-4);
X(m0).se = X(r1).ie;

XdrawObj(r1,u1,u2,u3,m0);
Xpclist(
	"r1,2,u1,1",
	"r1,1,u3,1",
	"u2,2,u1,2",
	"u2,1,u3,2"
);
