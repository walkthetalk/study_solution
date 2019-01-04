XnewRa.r1;
XObjMLP.r1("R")(in)(top);
XnewARa.r2 "angle(-90)";
XnewIVS.u1 "angle(90)";
XObjMLP.u1("v_s")(in)(lft);

XnewCDM.m1 "angle(90)", "arrows(drawdblarrow)", "dx(12)";
XObjMLP.m1("R")(in)(lft);
XnewCDM.m2 "angle(90)", "arrows(drawdblarrow)", "dx(6)";
XObjMLP.m2("\alpha R")(is)(rt);

XnewNode.n1 "pathfillcolor(White)";
XObjMLP.n1("+")(is)(bot);
XnewNode.n2 "pathfillcolor(White)";
XObjMLP.n2("-")(in)(top);
XnewNode.n3 "visible(false)";
XObjMLP.n3("v_o")(ic)(c);

X(u1).c = origin;
X(r1).c = X(u1).c + UD(4,6);
X(r2).c = X(u1).c + UD(8,0);
X(n1).c = X(r2).c + UD(6,6);
X(n2).c = X(r2).c + UD(6,-6);
X(m1).s = X(r2).is;
X(m2).nnw = X(r2).ine + UD(1,0);
X(n3).c = (X(n1).c + X(n2).c)/2;

Xpclist(
	"u1,2,r1,1",
	"r1,2,r2,1",
	"r2,1,n1,0",
	"u1,1,n2,0",
	"r2,2,n2,0"
);

XdrawObj(u1,r1,r2,m1,m2,n1,n2,n3);
