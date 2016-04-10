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

vardef img_sub_bin_search_tree_with_search(suffix A)(expr i, xunit, yunit, gsize, need_search, skey) :=
image(
	save fr;
	path fr;
	fr := fullcircle scaled gsize;

	fill fr withcolor .8white;
	label(decimal(A[i]), (0,0)) withcolor black;

	if known(A[lchild(i)]):
		save next_need_search;
		boolean next_need_search;
		if skey < A[i]:
			next_need_search := need_search;
		else:
			next_need_search := false;
		fi;

		save subpic;
		picture subpic;
		subpic := img_sub_bin_search_tree_with_search(A)(lchild(i), xunit, yunit, gsize, next_need_search, skey);

		save subroot;
		pair subroot;
		subroot := (-xpart(urcorner subpic) - (xunit-gsize)/2, -yunit);

		drawarrow (fr intersectionpoint ((0,0) -- subroot))
			..((fr shifted subroot) intersectionpoint ((0,0) -- subroot)) withcolor black;
		draw subpic shifted subroot;

		if next_need_search:
			drawarrow (fr intersectionpoint ((0,0) -- subroot))
				..((fr shifted subroot) intersectionpoint ((0,0) -- subroot)) withcolor red;
		fi;
	fi;

	if known(A[rchild(i)]):
		save next_need_search;
		boolean next_need_search;
		if skey > A[i]:
			next_need_search := need_search;
		else:
			next_need_search := false;
		fi;

		save subpic;
		picture subpic;
		subpic := img_sub_bin_search_tree_with_search(A)(rchild(i), xunit, yunit, gsize, next_need_search, skey);

		save subroot;
		pair subroot;
		subroot := (-xpart(ulcorner subpic) + (xunit-gsize)/2, -yunit);

		drawarrow (fr intersectionpoint ((0,0) -- subroot))
			..((fr shifted subroot) intersectionpoint ((0,0) -- subroot)) withcolor black;
		draw subpic shifted subroot;

		if next_need_search:
			drawarrow (fr intersectionpoint ((0,0) -- subroot))
				..((fr shifted subroot) intersectionpoint ((0,0) -- subroot)) withcolor red;
		fi;
	fi;
)
enddef;

vardef img_bin_search_tree_with_search(suffix A)(expr gsize, xunit, yunit, skey) :=
image(
	draw img_sub_bin_search_tree_with_search(A)(1, xunit, yunit, gsize, true, skey);
)
enddef;

beginfig(1);
	numeric data[];
	numeric data.len;
	data[1] := 1;
	data[3] := 3;
	data[6] := 2;
	data[7] := 4;
	data.len := 7;

	draw img_bin_search_tree_with_search(data)(0.5cm, 0.8cm,0.8cm,2);
endfig;

end;
