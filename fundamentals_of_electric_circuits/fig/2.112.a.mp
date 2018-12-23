XnewRa.r1;
XObjMLP.r1("10\Omega")(in)(top);
XnewRa.r2;
XObjMLP.r2("10\Omega")(in)(top);
XnewRa.r3 "angle(90)";
XObjMLP.r3("10\Omega")(is)(rt);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(ie)(rt);
XnewNode.nc "pathfilled(false)";
XObjMLP.na("c")(is)(bot);

X(r2).c = UD(3,0);
X(nb).c = X(r2).c + UD(3,0);
X(r1).c = X(r2).c rotated 180;
X(na).c = X(nb).c rotated 180;
X(r3).c = X(r2).c rotated -90;
X(nc).c = X(nb).c rotated -90;

XdrawObj(r1,r2,r3,na,nb,nc);
Xpclist(
	"na,0,r1,1",
	"r1,2,r2,1",
	"r2,2,nb,0",
	"r1,2,r3,2",
	"r3,1,nc,-90"
);
