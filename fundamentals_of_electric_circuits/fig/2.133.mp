XnewRa.r1 "angle(-90)";
XObjMLP.r1("R_x")(in)(rt);
XnewPotentiometer.r2 "angle(-90)";
XObjMLP.r2("R")(in)(rt);

XnewICS.u1 "angle(90)";
XObjMLP.u1("I")(in)(lft);
XnewVmeter.u2 "angle(-90)";
XObjMLP.u2("20\Omega")(is)(lft);
XObjTLP.u2("\framedtext[width=fit,frame=off,align=middle,offset=0pt]{Ammeter\\model}")(in)(rt);

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;

XnewNode.n6 "pathfillcolor(white)";
XnewNode.n7 "pathfillcolor(white)";

X(u1).c = origin;
X(n2).c = X(u1).c + UD(6,0);
X(r2).c = X(n2).c + UD(8,0);

X(u2).c = X(n2).c + UD(0,3);
X(n1).c = X(u2).c + UD(0,3);

X(r1).c = X(n2).c + UD(0,-3);
X(n3).c = X(r1).c + UD(0,-3);

X(n4).c = X(n1).c + UD(3,0);
X(n5).c = X(n3).c + UD(3,0);

X(n6).c = X(r1).w + UD(0,0.5);
X(n7).c = X(r1).e + UD(0,-0.5);

ncline(X(n1))(X(n4)) "linestyle(dashed evenly)";
ncline(X(n3))(X(n5)) "linestyle(dashed evenly)";
Xpclist(
	"u1,2,n1,0",
	"n1,-90,u2,1",
	"u2,2,r1,1",
	"r1,2,n3,-90",
	"u1,1,n3,0",
	"n4,0,r2,1",
	"n5,0,r2,2"
);
XdrawObj(r1,r2,u1,u2,n6,n7);
