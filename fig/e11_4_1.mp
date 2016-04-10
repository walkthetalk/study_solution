% DAH start at 0
vardef hash_line_insert(suffix DAH)(expr k) :=
	save tmp, i;
	numeric tmp, i;
	i := 0;
	forever:
		exitif i = DAH.len;
		tmp := (k + i) mod DAH.len;
		exitif unknown DAH[tmp];

		i := i + 1;
	endfor;

	DAH[tmp] := k;
enddef;
vardef hash_quad_insert(suffix DAH)(expr k) :=
	save tmp, i;
	numeric tmp, i;
	i := 0;
	forever:
		exitif i = DAH.len;
		tmp := (k + i + 3 * i * i) mod DAH.len;
		exitif unknown DAH[tmp];

		i := i + 1;
	endfor;

	DAH[tmp] := k;
enddef;
vardef hash_double_insert(suffix DAH)(expr k) :=
	save tmp, i;
	numeric tmp, i;
	i := 0;
	forever:
		exitif i = DAH.len;
		tmp := (k + i * (1 + k mod (DAH.len - 1))) mod DAH.len;
		exitif unknown DAH[tmp];

		i := i + 1;
	endfor;

	DAH[tmp] := k;
enddef;

vardef img_hash(suffix DAH)(expr gsize) :=
image(
	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	label("H", (0,0));

	path plist;
	plist := pelement yscaled 0.8;
	for i = 0 upto (DAH.len - 1):
		numeric yshift;
		yshift := -gsize * (i + 1);
		label(decimal(i), (0, yshift));
		numeric xshift;
		xshift := gsize;

		% tail node
		if known DAH[i]:
			fill (plist shifted (xshift, yshift)) withcolor 0.8 white;
			draw (plist shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.1gsize);
			label(decimal(DAH[i]), (xshift, yshift));
		else:
			fill (plist shifted (xshift, yshift)) withcolor 0.8 white;
			draw (plist shifted (xshift, yshift)) withcolor black withpen (pencircle scaled 0.1gsize);
			label("/", (xshift, yshift));
		fi;
	endfor;
)
enddef;

vardef imgElevenFourOne(expr idx) :=
image(
	numeric DAH[];
	numeric DAH.len;
	DAH.len := 11;

	numeric A[];
	numeric A.len;
	A[1] := 10;
	A[2] := 22;
	A[3] := 31;
	A[4] := 4;
	A[5] := 15;
	A[6] := 28;
	A[7] := 17;
	A[8] := 88;
	A[9] := 59;
	A.len := 9;

	for i := 1 upto A.len:
		if idx = 1:
			hash_line_insert(DAH)(A[i]);
		fi;
		if idx = 2:
			hash_quad_insert(DAH)(A[i]);
		fi;
		if idx = 3:
			hash_double_insert(DAH)(A[i]);
		fi;
	endfor;
	draw img_hash(DAH)(.5cm);
)
enddef;

beginfig(1);
	draw imgElevenFourOne(1);
endfig;

beginfig(2);
	draw imgElevenFourOne(2);
endfig;

beginfig(3);
	draw imgElevenFourOne(3);
endfig;

end;
