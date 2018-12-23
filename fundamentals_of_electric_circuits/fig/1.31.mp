XnewR.r0;
XObjMLP.r0("-")(ine)(top);
XObjMLP.r0("+")(inw)(top);
XObjMLP.r0("12V")(n)(top) "labshift(UD(0,1))";
XObjMLP.r0("p_2")(is)(bot);

XnewR.r1 "angle(90)";
XObjMLP.r1("+")(ine)(lft);
XObjMLP.r1("-")(inw)(lft);
XObjMLP.r1("V_0")(n)(lft);
XObjMLP.r1("p_3")(is)(rt);

XnewR.r2;
XObjMLP.r2("-")(ise)(bot);
XObjMLP.r2("+")(isw)(bot);
XObjMLP.r2("28V")(is)(bot) "labshift(UD(0,-1))";
XObjMLP.r2("p_4")(ie)(urt);

XnewR.r3;
XObjMLP.r3("-")(ise)(bot);
XObjMLP.r3("+")(isw)(bot);
XObjMLP.r3("28V")(is)(bot) "labshift(UD(0,-1))";
XObjMLP.r3("p_5")(ie)(urt);

XnewDVS.u2 "angle(-90)";
XObjMLP.u2("5I_0")(in)(rt);
XObjMLP.u2("p_6")(is)(lft);

XnewIVS.u1 "angle(90)";
XObjMLP.u1("30V")(in)(lft);
XObjMLP.u1("p_1")(is)(rt);

XnewCDM.cdm0 "angle(90)";
XObjMLP.cdm0("6A")(in)(lft);
XnewCDM.cdm1;
XObjMLP.cdm1("6A")(in)(top);
XnewCDM.cdm2 "angle(-90)";
XObjMLP.cdm2("3A")(is)(lft);
XnewCDM.cdm3;
XObjMLP.cdm3("1A")(in)(top);
XnewCDM.cdm4;
XObjMLP.cdm4("I_0=2A")(in)(top);
XnewCDM.cdm5 "angle(-90)";
XObjMLP.cdm5("3A")(in)(rt);

XnewNode.n1;

X(r1).c = origin;
X(n1).c = X(r1).c + UD(0,-3);
X(r0).c = X(r1).c + UD(-5, 4);
X(r2).c = X(r1).c + UD( 5, 4);
X(r3).c = X(r2).c + UD( 0, 5);
X(u1).c = X(r1).c + UD(-10,0);
X(u2).c = X(r1).c + UD( 10,0);
X(cdm0).ssw = (xpart X(u1).c, ypart X(n1).c);
X(cdm1).ssw = (xpart X(u1).c, ypart X(r0).c);
X(cdm2).ne  = X(r1).e;
X(cdm3).sw  = (xpart X(r1).c, ypart X(r2).c);
X(cdm4).sw  = (xpart X(r1).c, ypart X(r3).c);
X(cdm5).sse = (xpart X(u2).c, ypart X(n1).c);

XdrawObj(r0,r1,r2,r3,u1,u2);
Xpclist(
	"u1,2,r0,1",
	"r0,2,r1,2",
	"r1,2,r2,1",
	"r1,2,r3,1",
	"r2,2,u2,1",
	"r3,2,u2,1",
	"r1,1,n1,-90",
	"n1,0,u2,2",
	"n1,180,u1,1"
);
XdrawObj(cdm0, cdm1, cdm2, cdm3, cdm4, cdm5); 
