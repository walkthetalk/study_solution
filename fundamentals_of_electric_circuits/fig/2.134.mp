XnewRa.r1 "angle(90)";
XObjMLP.r1("R_1")(is)(rt);
XnewRa.r2 "angle(90)";
XObjMLP.r2("R_2")(is)(rt);
XnewRa.r3 "angle(90)";
XObjMLP.r3("R_3")(is)(rt);
XnewFuse.u1;

XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;

X(n1).c = origin;
X(n2).c = X(n1).c + UD(3,0) rotated 60;
X(n3).c = X(n1).c + UD(3,0);
X(n4).c = X(n1).c + UD(3,0) rotated -60;
X(u1).c = X(n1).c + UD(-3,0);

XdrawObj(u1,n2,n3,n4);
