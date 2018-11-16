input TEX;
input format;

bboxmargin := 0;

vardef img_TRIANGLE_MATRIX(suffix DATA)(expr header, imin, jmin, len, gsize) :=
image(
	save i, j, x, y;
	numeric i, j;
	numeric x, y;
	save fr;
	path fr;
	fr := (0,1)--(-1,0)--(0,-1)--(1,0)--cycle;
	for i := 1 upto len:
		for j := i upto len:
			x := j + i - len - 1;
			y := j - i - len + 1;

			draw ((fr shifted (x, y)) scaled gsize) withcolor black;
			label(format("%2f", DATA[imin + i - 1][jmin + j - 1]),
				(x,y) scaled gsize);
		endfor;
	endfor;

	for i := 1 upto len:
		x := i;
		y := 2-i;
		label(decimal(imin + i - 1), (x,y) scaled gsize)
			shifted (-.25gsize, -.25gsize);
	endfor;

	label(TEX("i"), (.5 len + 1, -.5 len + 2) scaled gsize);

	for j := 1 upto len:
		x := j - len - 1;
		y := j - len + 1;
		label(decimal(jmin + j - 1), (x,y) scaled gsize) shifted(.25gsize, -.25gsize);
	endfor;

	label(TEX("j"), (-.5 len - 1, -.5 len + 2) scaled gsize);

	label(header, (0, 1.5) scaled gsize);
)
enddef;

vardef optimal_bst(suffix P, Q, n, EV, WEIGHT, ROOT) :=
	for i := 1 upto (n+1):
		EV[i][i-1] := Q[i-1];
		WEIGHT[i][i-1] := Q[i-1];
	endfor;

	for l := 1 upto n:
		for i := 1 upto (n-l+1):
			j := i + l - 1;
			% EV[i][j] := INFINITE;
			WEIGHT[i][j] := WEIGHT[i][j-1] + P[j] + Q[j];
			for r := i upto j:
				t := EV[i][r-1] + EV[r+1][j] + WEIGHT[i][j];
				if unknown(EV[i][j]):
					EV[i][j] := t;
					ROOT[i][j] := r;
				elseif (t < EV[i][j]):
					EV[i][j] := t;
					ROOT[i][j] := r;
				fi;
			endfor;
		endfor;
	endfor;
enddef;

vardef img_subheap(suffix DATA)(expr i, j, p, n, xunit, yunit, gsize) :=
image(
	save fr;
	path fr;
	fr := fullcircle scaled gsize;

	save nn;
	numeric nn;
	nn := n / 2;
	if nn < 0.5:
		nn := 0.5;
	fi;

	save root;
	numeric root;
	root := DATA[i][j];

	%message "img subheap " & decimal(i) & " " & decimal(j) & " " & decimal (root);

	fill fr shifted p withcolor .8white;
	label(TEX("$k_" & decimal(root) & "$"), p) withcolor black;

	%if i <= root:
		save cp;
		pair cp;
		cp := (xpart p - nn * xunit, ypart p - yunit);
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp));
		if (i < root):
			draw img_subheap(DATA)(i, root-1, cp, nn, xunit, yunit, gsize);
		else:
			fill fr shifted cp withcolor .8white;
			label(TEX("$d_" & decimal(root-1) & "$"), cp) withcolor black;
		fi;
	%fi;

	%if root <= j:
		save cp;
		pair cp;
		cp := (xpart p + nn * xunit, ypart p - yunit);
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp));
		if (root < j):
			draw img_subheap(DATA)(root+1, j, cp, nn, xunit, yunit, gsize);
		else:
			fill fr shifted cp withcolor .8white;
			label(TEX("$d_" & decimal(root) & "$"), cp) withcolor black;
		fi;
	%else:
	%fi;
)
enddef;

% global content
numeric len;
numeric P[];
numeric Q[];
numeric EV[][];
numeric WEIGHT[][];
numeric ROOT[][];

len := 7;
P[0] := 0.00;	Q[0] := 0.06;
P[1] := 0.04;	Q[1] := 0.06;
P[2] := 0.06;	Q[2] := 0.06;
P[3] := 0.08;	Q[3] := 0.06;
P[4] := 0.02;	Q[4] := 0.05;
P[5] := 0.10;	Q[5] := 0.05;
P[6] := 0.12;	Q[6] := 0.05;
P[7] := 0.14;	Q[7] := 0.05;

optimal_bst(P, Q, len, EV, WEIGHT, ROOT);

beginfig(1);
	draw img_TRIANGLE_MATRIX(EV)("e", 1, 0, len+1, 0.6cm);
endfig;
beginfig(2);
	draw img_TRIANGLE_MATRIX(WEIGHT)("w", 1, 0, len+1, 0.6cm);
endfig;
beginfig(3);
	draw img_TRIANGLE_MATRIX(ROOT)("root", 1, 1, len, 0.6cm);
endfig;
beginfig(4);
	draw img_subheap(ROOT)(1, len, (0,0), 4, 0.8cm, 0.8cm, 0.6cm);
endfig;

end;
