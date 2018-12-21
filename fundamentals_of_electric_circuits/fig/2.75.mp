newR.X(r1) "angle(90)";
ObjMLP.X(r1)("+")(ise)(rt);
ObjMLP.X(r1)("-")(isw)(rt);
ObjMLP.X(r1)("V_1")(is)(rt);

newR.X(r2);
ObjMLP.X(r2)("+")(inw)(top);
ObjMLP.X(r2)("-")(ine)(top);
ObjMLP.X(r2)("1V")(in)(top) "labshift(UD(0,1))";

newR.X(r3) "angle(90)";
ObjMLP.X(r3)("+")(ise)(rt);
ObjMLP.X(r3)("-")(isw)(rt);
ObjMLP.X(r3)("5V")(is)(rt);

newR.X(r4);
ObjMLP.X(r4)("+")(inw)(top);
ObjMLP.X(r4)("-")(ine)(top);
ObjMLP.X(r4)("2V")(in)(top) "labshift(UD(0,1))";

newR.X(r5) "angle(90)";
ObjMLP.X(r5)("V_2")(is)(rt);
ObjMLP.X(r5)("+")(ise)(rt);
ObjMLP.X(r5)("-")(isw)(rt);

newNode.X(n1);

X(r3).c = origin;
X(r1).c = X(r3).c+UD(-6,0);
X(r5).c = X(r3).c+UD( 6,0);
X(r2).c = X(r3).c+UD(-3,4);
X(r4).c = X(r3).c+UD( 3,4);
X(n1).c = X(r3).c + UD(0,-3);

pcsimple(X(r5))(2)(X(r4))(2);
pcsimple(X(r3))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(r5))(1);
pcsimple(X(n1))(180)(X(r1))(1);
pcsimple(X(r3))(2)(X(r4))(1);
pcsimple(X(r3))(2)(X(r2))(2);
pcsimple(X(r1))(2)(X(r2))(1);

drawObj(X(r1),X(r2),X(r3),X(r4),X(r5)); 
