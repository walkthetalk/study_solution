% A start at 1, C start at 0
vardef counting_sort_init(suffix A, B, C)(expr ALength, BLength, CLength) :=
	for i = 0 upto CLength:
		C[i] := 0;
	endfor;

	for i = 1 upto BLength:
		B[i] := -1;	% negative represent not assigned
	endfor;

	for i = 1 upto ALength:
		numeric tmp;
		tmp := A[i];
		if (0 <= tmp) and (tmp <= CLength):
			C[tmp] := C[tmp] + 1;
		fi;
	endfor;
enddef;
% C start at 0
vardef counting_sort_recount(suffix C)(expr CLength) :=
	for i = 1 upto CLength:
		C[i] := C[i] + C[i-1];
	endfor;
enddef;

vardef img_counting_sort(suffix A, B, C)(expr ALength, BLength, CLength, gsize, withhead) :=
image(
	path pelement;
	pelement := unitsquare shifted (-0.5, -0.5) scaled gsize;

	for i = 1 upto ALength:
		pair shiftp;
		shiftp := (gsize * i, 0);
		draw pelement shifted shiftp withcolor black withpen (pencircle scaled 0.2gsize);
		fill pelement shifted shiftp withcolor 0.8 white;
		label(decimal(A[i]), shiftp) withcolor black;

		if withhead:
			label(decimal(i), (xpart shiftp, gsize)) withcolor black;
		fi;
	endfor;

	for i = 0 upto CLength:
		pair shiftp;
		shiftp := (gsize * (i + 1.5 + ALength), 0);
		draw pelement shifted shiftp withcolor black withpen (pencircle scaled 0.2gsize);
		fill pelement shifted shiftp withcolor 0.8 white;
		label(decimal(C[i]), shiftp) withcolor black;

		if withhead:
			label(decimal(i), (xpart shiftp, gsize)) withcolor black;
		fi;
	endfor;

	for i = 1 upto BLength:
		pair shiftp;
		shiftp := (gsize * (i + 2 + ALength + CLength), 0);
		if B[i] < 0:	% not assigned
			draw pelement shifted shiftp withcolor black withpen (pencircle scaled 0.2gsize);
			fill pelement shifted shiftp withcolor 0.2 white;
		else:
			draw pelement shifted shiftp withcolor black withpen (pencircle scaled 0.2gsize);
			fill pelement shifted shiftp withcolor 0.8 white;
			label(decimal(B[i]), shiftp) withcolor black;
		fi;

		if withhead:
			label(decimal(i), (xpart shiftp, gsize)) withcolor black;
		fi;
	endfor;
)
enddef;

vardef imgEgihtTwoOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric A[];
	A[1] := 6;
	A[2] := 0;
	A[3] := 2;
	A[4] := 0;
	A[5] := 1;
	A[6] := 3;
	A[7] := 4;
	A[8] := 6;
	A[9] := 1;
	A[10] := 3;
	A[11] := 2;
	ALength := 11;

	numeric C[];
	numeric CLength;
	CLength := 6;

	numeric B[];
	numeric BLength;
	BLength := ALength;

	numeric localcnt;
	localcnt := 1;

	% init
	counting_sort_init(A, B, C)(ALength, BLength, CLength);
	if localcnt = recurselevel:
		draw img_counting_sort(A, B, C)(ALength, BLength, CLength, .5cm, true);
	fi;
	localcnt := localcnt + 1;
	% recount
	counting_sort_recount(C)(CLength);
	if localcnt = recurselevel:
		draw img_counting_sort(A, B, C)(ALength, BLength, CLength, .5cm, false);
	fi;
	localcnt := localcnt + 1;
	% sort
	for j = ALength downto 1:
		numeric tmp;
		tmp := A[j];
		B[C[tmp]] := tmp;
		C[tmp] := C[tmp] - 1;

		if localcnt = recurselevel:
			draw img_counting_sort(A, B, C)(ALength, BLength, CLength, .5cm, false);
		fi;
		localcnt := localcnt + 1;
	endfor;
)
enddef;

beginfig(1);
	draw imgEgihtTwoOne(1);
endfig;

beginfig(2);
	draw imgEgihtTwoOne(2);
endfig;

beginfig(3);
	draw imgEgihtTwoOne(3);
endfig;

beginfig(4);
	draw imgEgihtTwoOne(4);
endfig;

beginfig(5);
	draw imgEgihtTwoOne(5);
endfig;

beginfig(6);
	draw imgEgihtTwoOne(6);
endfig;

beginfig(7);
	draw imgEgihtTwoOne(7);
endfig;

beginfig(8);
	draw imgEgihtTwoOne(8);
endfig;

beginfig(9);
	draw imgEgihtTwoOne(9);
endfig;

beginfig(10);
	draw imgEgihtTwoOne(10);
endfig;

beginfig(11);
	draw imgEgihtTwoOne(11);
endfig;

beginfig(12);
	draw imgEgihtTwoOne(12);
endfig;

beginfig(13);
	draw imgEgihtTwoOne(13);
endfig;

end;
