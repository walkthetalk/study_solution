newNode.X(n0);
newNode.X(n1);
newNode.X(n2);
newNode.X(n3);

newCDM.X(b0) "angle(180)";
ObjMLabel.X(b0)("i_b")
	"labpoint(is)", "labdir(top)";
newCDM.X(b1) "angle(-90)";
ObjMLabel.X(b1)("i_1")
	"labpoint(in)", "labdir(rt)";
newCDM.X(b2) "angle(90)";
ObjMLabel.X(b2)("i_2")
	"labpoint(in)", "labdir(lft)";
newCDM.X(b3) "angle(180)";
ObjMLabel.X(b3)("i_c")
	"labpoint(is)", "labdir(top)";
newCDM.X(b4) "angle(-90)";
ObjMLabel.X(b4)("i_3")
	"labpoint(in)", "labdir(rt)";
newCDM.X(b5) "angle(180)";
ObjMLabel.X(b5)("i_a")
	"labpoint(is)", "labdir(top)";

numeric uc;
uc := 10;
X(n2).c = origin;
X(n0).c = X(n2).c + (-3uc, 3uc);
X(n1).c = X(n2).c + ( 3uc, 3uc);
X(n3).c = X(n2).c + (   0,-3uc);
X(b0).c = (X(n0).c + X(n1).c)/2;
X(b1).c = X(n1).c + (   0,-1.5uc);
X(b2).c = X(n0).c + (   0,-1.5uc);
X(b3).c = X(n3).c + ( 3uc,   0);
X(b4).c = X(n2).c + (   0,-1.5uc);
X(b5).c = X(n3).c + (-3uc,  0);

drawObj(X(n0),X(n1),X(n2),X(n3));
pcsimple(X(n2))(180)(X(n0))(90) "armA(3uc)";
pcsimple(X(n1))(-90)(X(n2))(180) "armA(3uc)";
pcsimple(X(n1))(180)(X(n0))(180);
pcsimple(X(n1))(0)(X(n3))(180) "armA(3uc)";
pcsimple(X(n3))(180)(X(n0))(0) "armA(6uc)";
pcsimple(X(n2))(-90)(X(n3))(-90);
drawObj(X(b0),X(b1),X(b2),X(b3),X(b4),X(b5)); 
