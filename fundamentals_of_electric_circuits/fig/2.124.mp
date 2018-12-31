XnewLightBulb.lb1 "angle(-90)";
XObjMLP.lb1("R_x")(in)(rt);
XnewLightBulb.lb2 "angle(-90)";
XObjMLP.lb2("R_y")(in)(rt);

XnewLabelNode.u1("\framedtext[width=fit,frame=off,align=middle]{70-W\\Power\\Supply}");
XObjMLP.u1("+")(in)(ulft);
XObjMLP.u1("-")(is)(llft);

XnewCDM.m1;
XObjMLP.m1("I")(in)(top);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(u1).c = origin;
X(lb1).is = X(u1).c + UD(9,0);
X(lb2).is = X(lb1).c + UD(9,0);
X(n1).c = X(u1).in;
X(n2).c = X(n1).c + UD(0,2);
X(m1).s = X(n2).c + UD(4.5,0);
X(n3).c = X(u1).is;
X(n4).c = X(n3).c + UD(0,-2);

XdrawObj(u1,lb1,lb2,m1);
Xpclist(
	"n1,90,n2,90",
	"n3,-90,n4,-90",
	"n2,0,lb1,1",
	"n2,0,lb2,1",
	"n4,0,lb1,2",
	"n4,0,lb2,2"
);
