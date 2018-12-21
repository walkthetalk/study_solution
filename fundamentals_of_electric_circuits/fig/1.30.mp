newR.X(r0) "angle(90)";
ObjMLP.X(r0)("-")(ise)(rt);
ObjMLP.X(r0)("+")(isw)(rt);
ObjMLP.X(r0)("15V")(is)(rt);
ObjMLP.X(r0)("p_2")(ine)(ulft);

newR.X(r1) "angle(90)";
ObjMLP.X(r1)("-")(ise)(rt);
ObjMLP.X(r1)("+")(isw)(rt);
ObjMLP.X(r1)("9V")(is)(rt);
ObjMLP.X(r1)("p_3")(ine)(lft);

newIVS.X(u2) "angle(-90)";
ObjMLP.X(u2)("6V")(in)(rt);
ObjMLP.X(u2)("p_4")(ise)(llft);

newICS.X(u1) "angle(-90)";
ObjMLP.X(u1)("15V")(in)(rt);
ObjMLP.X(u1)("10A")(is)(lft);
ObjMLP.X(u1)("-")(inw)(rt);
ObjMLP.X(u1)("+")(ine)(rt);
ObjMLP.X(u1)("p_1")(isw)(ulft);

newCDM.X(cdm0) "angle(-90)";
ObjMLP.X(cdm0)("I")(in)(rt);
newCDM.X(cdm1) "angle(90)";
ObjMLP.X(cdm1)("4A")(is)(rt);

newNode.X(n1);
newNode.X(n2);

X(r0).c = origin;
X(r1).c = X(r0).c + UD(5,2);
X(u2).c = X(r1).c + UD(0,-4);
X(u1).c = X(r0).c + UD(-5,0);
X(n1).c = X(r1).c + UD(0,4);
X(n2).c = X(u2).c + UD(0,-3);
X(cdm0).ssw = X(n1).c;
X(cdm1).ne  = (xpart X(r0).c, ypart X(n1).c);

drawObj(X(r0),X(r1),X(u1),X(u2));
pcsimple(X(r0))(2)(X(n1))(0);
pcsimple(X(n1))(-90)(X(r1))(2);
pcsimple(X(n1))(180)(X(u1))(1);
pcsimple(X(u2))(2)(X(n2))(-90);
pcsimple(X(r0))(1)(X(n2))(0);
pcsimple(X(u1))(2)(X(n2))(0);
pcsimple(X(r1))(1)(X(u2))(1);
drawObj(X(cdm0),X(cdm1)); 
