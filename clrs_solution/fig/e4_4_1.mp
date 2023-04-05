input reccursion_tree;

beginfig(1);
string A[];
string B[];
A[3] := "$n$";		B[3] := "$n^3$";
A[2] := "${n}\over{2}$";	B[2] := "$\left({n}\over{2}\right)^3$";
A[1] := "${n}\over{4}$";	B[1] := "$\left({n}\over{4}\right)^3$";
A[0] := "$T(1)$";	B[0] := "$2^3$";
rectree(A, B)(1, 3);
endfig;

beginfig(2);
save A,B;
string A[];
string B[];
A[3] := "$n$";		B[3] := "$n$";
A[2] := "${n}\over{3}$";	B[2] := "${{4}\over{3}}n$";
A[1] := "${n}\over{9}$";	B[1] := "${{16}\over{9}}n$";
A[0] := "$T(1)$";	B[0] := "$\left({4}\over{3}\right)^{\log_3 n}n$";
rectree(A, B)(4, 3);
endfig;

beginfig(3);
save A,B;
string A[];
string B[];
A[3] := "$n$";		B[3] := "$n$";
A[2] := "${n}\over{2}$";	B[2] := "$2n$";
A[1] := "${n}\over{4}$";	B[1] := "$4n$";
A[0] := "$T(1)$";	B[0] := "$n^2$";
rectree(A, B)(4, 3);
endfig;

beginfig(4);
save A,B;
string A[];
string B[];
A[3] := "$n$";		B[3] := "$1$";
A[2] := "$n-1$";	B[2] := "$3$";
A[1] := "$n-2$";	B[1] := "$9$";
A[0] := "$T(1)$";	B[0] := "$3^{n-1}$";
rectree(A, B)(3, 3);
endfig;

end;
