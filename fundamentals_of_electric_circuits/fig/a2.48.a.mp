XnewRa.rab;
XObjMLP.rab("30\Omega")(in)(top);
XnewRa.rac "angle(-60)";
XObjMLP.rac("30\Omega")(is)(llft);
XnewRa.rbc "angle(60)";
XObjMLP.rbc("30\Omega")(is)(lrt);

XnewNode.na;
XObjMLP.na("a")(iw)(lft);
XnewNode.nb;
XObjMLP.nb("b")(ie)(rt);
XnewNode.nc;
XObjMLP.na("c")(is)(bot);

X(na).c = origin;
X(nb).c = X(na).c + UD(10,0);
X(nc).c = X(na).c + UD(10,0) rotated -60;
X(rab).c = (X(na).c+X(nb).c)/2;
X(rac).c = (X(na).c+X(nc).c)/2;
X(rbc).c = (X(nb).c+X(nc).c)/2;

XdrawObj(rab,rbc,rac,na,nb,nc);
Xpclist(
	"na,0,rab,1",
	"rab,2,nb,0",
	"na,-60,rac,1",
	"rac,2,nc,-60",
	"nc,60,rbc,1",
	"rbc,2,nb,60"
);
