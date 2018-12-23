XnewR.r0 "angle(90)";
XObjMLP.r0("-")(ise)(rt);
XObjMLP.r0("+")(isw)(rt);
XObjMLP.r0("15V")(is)(rt);
XObjMLP.r0("p_2")(ine)(ulft);

XnewR.r1 "angle(90)";
XObjMLP.r1("-")(ise)(rt);
XObjMLP.r1("+")(isw)(rt);
XObjMLP.r1("9V")(is)(rt);
XObjMLP.r1("p_3")(ine)(lft);

XnewIVS.u2 "angle(-90)";
XObjMLP.u2("6V")(in)(rt);
XObjMLP.u2("p_4")(ise)(llft);

XnewICS.u1 "angle(-90)";
XObjMLP.u1("15V")(in)(rt);
XObjMLP.u1("10A")(is)(lft);
XObjMLP.u1("-")(inw)(rt);
XObjMLP.u1("+")(ine)(rt);
XObjMLP.u1("p_1")(isw)(ulft);

XnewCDM.cdm0 "angle(-90)";
XObjMLP.cdm0("I")(in)(rt);
XnewCDM.cdm1 "angle(90)";
XObjMLP.cdm1("4A")(is)(rt);

XnewNode.n1;
XnewNode.n2;

X(r0).c = origin;
X(r1).c = X(r0).c + UD(5,2);
X(u2).c = X(r1).c + UD(0,-4);
X(u1).c = X(r0).c + UD(-5,0);
X(n1).c = X(r1).c + UD(0,4);
X(n2).c = X(u2).c + UD(0,-3);
X(cdm0).ssw = X(n1).c;
X(cdm1).ne  = (xpart X(r0).c, ypart X(n1).c);

XdrawObj(r0,r1,u1,u2);
Xpclist(
	"r0,2,n1,0",
	"n1,-90,r1,2",
	"n1,180,u1,1",
	"u2,2,n2,-90",
	"r0,1,n2,0",
	"u1,2,n2,0",
	"r1,1,u2,1",
);
XdrawObj(cdm0,cdm1);
