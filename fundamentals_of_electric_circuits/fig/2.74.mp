newNode.X(n0);
newNode.X(n1);
newNode.X(n2);

newCDM.X(b0) "angle(-120)";
ObjMLabel.X(b0)("i_1")
	"labpoint(in)", "labdir(rt)";
newCDM.X(b1) "angle(60)";
ObjMLabel.X(b1)("-8A")
	"labpoint(in)", "labdir(lft)";
newCDM.X(b2) "angle(120)";
ObjMLabel.X(b2)("4A")
	"labpoint(is)", "labdir(rt)";
newCDM.X(b3) "angle(-60)";
ObjMLabel.X(b3)("i_2")
	"labpoint(is)", "labdir(lft)";
newCDM.X(b4);
ObjMLabel.X(b4)("-6A")
	"labpoint(in)", "labdir(top)";

numeric uc;
uc := 30;
numeric aoff;
aoff := 15;
numeric doff;
doff := .3uc;
X(n0).c = origin;
X(n1).c = X(n0).c + (3uc,0);
X(n2).c = X(n0).c + (3uc,0) rotated 60;
X(b0).c = X(n0).c + (1.5uc,-doff) rotated 60;
X(b1).c = X(n0).c + (1.5uc, doff) rotated 60;
X(b2).c = X(n1).c + (-1.5uc, doff) rotated -60;
X(b3).c = X(n1).c + (-1.5uc,-doff) rotated -60;
X(b4).c = X(n0).c + (1.5uc,0uc);

drawObj(X(n0),X(n1),X(n2));
nccurve(X(n0))(X(n1)) "angleA(-aoff)", "angleB(aoff)";
nccurve(X(n1))(X(n2)) "angleA(120-aoff)", "angleB(120+aoff)";
nccurve(X(n2))(X(n1)) "angleA(-aoff-60)", "angleB(aoff-60)";
nccurve(X(n2))(X(n0)) "angleA(aoff-120)", "angleB(-aoff-120)";
nccurve(X(n0))(X(n2)) "angleA(60+aoff)", "angleB(60-aoff)";
drawObj(X(b0),X(b1),X(b2),X(b3),X(b4)); 
