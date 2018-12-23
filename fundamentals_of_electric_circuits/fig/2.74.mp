numeric aoff;
aoff := 15;
numeric ahn;
ahn  := 40;

XnewNode.n0;
XnewNode.n1;
XnewNode.n2;

XnewCDM.b0 "angle(90-ahn)";
XObjMLP.b0("-8A")(in)(lft);
XnewCDM.b1 "angle(-90-ahn)";
XObjMLP.b1("i_1")(in)(rt);
XnewCDM.b2 "angle(-90+ahn)";
XObjMLP.b2("i_2")(is)(lft);
XnewCDM.b3 "angle(90+ahn)";
XObjMLP.b3("4A")(is)(rt);
XnewCDM.b4;
XObjMLP.b4("-6A")(in)(top);

X(n1).c = origin;

X(n0).c = X(n1).c + UD(0,-10) rotated -ahn;
X(b0).c = X(n1).c + UD(-1,-5) rotated -ahn;
X(b1).c = X(n1).c + UD(1,-5) rotated -ahn;

X(n2).c = X(n1).c + UD(0,-10) rotated ahn;
X(b2).c = X(n1).c + UD(-1, -5) rotated ahn;
X(b3).c = X(n1).c + UD(1,-5) rotated ahn;

X(b4).c = (X(n0).c + X(n2).c)/2

XdrawObj(n0,n1,n2);
Xnccurve(n0)(n1) "angleA(90-ahn+aoff)", "angleB(90-ahn-aoff)";
Xnccurve(n1)(n0) "angleA(-90-ahn+aoff)", "angleB(-90-ahn-aoff)";
Xnccurve(n1)(n2) "angleA(ahn-90+aoff)", "angleB(ahn-90-aoff)";
Xnccurve(n2)(n1) "angleA(ahn+90+aoff)", "angleB(ahn+90-aoff)";
Xnccurve(n2)(n0) "angleA(180+aoff)", "angleB(180-aoff)";
XdrawObj(b0,b1,b2,b3,b4); 
