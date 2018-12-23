XnewNode.n0;
XnewNode.n1;
XnewNode.n2;
XnewNode.n3;

XnewNode.n4;
XnewNode.n5;

XnewCDM.b0 "angle(180)";
XObjMLP.b0("i_b")(is)(top);
XnewCDM.b1 "angle(-90)";
XObjMLP.b1("i_1")(in)(rt);
XnewCDM.b2 "angle(90)";
XObjMLP.b2("i_2")(in)(lft);
XnewCDM.b3 "angle(180)";
XObjMLP.b3("i_c")(is)(top);
XnewCDM.b4 "angle(-90)";
XObjMLP.b4("i_3")(in)(rt);
XnewCDM.b5 "angle(180)";
XObjMLP.b5("i_a")(is)(top);

X(n2).c = origin;
X(n0).c = X(n2).c + UD(-3, 3);
X(n1).c = X(n2).c + UD( 3, 3);
X(n3).c = X(n2).c + UD( 0,-3);
X(b0).c = (X(n0).c + X(n1).c)/2;
X(b1).c = X(n1).c + UD(0,-1.5);
X(b2).c = X(n0).c + UD(0,-1.5);
X(b3).c = X(n3).c + UD(3,   0);
X(b4).c = X(n2).c + UD(0,-1.5);
X(b5).c = X(n3).c + UD(-3,  0);

X(n4).c = X(n0).c + UD(-3,0);
X(n5).c = X(n1).c + UD(3,0);

XdrawObj(n0,n1,n2,n3);
Xpclist(
	"n2,180,n0,90",
	"n2,0,n1,-90",
	"n1,180,n0,180",
	"n1,0,n5,0",
	"n5,-90,n3,180",
	"n3,180,n4,90",
	"n4,0,n0,0",
	"n2,-90,n3,-90"
);
XdrawObj(b0,b1,b2,b3,b4,b5); 
