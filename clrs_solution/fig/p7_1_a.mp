input quick_sort

vardef imgPSevenOneA(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric A[];
	A[1] := 13;
	A[2] := 19;
	A[3] := 9;
	A[4] := 5;
	A[5] := 12;
	A[6] := 8;
	A[7] := 7;
	A[8] := 4;
	A[9] := 11;
	A[10] := 2;
	A[11] := 6;
	A[12] := 21;
	ALength := 12;

	numeric p, r, focus;
	p := 1;
	r := ALength;

	numeric x, i, j;
	x := A[p];	focus := p;
	i := p - 1;
	j := r + 1;

	numeric localcnt;
	localcnt := 1;
	forever:
		forever:
			j := j - 1;
			exitif A[j] <= x;
		endfor;
		forever:
			i := i + 1;
			exitif A[i] >= x;
		endfor;

		% draw and cnt
		if localcnt = recurselevel:
			draw img_partition(A)(ALength, p, i, j+1, r+1, focus, .5cm);
		fi;
		localcnt := localcnt + 1;

		exitif i >= j;
		exchange(A)(i,j);

		% modify focus
		if i = focus:
			focus := j;
		elseif j = focus:
			focus := i;
		fi;
	endfor;
)
enddef;

beginfig(1);
	draw imgPSevenOneA(1);
endfig;

beginfig(2);
	draw imgPSevenOneA(2);
endfig;

beginfig(3);
	draw imgPSevenOneA(3);
endfig;

end;
