numeric aoff;
aoff := 15;
numeric ahn;
ahn  := 40;

newNode.X(n0);
newNode.X(n1);
newNode.X(n2);

newCDM.X(b0) "angle(90-ahn)";
ObjMLP.X(b0)("-8A")(in)(lft);
newCDM.X(b1) "angle(-90-ahn)";
ObjMLP.X(b1)("i_1")(in)(rt);
newCDM.X(b2) "angle(-90+ahn)";
ObjMLP.X(b2)("i_2")(is)(lft);
newCDM.X(b3) "angle(90+ahn)";
ObjMLP.X(b3)("4A")(is)(rt);
newCDM.X(b4);
ObjMLP.X(b4)("-6A")(in)(top);

X(n1).c = origin;

X(n0).c = X(n1).c + UD(0,-10) rotated -ahn;
X(b0).c = X(n1).c + UD(-1,-5) rotated -ahn;
X(b1).c = X(n1).c + UD(1,-5) rotated -ahn;

X(n2).c = X(n1).c + UD(0,-10) rotated ahn;
X(b2).c = X(n1).c + UD(-1, -5) rotated ahn;
X(b3).c = X(n1).c + UD(1,-5) rotated ahn;

X(b4).c = (X(n0).c + X(n2).c)/2

drawObj(X(n0),X(n1),X(n2));
nccurve(X(n0))(X(n1)) "angleA(90-ahn+aoff)", "angleB(90-ahn-aoff)";
nccurve(X(n1))(X(n0)) "angleA(-90-ahn+aoff)", "angleB(-90-ahn-aoff)";
nccurve(X(n1))(X(n2)) "angleA(ahn-90+aoff)", "angleB(ahn-90-aoff)";
nccurve(X(n2))(X(n1)) "angleA(ahn+90+aoff)", "angleB(ahn+90-aoff)";
nccurve(X(n2))(X(n0)) "angleA(180+aoff)", "angleB(180-aoff)";
drawObj(X(b0),X(b1),X(b2),X(b3),X(b4)); 
