input bin_heap

vardef imgSixThreeOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 5;
	data[2] := 3;
	data[3] := 17;
	data[4] := 10;
	data[5] := 84;
	data[6] := 19;
	data[7] := 6;
	data[8] := 22;
	data[9] := 9;
	ALength := 9;

	numeric half_floor;
	half_floor := 4;

	for i = half_floor downto (half_floor + 2 - recurselevel):
		max_heapify(data)(ALength, i, true);
	endfor;

	draw img_heapify(data)(ALength, (half_floor + 1 - recurselevel), 0.5cm, 0.8cm,0.8cm, true);
)
enddef;

beginfig(1);
	draw imgSixThreeOne(1);
endfig;

beginfig(2);
	draw imgSixThreeOne(2);
endfig;

beginfig(3);
	draw imgSixThreeOne(3);
endfig;

beginfig(4);
	draw imgSixThreeOne(4);
endfig;

beginfig(5);
	draw imgSixThreeOne(5);
endfig;

end;
