input bin_heap

vardef imgSixTwoOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 27;
	data[2] := 17;
	data[3] := 3;
	data[4] := 16;
	data[5] := 13;
	data[6] := 10;
	data[7] := 1;
	data[8] := 5;
	data[9] := 7;
	data[10] := 12;
	data[11] := 4;
	data[12] := 8;
	data[13] := 9;
	data[14] := 0;
	ALength := 14;

	numeric ith;
	ith := 3;
	for i = 1 upto (recurselevel - 1):
		ith := next_heapify(data)(ALength, ith, true);
	endfor;

	draw img_heapify(data)(ALength, ith, 0.5cm, 0.8cm,0.8cm, true);
)
enddef;

beginfig(1);
	draw imgSixTwoOne(1);
endfig;

beginfig(2);
	draw imgSixTwoOne(2);
endfig;

beginfig(3);
	draw imgSixTwoOne(3);
endfig;

end;
