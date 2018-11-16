
vardef matrix(suffix M)(expr n, gsize) :=
image(
	draw unitsquare xscaled ((n+1) * gsize) yscaled -((n+1) * gsize) withcolor white;
	save i,j; numeric i,j;
	for i := 0 upto n:
		for j := 0 upto n:
			save pos; pair pos;
			pos := (j+0.5, i+0.5) xscaled gsize yscaled -gsize;
			label(decimal(M[i][j]), pos);
		endfor;
	endfor;
)
enddef;

vardef inter_LP(suffix M)(expr n, idx, gsize) :=
image(
	draw unitsquare xscaled ((n+1) * gsize) yscaled -((n+1) * gsize) withcolor white;
	save ladder; path ladder;
	ladder := (0,1);
	save i,j; numeric i,j;
	for i := 1 upto idx:
		ladder := ladder -- (i,i) -- (i, i+1);
	endfor;
	ladder := ladder -- (idx+1,idx+1);

	save rangle; path rangle;
	rangle := (idx+1,n+1) -- (idx+1,idx+1) -- (n+1,idx+1);

	save left_back; path left_back;
	left_back := (idx, idx+1) -- (idx+1,idx+1) -- (idx+1,n+1) -- (idx, n+1) -- cycle;

	save top_back; path top_back;
	top_back := (idx+1, idx) -- (n+1, idx) -- (n+1, idx+1) -- (idx+1, idx+1) -- cycle;

	save xscale, yscale; numeric xscale,yscale; xscale := gsize; yscale := -gsize;
	fill left_back xscaled xscale yscaled yscale withcolor .8white;
	fill top_back xscaled xscale yscaled yscale withcolor .8white;
	draw ladder xscaled xscale yscaled yscale;
	draw rangle xscaled xscale yscaled yscale;

	for i := 0 upto n:
		for j := 0 upto n:
			save pos; pair pos;
			pos := (j+0.5, i+0.5) xscaled xscale yscaled yscale;
			if (i = idx) and (j = idx):
				fill fullcircle scaled .8gsize shifted pos;
				label(decimal(M[i][j]), pos) withcolor white;
			else:
				label(decimal(M[i][j]), pos);
			fi;
		endfor;
	endfor;
)
enddef;

save picidx; numeric picidx;
picidx := 1;
vardef DRAW_IMG(expr img) :=
beginfig(picidx);
	draw img;
	picidx := picidx + 1;
endfig;
enddef;

vardef calc_LP(suffix A, B)(expr n, gsize) :=
	save i,j,k;
	numeric i,j,k;
	for i := 0 upto n:
		for j := 0 upto n:
			B[i][j] := A[i][j];
		endfor;
	endfor;

	DRAW_IMG(matrix(B)(n, gsize));

	for i := 0 upto (n-1):
		for  j := (i+1) upto n:
			B[j][i] := B[j][i] / B[i][i];
		endfor;
		for j := (i+1) upto n:
			for k := (i+1) upto n:
				B[j][k] := B[j][k] - B[j][i] * B[i][k];
			endfor;
		endfor;
		DRAW_IMG(inter_LP(B)(n, i, gsize));
	endfor;
enddef;

%%%%%%%%%%%%%%%%%%%%%% data
numeric n;
n := 2;
numeric A[][];
A[0][0] := 4;
A[0][1] := -5;
A[0][2] := 6;

A[1][0] := 8;
A[1][1] := -6;
A[1][2] := 7;

A[2][0] := 12;
A[2][1] := -7;
A[2][2] := 12;

save B; numeric B[][];
calc_LP(A, B)(n, .25in);

end;
