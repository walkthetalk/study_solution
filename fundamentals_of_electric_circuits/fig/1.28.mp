XnewR.r1 "angle(90)";
XObjMLP.r1("1")(c)(c) "labcolor(FireBrick)";

XnewR.r2 "angle(90)";
XObjMLP.r2("2")(c)(c) "labcolor(FireBrick)";

XnewR.r4 "angle(90)";
XObjMLP.r4("4")(c)(c) "labcolor(FireBrick)";

XnewR.r3 "angle( 0)";
XObjMLP.r3("3")(c)(c) "labcolor(FireBrick)";

XnewNode.n1;

X(r2).c = origin;
X(n1).c = X(r2).c+UD(0,-3);
X(r1).c = X(r2).c+UD(-4,0);
X(r4).c = X(r2).c+UD( 6,0);
X(r3).c = (X(r2).c+X(r4).c)/2 + UD(0,3);

XdrawObj(r1,r2,r3,r4);

Xpclist(
	"r3,2,r4,2",
	"r2,2,r3,1",
	"r3,1,r1,2",
	"r2,1,n1,-90",
	"n1,0,r4,1",
	"n1,180,r1,1" 
);
