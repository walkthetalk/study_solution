input TEX;

vardef texlabel@#(expr strname, pos) text p =
	label@#(TEX(strname), pos) p
enddef;

vardef mathlabel@#(expr strname, pos) text p =
	label@#(TEX("$" & strname & "$"), pos) p
enddef;

vardef img_array(suffix A)(expr name, gsize) :=
image(
	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	label.lft(name, (0.5,0) scaled gsize);
	for i = 1 upto A.len:
		pair shiftpos;
		shiftpos := (i * gsize, 0);
		if unknown(A[i]):
			fill pelement shifted shiftpos withcolor .2 white;
			draw pelement shifted shiftpos withcolor black withpen (pencircle scaled .1 gsize);
		else:
			fill pelement shifted shiftpos withcolor .8 white;
			draw pelement shifted shiftpos withcolor black withpen (pencircle scaled .1 gsize);
			if A[i] = 0:
				label("/", shiftpos);
			else:
				label(decimal(A[i]), shiftpos);
			fi;
		fi;
	endfor;
)
enddef;

vardef img_idx(expr len, gsize) :=
image(
	for i = 1 upto len:
		pair shiftpos;
		shiftpos := (i * gsize, 0);
		label(decimal(i), shiftpos);
	endfor;
)
enddef;

vardef img_llheader(expr idx, gsize) :=
image(
	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	pair shiftpos;
	shiftpos := (-1 * gsize, 0);

	fill pelement shifted shiftpos withcolor .8 white;
	draw pelement shifted shiftpos withcolor black withpen (pencircle scaled .1 gsize);
	label("L", shiftpos);

	drawarrow (shiftpos shifted (.5 * gsize, 0))--(idx * gsize, 0)--(idx * gsize, -1 * gsize);
)
enddef;

vardef img_TenThreeOne_first :=
image(
	numeric next[], key[], prev[];
	numeric next.len, key.len, prev.len;
	next.len := 12;
	key.len := 12;
	prev.len := 12;

	next[ 2] :=  5;
	key [ 2] :=  4;
	prev[ 2] :=  8;
	next[ 4] :=  7;
	key [ 4] :=  5;
	prev[ 4] := 10;
	next[ 5] := 10;
	key [ 5] :=  8;
	prev[ 5] :=  2;
	next[ 7] :=  0;
	key [ 7] := 11;
	prev[ 7] :=  4;
	next[ 8] :=  2;
	key [ 8] := 13;
	prev[ 8] :=  0;
	next[10] :=  4;
	key [10] := 19;
	prev[10] :=  5;

	numeric gsize;
	gsize := .5cm;

	draw img_idx(next.len, gsize) shifted (0, 2 * gsize);
	draw img_llheader(8, gsize) shifted (0, 1.5 * gsize);
	draw img_array(next)("next", gsize);
	draw img_array(key)("key", gsize) shifted (0,-gsize);
	draw img_array(prev)("prev", gsize) shifted (0,-gsize * 2);
)
enddef;


vardef img_array_with_group(suffix A)(expr name, gsize) :=
image(
	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	label.lft(name, (0.5,0) scaled gsize);
	for i = 1 upto A.len:
		pair shiftpos;
		shiftpos := (i * gsize, 0);
		if unknown(A[i]):
			fill pelement shifted shiftpos withcolor .2 white;
			draw pelement shifted shiftpos withcolor black withpen (pencircle scaled .05 gsize);
		else:
			fill pelement shifted shiftpos withcolor .8 white;
			draw pelement shifted shiftpos withcolor black withpen (pencircle scaled .05 gsize);
			if A[i] = 0:
				label("/", shiftpos);
			else:
				label(decimal(A[i]), shiftpos);
			fi;
		fi;
	endfor;

	path pgroup;
	pgroup := unitsquare xscaled (3 * gsize) yscaled gsize shifted(-0.5gsize,-0.5gsize);
	for i = 1 upto A.len:
		if (i mod 3 = 1):
			draw pgroup shifted (i * gsize, 0) withcolor black withpen (pencircle scaled .2 gsize);;
		fi;
	endfor;
)
enddef;

vardef img_TenThreeOne_second :=
image(
	numeric A[];
	numeric A.len;
	A.len := 18;

	A[ 1] :=  4;
	A[ 2] :=  7;
	A[ 3] := 13;
	A[ 4] :=  5;
	A[ 5] := 10;
	A[ 6] := 16;
	A[ 7] :=  8;
	A[ 8] := 16;
	A[ 9] :=  1;
	A[10] := 11;
	A[11] :=  0;
	A[12] :=  4;
	A[13] := 13;
	A[14] :=  1;
	A[15] :=  0;
	A[16] := 19;
	A[17] :=  4;
	A[18] :=  7;

	numeric gsize;
	gsize := .5cm;

	draw img_idx(A.len, gsize) shifted (0, 2 * gsize);
	draw img_llheader(13, gsize) shifted (0, 1.5 * gsize);
	draw img_array_with_group(A)("A", gsize);
)
enddef;

beginfig(1);
	draw img_TenThreeOne_first;
endfig;

beginfig(2);
	draw img_TenThreeOne_second;
endfig;

end;
