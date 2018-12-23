XnewNode.n0;
XnewNode.n1;
XnewNode.n2;
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XnewNode.n6;
XnewNode.n7;
XnewNode.n8;

X(n0).c = origin;
X(n2).c = X(n0).c + UD(4, 0);
X(n4).c = X(n2).c + UD(4, 0);
X(n7).c = X(n4).c + UD(4, 0);
X(n1).c = X(n0).c + UD(0, 4);
X(n3).c = X(n1).c + UD(4, 0);
X(n5).c = X(n3).c + UD(4, 0);
X(n8).c = X(n5).c + UD(4, 0);
X(n6).c = X(n5).c + UD(0, 4);

XdrawObj(n0,n1,n2,n3,n4,n5,n6,n7,n8);

Xncline(n0)(n1);
Xncline(n0)(n2);
Xncline(n1)(n2);
Xncline(n1)(n3);
Xncline(n2)(n3);
Xncline(n2)(n4);
Xncline(n3)(n5);
Xncline(n4)(n5);
Xncline(n4)(n7);
Xncline(n5)(n8);
Xncline(n7)(n8);
Xncline(n5)(n7);
Xncline(n3)(n6);
Xncline(n5)(n6);
Xncline(n8)(n6); 
