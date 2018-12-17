newR.X(r1) "angle(90)";
ObjLabel.X(r1)(textext("1")) "labcolor(FireBrick)";

newR.X(r2) "angle(90)";
ObjLabel.X(r2)(textext("2")) "labcolor(FireBrick)";

newR.X(r4) "angle(90)";
ObjLabel.X(r4)(textext("4")) "labcolor(FireBrick)";

newR.X(r3) "angle( 0)";
ObjLabel.X(r3)(textext("3")) "labcolor(FireBrick)";

numeric uc;
uc := 10;
X(r2).c = origin;
X(r1).c = X(r2).c+(-6uc,0);
X(r4).c = X(r2).c+( 6uc,0);
X(r3).c = (X(r2).c+X(r4).c)/2 + (0,3uc);

drawObj(X(r1),X(r2),X(r3),X(r4));

string armL; armL:= "armA(ypart(X(r3).c-X(r2).ie))";
pcsimple(X(r3))(2)(X(r4))(2);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r2))(2)(X(r1))(2) armL;
pcsimple(X(r2))(1)(X(r4))(1) armL;
pcsimple(X(r2))(1)(X(r1))(1) armL; 
