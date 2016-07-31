input insert_sort

numeric figidx;

for figidx := 1 upto 6:
beginfig(figidx);
	numeric gridsize;
	numeric ALength;	% don't use 'length' which is keyword used by arrow
	numeric data[];
	data[1] := 31;
	data[2] := 41;
	data[3] := 59;
	data[4] := 26;
	data[5] := 41;
	data[6] := 58;
	ALength := 6;
	gridsize := .5cm;

	for i := 2 upto figidx:
		draw insert_sort_step(data, ALength)(gridsize, i, true, false);
	endfor;
	if (figidx < ALength):
		draw insert_sort_step(data, ALength)(gridsize, (figidx + 1), true, true);
	else:
		draw insert_sort_result(data, ALength)(gridsize);
	fi;
endfig;
endfor;

end;
