newNode.X(n0);
newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

newNode.X(n4);
newNode.X(n5);

newCDM.X(b0) "angle(180)";
ObjMLP.X(b0)("i_b")(is)(top);
newCDM.X(b1) "angle(-90)";
ObjMLP.X(b1)("i_1")(in)(rt);
newCDM.X(b2) "angle(90)";
ObjMLP.X(b2)("i_2")(in)(lft);
newCDM.X(b3) "angle(180)";
ObjMLP.X(b3)("i_c")(is)(top);
newCDM.X(b4) "angle(-90)";
ObjMLP.X(b4)("i_3")(in)(rt);
newCDM.X(b5) "angle(180)";
ObjMLP.X(b5)("i_a")(is)(top);

X(n2).c = origin;
X(n0).c = X(n2).c + UD(-3, 3);
X(n1).c = X(n2).c + UD( 3, 3);
X(n3).c = X(n2).c + UD( 0,-3);
X(b0).c = (X(n0).c + X(n1).c)/2;
X(b1).c = X(n1).c + UD(0,-1.5);
X(b2).c = X(n0).c + UD(0,-1.5);
X(b3).c = X(n3).c + UD(3,   0);
X(b4).c = X(n2).c + UD(0,-1.5);
X(b5).c = X(n3).c + UD(-3,  0);

X(n4).c = X(n0).c + UD(-3,0);
X(n5).c = X(n1).c + UD(3,0);

drawObj(X(n0),X(n1),X(n2),X(n3));
pcsimple(X(n2))(180)(X(n0))(90);
pcsimple(X(n2))(0)(X(n1))(-90);
pcsimple(X(n1))(180)(X(n0))(180);
pcsimple(X(n1))(0)(X(n5))(0);
pcsimple(X(n5))(-90)(X(n3))(180);
pcsimple(X(n3))(180)(X(n4))(90);
pcsimple(X(n4))(0)(X(n0))(0);
pcsimple(X(n2))(-90)(X(n3))(-90);
drawObj(X(b0),X(b1),X(b2),X(b3),X(b4),X(b5)); 
