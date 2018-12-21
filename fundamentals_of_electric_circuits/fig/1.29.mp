newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("p_1")(is)(rt);
ObjMLP.X(u1)("30V")(in)(lft);

newR.X(r2);
ObjMLP.X(r2)("p_2")(is)(bot);
ObjMLP.X(r2)("+")(inw)(top);
ObjMLP.X(r2)("-")(ine)(top);
ObjMLP.X(r2)("10V")(in)(top) "labshift(UD(0,1))";

newR.X(r3) "angle(90)";
ObjMLP.X(r3)("p_3")(is)(rt);
ObjMLP.X(r3)("+")(ine)(lft);
ObjMLP.X(r3)("-")(inw)(lft);
ObjMLP.X(r3)("20V")(in)(lft);

newR.X(r4);
ObjMLP.X(r4)("p_4")(is)(bot);
ObjMLP.X(r4)("+")(inw)(top);
ObjMLP.X(r4)("-")(ine)(top);
ObjMLP.X(r4)("8V")(in)(top) "labshift(UD(0,1))";

newDCS.X(u2) "angle(90)";
ObjMLP.X(u2)("p_5")(is)(urt);
ObjMLP.X(u2)("0.4I")(is)(lrt);
ObjMLP.X(u2)("12V")(in)(lft);
ObjMLP.X(u2)("+")(ie)(ulft);
ObjMLP.X(u2)("-")(iw)(llft);

newCDM.X(cdm0) "angle(180)";
ObjMLP.X(cdm0)("4A")(is)(top);
newCDM.X(cdm1);
ObjMLP.X(cdm1)("I=10A")(in)(top);
newCDM.X(cdm2) "angle(-90)";
ObjMLP.X(cdm2)("14A")(in)(rt);

newNode.X(n1);

X(r3).c = origin;
X(u1).c = X(r3).c+UD(-9,0);
X(u2).c = X(r3).c+UD( 9,0);
X(r2).c = X(r3).c+UD(-3,6);
X(r4).c = X(r3).c+UD( 3,6);
X(n1).c = X(r3).c+UD(0,-4);

X(cdm0).nnw = (xpart(X(u2).c), ypart(X(r4).c));
X(cdm1).ssw = (xpart(X(u1).c), ypart(X(r2).c));
X(cdm2).se = X(r3).ie;

pcsimple(X(u2))(2)(X(r4))(2);
pcsimple(X(r3))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(u2))(1);
pcsimple(X(n1))(180)(X(u1))(1);
pcsimple(X(r3))(2)(X(r4))(1);
pcsimple(X(r3))(2)(X(r2))(2);
pcsimple(X(u1))(2)(X(r2))(1);

drawObj(X(u1),X(r2),X(r3),X(r4),X(u2));
drawObj(X(cdm0),X(cdm1),X(cdm2)); 
