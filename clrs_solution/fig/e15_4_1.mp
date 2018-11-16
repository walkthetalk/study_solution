input TEX;

bboxmargin := 0;

vardef img_lcs_length(suffix X, Y, b, c)(expr gsize) :=
image(
	save fr, shadow;
	path fr, shadow;
	fr := unitsquare shifted (-0.5, -0.5) scaled gsize;
	shadow := fullcircle scaled .5gsize;

	% draw shadow
	i := X.len;
	j := Y.len;
	forever:
		fill fr shifted (j * gsize, -i * gsize) withcolor .8 white;
		exitif ((i = 0) or (j = 0));

		if b[i][j] = "lu":
			fill shadow shifted (j * gsize, 1 * gsize) withcolor .8 white;
			fill shadow shifted (-1 * gsize, -i * gsize) withcolor .8 white;

			i := i - 1;
			j := j - 1;
		elseif b[i][j] = "u":
			i := i - 1;
		elseif b[i][j] = "l":
			j := j - 1;
		fi;
	endfor;

	% draw border
	label(btex $i$ etex, (-2 gsize, 1 gsize));
	for i := 0 upto X.len:
		label(TEX("$" & decimal(i) & "$"), (-2 gsize, -i * gsize));
	endfor;

	label(btex $x_i$ etex, (-1 gsize, 0));
	for i := 1 upto X.len:
		label(TEX("$" & decimal(X[i]) & "$"), (-1 gsize, -i * gsize));
	endfor;

	label(btex $j$ etex, (-1 gsize, 2 gsize));
	for j := 0 upto Y.len:
		label(TEX("$" & decimal(j) & "$"), (j * gsize, 2 * gsize));
	endfor;

	label(btex $y_j$ etex, (0, 1 gsize));
	for j := 1 upto Y.len:
		label(TEX("$" & decimal(Y[j]) & "$"), (j * gsize, 1 * gsize));
	endfor;

	% draw grid
	for i := 0 upto X.len:
		for j := 0 upto Y.len:
			draw fr shifted (j * gsize, -i * gsize);
			label(TEX("$" & decimal(c[i][j]) & "$"),
				(j * gsize + .25 gsize, -i * gsize - .25 gsize));
			if known(b[i][j]):
				if b[i][j] = "lu":
					drawarrow (j * gsize, -i * gsize)
						--(j * gsize - .5gsize, -i * gsize + .5gsize);
				elseif b[i][j] = "u":
					drawarrow (j * gsize + .25gsize, -i * gsize)
						--(j * gsize + .25gsize, -i * gsize + .5gsize);
				elseif b[i][j] = "l":
					drawarrow (j * gsize, -i * gsize - .25gsize)
						--(j * gsize - .5gsize, -i * gsize - .25gsize);
				fi;
			fi;
		endfor;
	endfor;
)
enddef;

vardef lcs_length(suffix X, Y, b, c) :=
	numeric m, n;
	m := X.len;
	n := Y.len;
	for i := 1 upto m:
		c[i][0] := 0;
	endfor;
	for j := 0 upto n:
		c[0][j] := 0;
	endfor;

	for i := 1 upto m:
		for j := 1 upto n:
			if X[i] = Y[j]:
				c[i][j] := c[i-1][j-1] + 1;
				b[i][j] := "lu";
			elseif c[i-1][j] >= c[i][j-1]:
				c[i][j] := c[i-1][j];
				b[i][j] := "u";
			else:
				c[i][j] := c[i][j-1];
				b[i][j] := "l";
			fi;
		endfor;
	endfor;
enddef;

beginfig(1);
	numeric X[];
	numeric X.len;
	numeric Y[];
	numeric Y.len;
	string  b[][];
	numeric c[][];

	X[1] := 1;
	X[2] := 0;
	X[3] := 0;
	X[4] := 1;
	X[5] := 0;
	X[6] := 1;
	X[7] := 0;
	X[8] := 1;
	X.len := 8;

	Y[1] := 0;
	Y[2] := 1;
	Y[3] := 0;
	Y[4] := 1;
	Y[5] := 1;
	Y[6] := 0;
	Y[7] := 1;
	Y[8] := 1;
	Y[9] := 0;
	Y.len := 9;

	lcs_length(X, Y, b, c);

	draw img_lcs_length(X, Y, b, c)(0.8cm);
endfig;

end;
