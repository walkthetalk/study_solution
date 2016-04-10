input bin_heap

vardef imgPSixOne(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 1;
	data[2] := 2;
	data[3] := 3;
	data[4] := 4;
	data[5] := 5;
	data[6] := 6;
	ALength := 6;

	if recurselevel = 1:
		build_max_heap(data)(ALength, true);
	fi;

	if recurselevel = 2:
		build_max_heap_alt(data)(ALength, true);
	fi;

	draw img_heap(data)(ALength, 0.5cm, 0.8cm,0.8cm, true);
)
enddef;

beginfig(1);
	draw imgPSixOne(1);
endfig;

beginfig(2);
	draw imgPSixOne(2);
endfig;

end;
