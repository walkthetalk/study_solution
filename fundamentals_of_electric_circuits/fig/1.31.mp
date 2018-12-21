newR.X(r0);
ObjMLP.X(r0)("-")(ine)(top);
ObjMLP.X(r0)("+")(inw)(top);
ObjMLP.X(r0)("12V")(n)(top) "labshift(UD(0,1))";
ObjMLP.X(r0)("p_2")(is)(bot);

newR.X(r1) "angle(90)";
ObjMLP.X(r1)("+")(ine)(lft);
ObjMLP.X(r1)("-")(inw)(lft);
ObjMLP.X(r1)("V_0")(n)(lft);
ObjMLP.X(r1)("p_3")(is)(rt);

newR.X(r2);
ObjMLP.X(r2)("-")(ise)(bot);
ObjMLP.X(r2)("+")(isw)(bot);
ObjMLP.X(r2)("28V")(is)(bot) "labshift(UD(0,-1))";
ObjMLP.X(r2)("p_4")(ie)(urt);

newR.X(r3);
ObjMLP.X(r3)("-")(ise)(bot);
ObjMLP.X(r3)("+")(isw)(bot);
ObjMLP.X(r3)("28V")(is)(bot) "labshift(UD(0,-1))";
ObjMLP.X(r3)("p_5")(ie)(urt);

newDVS.X(u2) "angle(-90)";
ObjMLP.X(u2)("5I_0")(in)(rt);
ObjMLP.X(u2)("p_6")(is)(lft);

newIVS.X(u1) "angle(90)";
ObjMLP.X(u1)("30V")(in)(lft);
ObjMLP.X(u1)("p_1")(is)(rt);

newCDM.X(cdm0) "angle(90)";
ObjMLP.X(cdm0)("6A")(in)(lft);
newCDM.X(cdm1);
ObjMLP.X(cdm1)("6A")(in)(top);
newCDM.X(cdm2) "angle(-90)";
ObjMLP.X(cdm2)("3A")(is)(lft);
newCDM.X(cdm3);
ObjMLP.X(cdm3)("1A")(in)(top);
newCDM.X(cdm4);
ObjMLP.X(cdm4)("I_0=2A")(in)(top);
newCDM.X(cdm5) "angle(-90)";
ObjMLP.X(cdm5)("3A")(in)(rt);

newNode.X(n1);

X(r1).c = origin;
X(n1).c = X(r1).c + UD(0,-3);
X(r0).c = X(r1).c + UD(-5, 4);
X(r2).c = X(r1).c + UD( 5, 4);
X(r3).c = X(r2).c + UD( 0, 5);
X(u1).c = X(r1).c + UD(-10,0);
X(u2).c = X(r1).c + UD( 10,0);
X(cdm0).ssw = (xpart X(u1).c, ypart X(n1).c);
X(cdm1).ssw = (xpart X(u1).c, ypart X(r0).c);
X(cdm2).ne  = X(r1).e;
X(cdm3).sw  = (xpart X(r1).c, ypart X(r2).c);
X(cdm4).sw  = (xpart X(r1).c, ypart X(r3).c);
X(cdm5).sse = (xpart X(u2).c, ypart X(n1).c);

drawObj(X(r0),X(r1),X(r2),X(r3),X(u1),X(u2));

pcsimple(X(u1))(2)(X(r0))(1);
pcsimple(X(r0))(2)(X(r1))(2);
pcsimple(X(r1))(2)(X(r2))(1);
pcsimple(X(r1))(2)(X(r3))(1);
pcsimple(X(r2))(2)(X(u2))(1);
pcsimple(X(r3))(2)(X(u2))(1);
pcsimple(X(r1))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(u2))(2);
pcsimple(X(n1))(180)(X(u1))(1);
drawObj(X(cdm0), X(cdm1), X(cdm2), X(cdm3), X(cdm4), X(cdm5)); 
