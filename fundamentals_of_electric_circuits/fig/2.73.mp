newNode.X(n1);
newNode.X(n2);
ObjMLabel.X(n2)("A") "labpoint(iw)", "labdir(lft)";
newNode.X(n3);
newNode.X(n4);
newNode.X(n5);
ObjMLabel.X(n5)("B") "labpoint(ie)", "labdir(rt)";
newNode.X(n6);

numeric uc;
uc := 10;
X(n1).c = X(n2).c + (0,-3uc);
X(n2).c = origin;
X(n3).c = X(n2).c + (0, 3uc);
X(n4).c = X(n5).c + (0,-3uc);
X(n5).c = X(n2).c + (6uc, 0);
X(n6).c = X(n5).c + (0, 3uc);

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
ObjMLabel.X(b23)("1A")
	"labpoint(is)", "labdir(rt)";
X(b23).in = (X(n2).c+X(n3).c)/2;
newCDM.X(b21) "angle(-90)";
ObjMLabel.X(b21)("i_1")
	"labpoint(in)", "labdir(rt)";
X(b21).is = (X(n2).c + X(n1).c)/2;
newCDM.X(b56) "angle(90)";
ObjMLabel.X(b56)("i_2")
	"labpoint(is)", "labdir(rt)";
X(b56).in = (X(n5).c+X(n6).c)/2;
newCDM.X(b54) "angle(-90)";
ObjMLabel.X(b54)("2A")
	"labpoint(in)", "labdir(rt)";
X(b54).is = (X(n5).c+X(n4).c)/2;
newCDM.X(b25);
ObjMLabel.X(b25)("-6A")
	"labpoint(is)", "labdir(bot)";
X(b25).in = (X(n2).c+X(n5).c)/2;
newCDM.X(b41) "angle(180)";
ObjMLabel.X(b41)("-2A")
	"labpoint(in)", "labdir(bot)";
X(b41).is = (X(n1).c+X(n4).c)/2;
newCDM.X(b63) "angle(180)";
ObjMLabel.X(b63)("-4A")
	"labpoint(is)", "labdir(top)";
X(b63).in = (X(n6).c+X(n3).c)/2;
newCDM.X(b31) "angle(-90)";
ObjMLabel.X(b31)("-3A")
	"labpoint(is)", "labdir(lft)";
X(b31).in = X(n2).c + (-3uc, 0);
newCDM.X(b46) "angle(90)";
ObjMLabel.X(b46)("i_3")
	"labpoint(is)", "labdir(rt)";
X(b46).in = X(n5).c + (3uc, 0);

drawObj(X(b23),X(b21),X(b56),X(b54),X(b25),X(b41),X(b63),X(b31),X(b46)); 
