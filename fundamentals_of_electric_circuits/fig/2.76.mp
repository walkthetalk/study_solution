newR.X(r1) "angle(90)";
ObjMLP.X(r1)("+")(ise)(rt);
ObjMLP.X(r1)("-")(isw)(rt);
ObjMLP.X(r1)("40V")(is)(rt);

newR.X(r2);
ObjMLP.X(r2)("+")(inw)(top);
ObjMLP.X(r2)("-")(ine)(top);
ObjMLP.X(r2)("50V")(in)(top) "labshift(UD(0,1))";

newR.X(r3);
ObjMLP.X(r3)("+")(inw)(top);
ObjMLP.X(r3)("-")(ine)(top);
ObjMLP.X(r3)("20V")(in)(top) "labshift(UD(0,1))";

newR.X(r4);
ObjMLP.X(r4)("+")(inw)(top);
ObjMLP.X(r4)("-")(ine)(top);
ObjMLP.X(r4)("30V")(in)(top) "labshift(UD(0,1))";

newR.X(r5) "angle(90)";
ObjMLP.X(r5)("v_1")(in)(lft);
ObjMLP.X(r5)("+")(ine)(lft);
ObjMLP.X(r5)("-")(inw)(lft);

newR.X(r6);
ObjMLP.X(r6)("v_2")(in)(top) "labshift(UD(0,1))";
ObjMLP.X(r6)("+")(inw)(top);
ObjMLP.X(r6)("-")(ine)(top);

newR.X(r7) "angle(90)";
ObjMLP.X(r7)("v_3")(in)(lft);
ObjMLP.X(r7)("+")(ine)(lft);
ObjMLP.X(r7)("-")(inw)(lft);

newNode.X(n1);
newNode.X(n2);

X(r1).c = origin;
X(r2).c = X(r1).c+UD(3,4);
X(r3).c = X(r2).c+UD(6,0);
X(r4).c = X(r3).c+UD(3,4);
X(r5).c = X(r1).c+UD(12,0);
X(r6).c = X(r3).c+UD(6,0);
X(r7).c = X(r5).c+UD(6,0);
X(n1).c = X(r1).c+UD(0,-3);
X(n2).c = (X(r2).c + X(r3).c)/2;

pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(n2))(90)(X(r4))(1);
pcsimple(X(r3))(2)(X(r5))(2);
pcsimple(X(r3))(2)(X(r6))(1);
pcsimple(X(r4))(2)(X(r7))(2);
pcsimple(X(r6))(2)(X(r7))(2);
pcsimple(X(r1))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(r5))(1);
pcsimple(X(n1))(0)(X(r7))(1);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5),X(r6),X(r7)); 
