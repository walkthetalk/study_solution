vardef exchange(suffix A)(expr i, j) :=
	save tmp;
	numeric tmp;
	tmp := A[i];
	A[i] := A[j];
	A[j] := tmp;
enddef;

vardef partition(suffix A)(expr ALength, p, r) :=
	numeric x, i;
	x := A[r];
	i := p - 1;
	for j = p upto (r - 1):
		if A[j] <= x:
			i := i + 1;
			exchange(A)(i, j);
		fi;
	endfor;
	exchange(A)(i+1, r);

	(i+1)
enddef;

vardef img_partition(suffix A)(expr ALength, ls, le, rs, re, focus, gsize) :=
image(
	path pelement;
	pelement := unitsquare shifted (-0.5, -0.5) scaled gsize;

	for i := 1 upto ALength:
		color bgcolor;
		color lblcolor;
		bgcolor := white;
		lblcolor := black;
		if i = focus:	% focus is the most important
			bgcolor := black;
			lblcolor := white;
		elseif (ls <= i) and (i < le):
			bgcolor := 0.7 white;
		elseif (rs <= i) and (i < re):
			bgcolor := 0.3 white;
		fi;
		draw pelement shifted (gsize * 1.5 * i, 0) withcolor black withpen (pencircle scaled 0.2gsize);
		fill pelement shifted (gsize * 1.5 * i, 0) withcolor bgcolor;
		label(decimal(A[i]), (gsize * 1.5 * i, 0)) withcolor lblcolor;
	endfor;
)
enddef;
