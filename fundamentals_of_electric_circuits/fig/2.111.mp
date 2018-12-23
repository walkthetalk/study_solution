XnewRa.r1 "angle(45)";
XObjMLP.r1("5\Omega")(in)(ulft);
XnewRa.r2;
XObjMLP.r2("10\Omega")(in)(top);
XnewRa.r3 "angle(-45)";
XObjMLP.r3("20\Omega")(is)(llft);
XnewRa.r4 "angle(-45)";
XObjMLP.r4("6\Omega")(in)(urt);
XnewRa.r5;
XObjMLP.r5("8\Omega")(in)(top);
XnewRa.r6 "angle(45)";
XObjMLP.r6("3\Omega")(is)(lrt);

XnewNode.na "pathfilled(false)";
XObjMLP.na("a")(ie)(rt);
XnewNode.nb "pathfilled(false)";
XObjMLP.nb("b")(iw)(lft);
XnewNode.nc;
XnewNode.nd;
XnewNode.ne;
XnewNode.nf;
XnewNode.ng;
XnewNode.nh;

X(na).c = UD(-2,0);
X(r2).c = X(na).c + UD(-3,0);
X(nd).c = X(r2).c + UD(-3,0);
X(nb).c = -X(na).c;
X(r5).c = -X(r2).c;
X(ne).c = -X(nd).c;

X(nc).c = X(ne).c rotated 90;
X(nf).c = X(ne).c rotated -90;

X(r1).c = (X(nc).c + X(nd).c)/2;
X(r3).c = (X(nf).c + X(nd).c)/2;
X(r4).c = (X(nc).c + X(ne).c)/2;
X(r6).c = (X(nf).c + X(ne).c)/2;

X(ng).c = (xpart (X(nd).c + UD(-2,0)), ypart (X(nc).c + UD(0,2)));
X(nh).c = (xpart X(ng).c, ypart -X(ng).c);

XdrawObj(r1,r2,r3,r4,r5,r6,na,nb);
Xpclist(
	"na,180,r2,2",
	"r2,1,nd,180",
	"nb,0,r5,1",
	"r5,2,ne,0",

	"nd,45,r1,1",
	"r1,2,nc,45",
	"nf,45,r6,1",
	"r6,2,ne,45",
	"nd,-45,r3,1",
	"r3,2,nf,-45",
	"nc,-45,r4,1",
	"r4,2,ne,-45",

	"ng,0,nc,-90",
	"nh,0,nf,90",
	"ng,-90,nh,-90"
);
