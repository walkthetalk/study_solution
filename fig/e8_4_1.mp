% A start at 1, B/C start at 0
vardef bucket_sort(suffix A, B, C)(expr ALength) :=
	% init
	for i = 0 upto (ALength - 1):
		C[i] := 0;
	endfor;

	for i = 1 upto ALength:
		numeric tmp;
		tmp := (ASCII A[i]) - (ASCII "0");
		if tmp < ALength:
			B[tmp][C[tmp]] := A[i];
			C[tmp] := C[tmp] + 1;
		fi;
	endfor;
enddef;

vardef img_bucket_sort(suffix A, B, C)(expr ALength, gsize) :=
image(
	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	label("A", (0,0));
	for i = 1 upto ALength:
		numeric yshift;
		yshift := -gsize * i;
		fill (pelement shifted (0, yshift)) withcolor 0.8 white;
		draw (pelement shifted (0, yshift)) withcolor black withpen (pencircle scaled 0.2gsize);
		label(A[i], (0, yshift));
		label(decimal(i), (-gsize, yshift));
	endfor;

	label("B", (2*gsize, 0));
	path plist;
	plist := pelement yscaled 0.8;
	for i = 0 upto (ALength-1):
		numeric yshift;
		yshift := -gsize * (i+1);
		label(decimal(i), (gsize, yshift));
		numeric xshift;
		xshift := 2 * gsize;
		for j = 0 upto (C[i] - 1):
			if j = 0:
				fill (pelement shifted (xshift, yshift)) withcolor 0.8 white;
				draw (pelement shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.2gsize);
			else:
				fill (plist shifted (xshift, yshift)) withcolor 0.8 white;
				draw (plist shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.1gsize);
			fi;

			drawarrow (xshift, yshift)--(xshift + 1.5gsize, yshift) withpen (pencircle scaled 0.1gsize);
			xshift := xshift + 2*gsize;

			fill (plist shifted (xshift, yshift)) withcolor 0.8 white;
			draw (plist shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.1gsize);
			label(B[i][j], (xshift, yshift));

			xshift := xshift + gsize;
		endfor;

		% tail node
		if C[i] > 0:
			fill (plist shifted (xshift, yshift)) withcolor 0.8 white;
			draw (plist shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.1gsize);
		else:
			fill (pelement shifted (xshift, yshift)) withcolor 0.8 white;
			draw (pelement shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.2gsize);
		fi;
		label("/", (xshift, yshift));
	endfor;
)
enddef;

vardef imgEgihtFourOne :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	string A[];
	A[1] := "79";
	A[2] := "13";
	A[3] := "16";
	A[4] := "64";
	A[5] := "39";
	A[6] := "20";
	A[7] := "89";
	A[8] := "53";
	A[9] := "71";
	A[10] := "42";
	ALength := 10;

	numeric C[];
	string B[][];

	bucket_sort(A, B, C)(ALength);

	draw img_bucket_sort(A, B, C)(ALength, .5cm);
)
enddef;

beginfig(1);
	draw imgEgihtFourOne;
endfig;

end;
