bboxmargin := 0;

% for any def, use expr/primary, don't use suffix
vardef lchild primary $ =
	($ * 2)
enddef;

vardef rchild primary $ =
	($ * 2 + 1)
enddef;

vardef parent primary $ =
	(floor($ / 2))
enddef;

vardef validate(suffix A)(expr i) :=
	if known(A[i]):
		i
	else:
		0
	fi;
enddef;

vardef img_sub_bin_search_fine_tree(suffix A)(expr i, xunit, yunit, gsize) :=
image(
	save fr;
	path fr;
	fr := fullcircle scaled gsize;

	fill fr withcolor .8white;
	label(decimal(A[i]), (0,0)) withcolor black;

	if known(A[lchild(i)]):
		save subpic;
		picture subpic;
		subpic := img_sub_bin_search_fine_tree(A)(lchild(i), xunit, yunit, gsize);

		save subroot;
		pair subroot;
		subroot := (-xpart(urcorner subpic) - (xunit-gsize)/2, -yunit);

		drawarrow (fr intersectionpoint ((0,0) -- subroot))
			..((fr shifted subroot) intersectionpoint ((0,0) -- subroot)) withcolor black;
		draw subpic shifted subroot;
	fi;

	if known(A[rchild(i)]):
		save subpic;
		picture subpic;
		subpic := img_sub_bin_search_fine_tree(A)(rchild(i), xunit, yunit, gsize);

		save subroot;
		pair subroot;
		subroot := (-xpart(ulcorner subpic) + (xunit-gsize)/2, -yunit);

		drawarrow (fr intersectionpoint ((0,0) -- subroot))
			..((fr shifted subroot) intersectionpoint ((0,0) -- subroot)) withcolor black;
		draw subpic shifted subroot;
	fi;
)
enddef;

vardef img_bin_search_tree(suffix A)(expr gsize, xunit, yunit) :=
image(
	draw img_sub_bin_search_fine_tree(A)(1, xunit, yunit, gsize);
)
enddef;

beginfig(1);
	numeric data[];
	numeric data.len;
	data[1] := 8;
	data[2] :=  4;
	data[3] := 12;
	data[4] :=  2;
	data[5] :=  6;
	data[6] := 10;
	data[7] := 14;
	data[8] := 1;
	data[9] := 3;
	data[10] := 5;
	data[11] := 7;
	data[12] := 9;
	data[13] := 11;
	data[14] := 13;
	data[15] := 15;
	data.len := 15;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

end;
