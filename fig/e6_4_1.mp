input bin_heap

vardef imgSixFourOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 5;
	data[2] := 13;
	data[3] := 2;
	data[4] := 25;
	data[5] := 7;
	data[6] := 17;
	data[7] := 20;
	data[8] := 8;
	data[9] := 4;
	ALength := 9;

	build_max_heap(data)(ALength, true);

	numeric half_floor;
	half_floor := 4;

	for i = 0 upto (recurselevel - 2):
		sub_heapsort(data)((ALength - i), true);
	endfor;

	draw img_heapsort(data)(ALength, (ALength - (recurselevel - 1)), 0.5cm, 0.8cm,0.8cm, true);
)
enddef;

beginfig(1);
	draw imgSixFourOne(1);
endfig;

beginfig(2);
	draw imgSixFourOne(2);
endfig;

beginfig(3);
	draw imgSixFourOne(3);
endfig;

beginfig(4);
	draw imgSixFourOne(4);
endfig;

beginfig(5);
	draw imgSixFourOne(5);
endfig;

beginfig(6);
	draw imgSixFourOne(6);
endfig;

beginfig(7);
	draw imgSixFourOne(7);
endfig;

beginfig(8);
	draw imgSixFourOne(8);
endfig;

beginfig(9);
	draw imgSixFourOne(9);
endfig;

end;
