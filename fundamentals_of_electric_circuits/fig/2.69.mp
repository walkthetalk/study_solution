newNode.X(n0);
newNode.X(n1);
newNode.X(n2);
newNode.X(n3);
newNode.X(n4);
newNode.X(n5);
newNode.X(n6);
newNode.X(n7);
newNode.X(n8);

X(n0).c = origin;
X(n2).c = X(n0).c + UD(4, 0);
X(n4).c = X(n2).c + UD(4, 0);
X(n7).c = X(n4).c + UD(4, 0);
X(n1).c = X(n0).c + UD(0, 4);
X(n3).c = X(n1).c + UD(4, 0);
X(n5).c = X(n3).c + UD(4, 0);
X(n8).c = X(n5).c + UD(4, 0);
X(n6).c = X(n5).c + UD(0, 4);

drawObj(X(n0),X(n1),X(n2),X(n3),X(n4),X(n5),X(n6),X(n7),X(n8));

ncline(X(n0))(X(n1));
ncline(X(n0))(X(n2));
ncline(X(n1))(X(n2));
ncline(X(n1))(X(n3));
ncline(X(n2))(X(n3));
ncline(X(n2))(X(n4));
ncline(X(n3))(X(n5));
ncline(X(n4))(X(n5));
ncline(X(n4))(X(n7));
ncline(X(n5))(X(n8));
ncline(X(n7))(X(n8));
ncline(X(n5))(X(n7));
ncline(X(n3))(X(n6));
ncline(X(n5))(X(n6));
ncline(X(n8))(X(n6)); 
