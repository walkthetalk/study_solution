input TEX;
warningcheck := 0;	% for large number bigger than 4096

bboxmargin := 0;

vardef MATRIX_CHAIN_ORDER_PIC_M(suffix p, m, s)(expr gsize) :=
image(
	save i, j, x, y;
	numeric i, j;
	numeric x, y;
	save fr;
	path fr;
	fr := (0,1)--(-1,0)--(0,-1)--(1,0)--cycle;
	for i := 1 upto p.len:
		for j := i upto p.len:
			x := j + i - p.len - 1;
			y := j - i - p.len + 1;

			draw ((fr shifted (x, y)) scaled gsize) withcolor black;

			label(decimal(m[i][j]), (x,y) scaled gsize);
		endfor;
	endfor;

	for i := 1 upto p.len:
		x := i;
		y := 2-i;
		label(decimal(i), (x,y) scaled gsize) shifted (-.25gsize, -.25gsize);
	endfor;

	label("i", (.5 p.len + 1, -.5 p.len + 2) scaled gsize);

	for j := 1 upto p.len:
		x := j - p.len - 1;
		y := j - p.len + 1;
		label(decimal(j), (x,y) scaled gsize) shifted(.25gsize, -.25gsize);
	endfor;

	label("j", (-.5 p.len - 1, -.5 p.len + 2) scaled gsize);

	label("m", (0, 2) scaled gsize);

	for i:= 1 upto p.len:
		label(TEX("$A_" & decimal(i) & "$"), (i * 2 - p.len - 1, -p.len - 1) scaled gsize) shifted(0, .5gsize);
	endfor;
)
enddef;

vardef MATRIX_CHAIN_ORDER_PIC_S(suffix p, m, s)(expr gsize) :=
image(
	save i, j, x, y;
	numeric i, j;
	numeric x, y;
	save fr;
	path fr;
	fr := (0,1)--(-1,0)--(0,-1)--(1,0)--cycle;
	for i := 1 upto (p.len - 1):
		for j := (i + 1) upto p.len:
			x := j + i - p.len - 1;
			y := j - i - p.len + 1;

			draw ((fr shifted (x, y)) scaled gsize) withcolor black;

			label(decimal(s[i][j]), (x,y) scaled gsize);
		endfor;
	endfor;

	for i := 1 upto (p.len - 1):
		x := i;
		y := 2-i;
		label(decimal(i), (x,y) scaled gsize) shifted (-.25gsize, -.25gsize);
	endfor;

	label("i", (.5 p.len + 1, -.5 p.len + 2) scaled gsize);

	for j := 2 upto p.len:
		x := j - p.len - 1;
		y := j - p.len + 1;
		label(decimal(j), (x,y) scaled gsize) shifted(.25gsize, -.25gsize);
	endfor;

	label("j", (-.5 p.len - 1, -.5 p.len + 2) scaled gsize);

	label("s", (0, 2) scaled gsize);
)
enddef;

vardef MATRIX_CHAIN_ORDER(suffix p, m, s) :=
	save n;
	numeric n;
	n := p.len;
	save i,j,l;
	numeric i,j,l;

	for i := 1 upto n:
		m[i][i] := 0;
	endfor;
	for l := 2 upto n:
		for i := 1 upto (n - l + 1):
			j := i + l - 1;
			%message "i,j is " & decimal(i) & "," & decimal(j);
			for k := i upto (j - 1):
				q := m[i][k] + m[k+1][j] + p[i-1] * p[k] * p[j];
				%message "   k is " & decimal(k);
				%message "   q is " & decimal(q);
				if unknown(m[i][j]):
					m[i][j] := q;
					s[i][j] := k;
				elseif q < m[i][j]:
					m[i][j] := q;
					s[i][j] := k;
				fi;
			endfor;
		endfor;
	endfor;
enddef;

beginfig(1);
	numeric dimens[];
	numeric dimens.len;
	dimens.len := 6;
	dimens[0] := 5;
	dimens[1] := 10;
	dimens[2] := 3;
	dimens[3] := 12;
	dimens[4] := 5;
	dimens[5] := 50;
	dimens[6] := 6;
	numeric M[][];
	numeric S[][];

	MATRIX_CHAIN_ORDER(dimens, M, S);

	draw MATRIX_CHAIN_ORDER_PIC_M(dimens, M, S)(0.5cm);
endfig;

beginfig(2);
	numeric dimens[];
	numeric dimens.len;
	dimens.len := 6;
	dimens[0] := 5;
	dimens[1] := 10;
	dimens[2] := 3;
	dimens[3] := 12;
	dimens[4] := 5;
	dimens[5] := 50;
	dimens[6] := 6;
	numeric M[][];
	numeric S[][];

	MATRIX_CHAIN_ORDER(dimens, M, S);

	draw MATRIX_CHAIN_ORDER_PIC_S(dimens, M, S)(0.5cm);
endfig;

end;
