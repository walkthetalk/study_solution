input bin_heap

vardef imgSixFiveOne(expr recurselevel) :=
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

	numeric localcnt;
	localcnt := 1;

	% init
	if localcnt = recurselevel:
		draw img_heap_focus(data)(ALength, 1, 0.5cm, 0.8cm,0.8cm, true);
	fi;
	localcnt := localcnt + 1;
	% swap
	data[1] := data[12];
	ALength := ALength - 1;
	if localcnt = recurselevel:
		draw img_heap_focus(data)(ALength, 1, 0.5cm, 0.8cm,0.8cm, true);
	fi;
	localcnt := localcnt + 1;
	% max-heapify
	numeric dst;
	dst := max_heapify_ret(data)(ALength, 1, true);
	if localcnt = recurselevel:
		draw img_heap_focus(data)(ALength, dst, 0.5cm, 0.8cm,0.8cm, true);
	fi;
	localcnt := localcnt + 1;
)
enddef;

beginfig(1);
	draw imgSixFiveOne(1);
endfig;

beginfig(2);
	draw imgSixFiveOne(2);
endfig;

beginfig(3);
	draw imgSixFiveOne(3);
endfig;

end;
