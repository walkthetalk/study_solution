input TEX;

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

	fill fr withcolor A.c[i];
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
	color data.c[];
	data[1] := 38;	data.c[1] := 0.4 white;
	data[2] := 19;	data.c[2] := red;
	data[3] := 41;	data.c[3] := 0.4 white;
	data[4] := 12;	data.c[4] := 0.4 white;
	data[5] := 31;	data.c[5] := 0.4 white;
	data[8] := 8;	data.c[8] := red;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

beginfig(2);
	numeric data[];
	color data.c[];
	data[1] := 38;	data.c[1] := 0.4 white;
	data[2] := 19;	data.c[2] := red;
	data[3] := 41;	data.c[3] := 0.4 white;
	data[4] := 12;	data.c[4] := 0.4 white;
	data[5] := 31;	data.c[5] := 0.4 white;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

beginfig(3);
	numeric data[];
	color data.c[];
	data[1] := 38;	data.c[1] := 0.4 white;
	data[2] := 19;	data.c[2] := 0.4 white;
	data[3] := 41;	data.c[3] := 0.4 white;
	data[5] := 31;	data.c[5] := red;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

beginfig(4);
	numeric data[];
	color data.c[];
	data[1] := 38;	data.c[1] := 0.4 white;
	data[2] := 31;	data.c[2] := 0.4 white;
	data[3] := 41;	data.c[3] := 0.4 white;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

beginfig(5);
	numeric data[];
	color data.c[];
	data[1] := 38;	data.c[1] := 0.4 white;
	data[3] := 41;	data.c[3] := red;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

beginfig(6);
	numeric data[];
	color data.c[];
	data[1] := 41;	data.c[1] := 0.4 white;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

end;
