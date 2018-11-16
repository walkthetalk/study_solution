% A start at 1, C start at 0
vardef radix_sort(suffix A, B, C)(expr ALength, BLength, CLength, gsize, bitIdx) :=
	% init
	for i = 0 upto CLength:
		C[i] := 0;
	endfor;

	for i = 1 upto BLength:
		B[i] := "";	% empty represent not assigned
	endfor;

	for i = 1 upto ALength:
		numeric tmp;
		tmp := ASCII (substring (bitIdx, bitIdx+1) of A[i]);
		if (0 <= tmp) and (tmp <= CLength):
			C[tmp] := C[tmp] + 1;
		fi;
	endfor;
	% recount
	for i = 1 upto CLength:
		C[i] := C[i] + C[i-1];
	endfor;
	% sort
	for j = ALength downto 1:
		numeric tmp;
		tmp := ASCII (substring (bitIdx, bitIdx+1) of A[j]);
		B[C[tmp]] := A[j];
		C[tmp] := C[tmp] - 1;
	endfor;

	% replace A with B
	for j = 1 upto ALength:
		A[j] := B[j];
	endfor;
enddef;

vardef img_radix_sort(suffix A)(expr ALength, gsize, bitIdx) :=
image(
	if bitIdx >= 0:
		fill (unitsquare shifted(-0.5, 0) xscaled gsize yscaled (-gsize * ALength) shifted(0, -.5gsize) shifted(bitIdx * gsize, 0)) withcolor 0.5 white;
	fi;

	for i = 1 upto ALength:
		pair shiftp;
		shiftp := (0, -gsize * i);
		for j = 0 upto 2:
			label((substring (j,j+1) of A[i]) infont "pcrbc7t" scaled .12gsize, shiftp + (gsize * j, 0)) withcolor black;
		endfor;
	endfor;
)
enddef;

vardef imgEgihtTwoOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	string A[];
	A[1] := "COW";
	A[2] := "DOG";
	A[3] := "SEA";
	A[4] := "RUG";
	A[5] := "ROW";
	A[6] := "MOB";
	A[7] := "BOX";
	A[8] := "TAB";
	A[9] := "BAR";
	A[10] := "EAR";
	A[11] := "TAR";
	A[12] := "DIG";
	A[13] := "BIG";
	A[14] := "TEA";
	A[15] := "NOW";
	A[16] := "FOX";
	ALength := 16;

	numeric C[];
	numeric CLength;
	CLength := 255;

	string B[];
	numeric BLength;
	BLength := ALength;

	numeric localcnt;
	localcnt := 1;

	% init
	if localcnt = recurselevel:
		draw img_radix_sort(A)(ALength, .5cm, -1);
	fi;
	localcnt := localcnt + 1;

	for i = 2 downto 0:
		radix_sort(A, B, C)(ALength, BLength, CLength, .5cm, i);

		if localcnt = recurselevel:
			drawarrow (-2cm, -ALength/2 * .5cm)--(-.3cm, -ALength/2 * .5cm);
			draw img_radix_sort(A)(ALength, .5cm, i);
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

end;
