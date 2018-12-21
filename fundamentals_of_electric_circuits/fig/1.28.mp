newR.X(r1) "angle(90)";
ObjLabel.X(r1)(textext("1")) "labcolor(FireBrick)";

newR.X(r2) "angle(90)";
ObjLabel.X(r2)(textext("2")) "labcolor(FireBrick)";

newR.X(r4) "angle(90)";
ObjLabel.X(r4)(textext("4")) "labcolor(FireBrick)";

newR.X(r3) "angle( 0)";
ObjLabel.X(r3)(textext("3")) "labcolor(FireBrick)";

newNode.X(n1);

X(r2).c = origin;
X(n1).c = X(r2).c+UD(0,-3);
X(r1).c = X(r2).c+UD(-4,0);
X(r4).c = X(r2).c+UD( 6,0);
X(r3).c = (X(r2).c+X(r4).c)/2 + UD(0,3);

drawObj(X(r1),X(r2),X(r3),X(r4));

pcsimple(X(r3))(2)(X(r4))(2);
pcsimple(X(r2))(2)(X(r3))(1);
pcsimple(X(r3))(1)(X(r1))(2);
pcsimple(X(r2))(1)(X(n1))(-90);
pcsimple(X(n1))(0)(X(r4))(1);
pcsimple(X(n1))(180)(X(r1))(1); 
