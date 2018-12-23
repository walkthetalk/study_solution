XnewNode.n1;
XnewNode.n2;
XObjMLP.n2("A")(iw)(lft);
XnewNode.n3;
XnewNode.n4;
XnewNode.n5;
XObjMLP.n5("B")(ie)(rt);
XnewNode.n6;

X(n1).c = X(n2).c + UD(0,-4);
X(n2).c = origin;
X(n3).c = X(n2).c + UD(0, 4);
X(n4).c = X(n5).c + UD(0,-4);
X(n5).c = X(n2).c + UD(8, 0);
X(n6).c = X(n5).c + UD(0, 4);

XdrawObj(n1,n2,n3,n4,n5,n6);

Xncline(n2)(n3);
Xncline(n2)(n1);
Xncline(n5)(n6);
Xncline(n5)(n4);
Xncline(n2)(n5);
Xncline(n4)(n1);
Xncline(n6)(n3);
Xnccurve(n4)(n6) "angleA(0)", "angleB(180)";
Xnccurve(n3)(n1) "angleA(180)", "angleB(0)";

XnewCDM.b23 "angle(90)";
XObjMLP.b23("1A")(is)(rt);
X(b23).in = (X(n2).c+X(n3).c)/2;
XnewCDM.b21 "angle(-90)";
XObjMLP.b21("i_1")(in)(rt);
X(b21).is = (X(n2).c + X(n1).c)/2;
XnewCDM.b56 "angle(90)";
XObjMLP.b56("i_2")(is)(rt);
X(b56).in = (X(n5).c+X(n6).c)/2;
XnewCDM.b54 "angle(-90)";
XObjMLP.b54("2A")(in)(rt);
X(b54).is = (X(n5).c+X(n4).c)/2;
XnewCDM.b25;
XObjMLP.b25("-6A")(is)(bot);
X(b25).in = (X(n2).c+X(n5).c)/2;
XnewCDM.b41 "angle(180)";
XObjMLP.b41("-2A")(in)(bot);
X(b41).is = (X(n1).c+X(n4).c)/2;
XnewCDM.b63 "angle(180)";
XObjMLP.b63("-4A")(is)(top);
X(b63).in = (X(n6).c+X(n3).c)/2;
XnewCDM.b31 "angle(-90)";
XObjMLP.b31("-3A")(is)(lft);
X(b31).in = X(n2).c + UD(-3, 0);
XnewCDM.b46 "angle(90)";
XObjMLP.b46("i_3")(is)(rt);
X(b46).in = X(n5).c + UD(3, 0);

XdrawObj(b23,b21,b56,b54,b25,b41,b63,b31,b46); 
