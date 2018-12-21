newNode.X(n1);
newNode.X(n2);
ObjMLP.X(n2)("A")(iw)(lft);
newNode.X(n3);
newNode.X(n4);
newNode.X(n5);
ObjMLP.X(n5)("B")(ie)(rt);
newNode.X(n6);

X(n1).c = X(n2).c + UD(0,-3);
X(n2).c = origin;
X(n3).c = X(n2).c + UD(0, 3);
X(n4).c = X(n5).c + UD(0,-3);
X(n5).c = X(n2).c + UD(6, 0);
X(n6).c = X(n5).c + UD(0, 3);

drawObj(X(n1),X(n2),X(n3),X(n4),X(n5),X(n6));

ncline(X(n2))(X(n3));
ncline(X(n2))(X(n1));
ncline(X(n5))(X(n6));
ncline(X(n5))(X(n4));
ncline(X(n2))(X(n5));
ncline(X(n4))(X(n1));
ncline(X(n6))(X(n3));
nccurve(X(n4))(X(n6)) "angleA(0)", "angleB(180)";
nccurve(X(n3))(X(n1)) "angleA(180)", "angleB(0)";

newCDM.X(b23) "angle(90)";
ObjMLP.X(b23)("1A")(is)(rt);
X(b23).in = (X(n2).c+X(n3).c)/2;
newCDM.X(b21) "angle(-90)";
ObjMLP.X(b21)("i_1")(in)(rt);
X(b21).is = (X(n2).c + X(n1).c)/2;
newCDM.X(b56) "angle(90)";
ObjMLP.X(b56)("i_2")(is)(rt);
X(b56).in = (X(n5).c+X(n6).c)/2;
newCDM.X(b54) "angle(-90)";
ObjMLP.X(b54)("2A")(in)(rt);
X(b54).is = (X(n5).c+X(n4).c)/2;
newCDM.X(b25);
ObjMLP.X(b25)("-6A")(is)(bot);
X(b25).in = (X(n2).c+X(n5).c)/2;
newCDM.X(b41) "angle(180)";
ObjMLP.X(b41)("-2A")(in)(bot);
X(b41).is = (X(n1).c+X(n4).c)/2;
newCDM.X(b63) "angle(180)";
ObjMLP.X(b63)("-4A")(is)(top);
X(b63).in = (X(n6).c+X(n3).c)/2;
newCDM.X(b31) "angle(-90)";
ObjMLP.X(b31)("-3A")(is)(lft);
X(b31).in = X(n2).c + UD(-3, 0);
newCDM.X(b46) "angle(90)";
ObjMLP.X(b46)("i_3")(is)(rt);
X(b46).in = X(n5).c + UD(3, 0);

drawObj(X(b23),X(b21),X(b56),X(b54),X(b25),X(b41),X(b63),X(b31),X(b46)); 
