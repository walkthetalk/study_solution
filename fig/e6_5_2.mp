input bin_heap

vardef imgSixFiveTwo(expr recurselevel) :=
image(
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 15;
	data[2] := 13;
	data[3] := 9;
	data[4] := 5;
	data[5] := 12;
	data[6] := 8;
	data[7] := 7;
	data[8] := 4;
	data[9] := 0;
	data[10] := 6;
	data[11] := 2;
	data[12] := 1;
	ALength := 12;

	% insert to tail
	ALength := ALength + 1;
	data[ALength] := 10;

	numeric localcnt;
	localcnt := 1;

	% for
	numeric focus_index;
	focus_index := ALength;
	forever:
		if localcnt = recurselevel:
			draw img_heap_focus(data)(ALength, focus_index, 0.5cm, 0.8cm,0.8cm, true);
		fi;
		localcnt := localcnt + 1;

		exitif focus_index <= 1;

		numeric parent_index;
		parent_index := floor(focus_index / 2);
		exitif data[focus_index] <= data[parent_index];
		numeric tmp;
		% exchange
		tmp := data[parent_index];
		data[parent_index] := data[focus_index];
		data[focus_index] := tmp;

		% next loop
		focus_index := parent_index;
	endfor;
)
enddef;

beginfig(1);
	draw imgSixFiveTwo(1);
endfig;

beginfig(2);
	draw imgSixFiveTwo(2);
endfig;

beginfig(3);
	draw imgSixFiveTwo(3);
endfig;

end;
