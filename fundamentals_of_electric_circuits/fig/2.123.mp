XnewLightBulb.lb1;
XObjMLP.lb1("40 \text{Watt}")(is)(bot);
XnewLightBulb.lb2;
XObjMLP.lb2("100 \text{Watt}")(ie)(rt);
XnewLightBulb.lb3;
XObjMLP.lb3("60 \text{Watt}")(is)(bot);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(n2).c + UD(6,0);
X(n4).c = X(n3).c + UD(6,0);

X(lb1).is = (X(n1).c + X(n2).c)/2;
X(lb2).is = (X(n2).c + X(n3).c)/2;
X(lb3).is = X(lb2).c + UD(0,-9);

XdrawObj(lb1, lb2, lb3);

Xpclist(
	"n1,0,lb1,1",
	"lb1,2,lb2,1",
	"lb2,2,n4,0",
	"n2,-90,lb3,1",
	"lb3,2,n3,90"
);
