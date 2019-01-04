XnewLabelNode.u1("Amplifier")("");
XnewLoudspeaker.u2;

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(u1).c = origin;
X(n1).c = X(u1).c + UD(0,3);
X(n2).c = X(u1).c + UD(0,-3);
X(u2).c = X(u1).c + UD(6,0);
X(n3).c = X(u1).in;
X(n4).c = X(u1).is;

Xpclist(
	"n3,90,n1,90",
	"n1,0,u2,1",
	"n4,-90,n2,-90",
	"n2,0,u2,2"
);

XdrawObj(u1,u2);
