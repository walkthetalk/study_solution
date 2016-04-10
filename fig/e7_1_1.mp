input quick_sort

vardef imgSevenOneOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 13;
	data[2] := 19;
	data[3] := 9;
	data[4] := 5;
	data[5] := 12;
	data[6] := 8;
	data[7] := 7;
	data[8] := 4;
	data[9] := 21;
	data[10] := 2;
	data[11] := 6;
	data[12] := 11;
	ALength := 12;

	numeric x, i;
	x := data[ALength];
	i := 0;
	for j = 1 upto (ALength - 1):
		if j = recurselevel:
			draw img_partition(data)(ALength, 1, i+1, i+1, j, ALength, .5cm);
		fi;
		if data[j] <= x:
			i := i + 1;
			exchange(data)(i, j);
		fi;
	endfor;
	if ALength = recurselevel:
		draw img_partition(data)(ALength, 1, i+1, i+1, ALength, ALength, .5cm);
	fi;
	exchange(data)(i+1, ALength);
	if (ALength + 1) = recurselevel:
		draw img_partition(data)(ALength, 1, i+1, i+2, ALength+1, i+1, .5cm);
	fi;
)
enddef;

beginfig(1);
	draw imgSevenOneOne(1);
endfig;

beginfig(2);
	draw imgSevenOneOne(2);
endfig;

beginfig(3);
	draw imgSevenOneOne(3);
endfig;

beginfig(4);
	draw imgSevenOneOne(4);
endfig;

beginfig(5);
	draw imgSevenOneOne(5);
endfig;

beginfig(6);
	draw imgSevenOneOne(6);
endfig;

beginfig(7);
	draw imgSevenOneOne(7);
endfig;

beginfig(8);
	draw imgSevenOneOne(8);
endfig;

beginfig(9);
	draw imgSevenOneOne(9);
endfig;

beginfig(10);
	draw imgSevenOneOne(10);
endfig;

beginfig(11);
	draw imgSevenOneOne(11);
endfig;

beginfig(12);
	draw imgSevenOneOne(12);
endfig;

beginfig(13);
	draw imgSevenOneOne(13);
endfig;

end;
