% A start at 1, B/C start at 0
vardef hash_insert(suffix DAH)(expr ele) :=
	% init
	numeric modn;
	modn := ele mod 9;

	DAH.listlen[modn] := DAH.listlen[modn] + 1;
	DAH[modn][DAH.listlen[modn]] := ele;
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
		for j = DAH.listlen[i] downto 1:
			if j = DAH.listlen[i]:
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
			label(decimal(DAH[i][j]), (xshift, yshift));

			xshift := xshift + gsize;
		endfor;

		% tail node
		if DAH.listlen[i] > 0:
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

vardef imgElevenTwoTwo(expr idx) :=
image(
	numeric DAH[][];
	numeric DAH.len;
	numeric DAH.listlen[];
	DAH.len := 9;
	DAH.listlen[0] := 0;
	DAH.listlen[1] := 0;
	DAH.listlen[2] := 0;
	DAH.listlen[3] := 0;
	DAH.listlen[4] := 0;
	DAH.listlen[5] := 0;
	DAH.listlen[6] := 0;
	DAH.listlen[7] := 0;
	DAH.listlen[8] := 0;

	numeric A[];
	numeric A.len;
	A[1] := 5;
	A[2] := 28;
	A[3] := 19;
	A[4] := 15;
	A[5] := 20;
	A[6] := 33;
	A[7] := 12;
	A[8] := 17;
	A[9] := 10;
	A.len := 9;

	for i := 1 upto A.len:
		hash_insert(DAH)(A[i]);
		if i = idx:
			draw img_hash(DAH)(.5cm);
		fi;
	endfor;
)
enddef;

beginfig(1);
	draw imgElevenTwoTwo(1);
endfig;

beginfig(2);
	draw imgElevenTwoTwo(2);
endfig;

beginfig(3);
	draw imgElevenTwoTwo(3);
endfig;

beginfig(4);
	draw imgElevenTwoTwo(4);
endfig;

beginfig(5);
	draw imgElevenTwoTwo(5);
endfig;

beginfig(6);
	draw imgElevenTwoTwo(6);
endfig;

beginfig(7);
	draw imgElevenTwoTwo(7);
endfig;

beginfig(8);
	draw imgElevenTwoTwo(8);
endfig;

beginfig(9);
	draw imgElevenTwoTwo(9);
endfig;

end;
