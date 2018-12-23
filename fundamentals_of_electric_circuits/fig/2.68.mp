XnewIVS.v0"angle(90)";
XObjMLP.v0("40V")(is)(rt);
XnewRa.r0 "angle(90)";
XObjMLP.r0("100\Omega")(is)(rt);
XnewRa.r1 "angle(90)";
XObjMLP.r1("250\Omega")(is)(rt);
XnewSwitch.s0(1) "angle(90)";
XObjMLP.s0("1")(pin[1])(lft);
XObjMLP.s0("2")(pin[2])(rt);
XnewCDM.cdm0 "angle(90)";
XObjMLP.cdm0("i")(is)(rt);

X(v0).c = origin;
X(s0).c = X(v0).c  + UD(0, 5);
X(r0).c = X(v0).ie + UD(-6, 0);
X(r1).c = X(v0).ie + UD( 6, 0);
X(cdm0).nw = X(v0).ie;

XdrawObj(v0,r0,r1,s0,cdm0);
Xpclist(
	"s0,1,r0,2",
	"s0,2,r1,2",
	"s0,3,v0,2",
	"v0,1,r0,1",
	"v0,1,r1,1",
);
