XnewIVS.u1 "angle(90)";
XObjMLP.u1("p_1")(is)(rt);
XObjMLP.u1("30V")(in)(lft);
XnewR.r2;
XObjMLP.r2("p_2")(is)(bot);
XObjMLP.r2("+")(inw)(top);
XObjMLP.r2("-")(ine)(top);
XObjMLP.r2("10V")(in)(top) "labshift(UD(0,1))";
XnewR.r3 "angle(90)";
XObjMLP.r3("p_3")(is)(rt);
XObjMLP.r3("+")(ine)(lft);
XObjMLP.r3("-")(inw)(lft);
XObjMLP.r3("20V")(in)(lft);
XnewR.r4;
XObjMLP.r4("p_4")(is)(bot);
XObjMLP.r4("+")(inw)(top);
XObjMLP.r4("-")(ine)(top);
XObjMLP.r4("8V")(in)(top) "labshift(UD(0,1))";
XnewDCS.u2 "angle(90)";
XObjMLP.u2("p_5")(is)(urt);
XObjMLP.u2("0.4I")(is)(lrt);
XObjMLP.u2("12V")(in)(lft);
XObjMLP.u2("+")(ie)(ulft);
XObjMLP.u2("-")(iw)(llft);
XnewCDM.cdm0 "angle(180)";
XObjMLP.cdm0("4A")(is)(top);
XnewCDM.cdm1;
XObjMLP.cdm1("I=10A")(in)(top);
XnewCDM.cdm2 "angle(-90)";
XObjMLP.cdm2("14A")(in)(rt);

XnewNode.n1;

X(r3).c = origin;
X(u1).c = X(r3).c+UD(-9,0);
X(u2).c = X(r3).c+UD( 9,0);
X(r2).c = X(r3).c+UD(-3,6);
X(r4).c = X(r3).c+UD( 3,6);
X(n1).c = X(r3).c+UD(0,-4);

X(cdm0).nnw = (xpart(X(u2).c), ypart(X(r4).c));
X(cdm1).ssw = (xpart(X(u1).c), ypart(X(r2).c));
X(cdm2).se = X(r3).ie;

Xpclist(
	"u2,2,r4,2",
	"r3,1,n1,-90",
	"n1,0,u2,1",
	"n1,180,u1,1",
	"r3,2,r4,1",
	"r3,2,r2,2",
	"u1,2,r2,1"
);

XdrawObj(u1,r2,r3,r4,u2);
XdrawObj(cdm0,cdm1,cdm2); 
