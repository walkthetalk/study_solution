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

	if known(A[lchild(i)]) or known(A[lchild(i)]):
		fill fr withcolor .8white;
	fi;
	label(TEX("$" & A[i] & "$"), (0,0)) withcolor black;

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
	draw (0, gsize/2)--(0,gsize/2+yunit/2);
	draw img_sub_bin_search_fine_tree(A)(1, xunit, yunit, gsize);
)
enddef;

beginfig(1);
	string data[];
	numeric data.len;
	data[1] := "y";
	data[2] := "x";
	data[3] := "\gamma";
	data[4] := "\alpha";
	data[5] := "\beta";
	data.len := 5;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
endfig;

end;
