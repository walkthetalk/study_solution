input bin_heap

vardef imgSixOneSix :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 23;
	data[2] := 17;
	data[3] := 14;
	data[4] := 6;
	data[5] := 13;
	data[6] := 10;
	data[7] := 1;
	data[8] := 5;
	data[9] := 7;
	data[10] := 12;
	ALength := 10;

	draw img_heap(data)(ALength, 0.5cm, 0.8cm,0.8cm, true);
)
enddef;

beginfig(1);
	draw imgSixOneSix;
endfig;

end;
