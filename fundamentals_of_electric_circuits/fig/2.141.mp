XnewRa.r1 "angle(-90)";
XObjMLP.r1("40 \Omega")(is)(lft);
XnewRa.r2 "angle(-90)";
XObjMLP.r2("40 \Omega")(in)(rt);

XnewRa.r3;
XObjMLP.r3("30 \Omega")(is)(bot);

XnewRa.r4 "angle(-90)";
XObjMLP.r4("30 \Omega")(in)(rt);

XnewRa.r5;
XObjMLP.r5("30 \Omega")(is)(bot);

XnewRa.r6 "angle(-90)";
XObjMLP.r6("75 \Omega")(is)(lft);

XnewNode.n1;
XnewSquareNode.sn1;
XObjMLP.sn1("1")(is)(bot);
XnewNode.n2;
XnewSquareNode.sn2;
XObjMLP.sn2("2")(is)(bot);
XnewNode.n3;
XnewSquareNode.sn3;
XObjMLP.sn3("3")(in)(top);
XnewNode.n4;
XnewSquareNode.sn4;
XObjMLP.sn4("4")(in)(top);

XnewNode.no;

X(no).c = origin;
X(r3).c = X(no).c + UD(0,3);
X(r4).c = X(no).c + UD(3,0);
X(r5).c = X(no).c + UD(0,-3);
X(r1).c = X(r3).c + UD(-3,3);
X(r2).c = X(r3).c + UD(3,3);
X(r6).c = X(r5).c + UD(-3,-3);
X(n1).c = X(r6).c + UD(0,-3);
X(n2).c = X(n1).c + UD(6,0);
X(n3).c = X(r2).c + UD(0,3);
X(n4).c = X(r1).c + UD(0,3);
X(sn1).inw = X(n1).c;
X(sn2).ine = X(n2).c;
X(sn3).isw = X(n3).c;
X(sn4).ise = X(n4).c;

draw unitsquare shifted (-0.5,-0.5) scaled UD(9*2) dashed evenly withcolor SteelBlue;
fill (halfcircle--cycle) scaled UD(3) rotated -90 shifted (-UD(9),0) withcolor Yellow;
draw (halfcircle--cycle) scaled UD(3) rotated -90 shifted (-UD(9),0) withcolor FireBrick;

Xpclist(
	"n4,-90,r1,1",
	"n3,-90,r2,1",
	"r1,2,r3,1",
	"r3,2,r2,2",
	"r3,1,r6,1",
	"r3,2,r4,1",
	"r5,1,r6,1",
	"r5,2,r4,2",
	"r6,2,n1,-90",
	"r4,2,n2,-90"
);

XdrawObj(r1,r2,r3,r4,r5,r6,sn1,sn2,sn3,sn4);
