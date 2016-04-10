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

% @order: 0 preorder; 1 inorder; 2 postorder;
vardef preorder_tree_walk(suffix A)(expr i, xunit, yunit) :=
image(
	pair pos;
	pos := (7 * xunit,yunit);

	label.lft("pre-order:", pos);
	pos := (xpart(pos) + .5xunit, ypart(pos));

	numeric prev, node;
	numeric li, ri, pi;

	prev := 0;
	node := i;
	forever:
		exitif node = 0;
		li := lchild(node);
		if unknown(A[li]):
			li := 0;
		fi;
		ri := rchild(node);
		if unknown(A[ri]):
			ri := 0;
		fi;
		pi := parent(node);
		if unknown(A[pi]):
			pi := 0;
		fi;

		if prev = pi:
			label(decimal(A[node]), pos);
			pos := (xpart(pos) + xunit, ypart(pos));
			if not(li = 0): % left leap
				prev := node;
				node := li;
			elseif not(ri = 0):
				prev := node;
				node := ri;
			else:
				prev := node;
				node := pi;
			fi;
		elseif prev = li:
			if not(ri = 0):
				prev := node;
				node := ri;
			else:
				prev := node;
				node := pi;
			fi;
		elseif prev = ri:
			prev := node;
			node := pi;
		fi;
	endfor;
)
enddef;
vardef inorder_tree_walk(suffix A)(expr i, xunit, yunit) :=
image(
	pair pos;
	pos := (7 * xunit,yunit);

	label.lft("in-order:", pos);
	pos := (xpart(pos) + .5xunit, ypart(pos));

	numeric prev, node;
	numeric li, ri, pi;

	prev := 0;
	node := i;
	forever:
		exitif node = 0;
		li := lchild(node);
		if unknown(A[li]):
			li := 0;
		fi;
		ri := rchild(node);
		if unknown(A[ri]):
			ri := 0;
		fi;
		pi := parent(node);
		if unknown(A[pi]):
			pi := 0;
		fi;

		if prev = pi:
			if not(li = 0): % left leap
				prev := node;
				node := li;
			else:
				label(decimal(A[node]), pos);
				pos := (xpart(pos) + xunit, ypart(pos));
				if not(ri = 0):
					prev := node;
					node := ri;
				else:
					prev := node;
					node := pi;
				fi;
			fi;
		elseif prev = li:
			label(decimal(A[node]), pos);
			pos := (xpart(pos) + xunit, ypart(pos));
			if not(ri = 0):
				prev := node;
				node := ri;
			else:
				prev := node;
				node := pi;
			fi;
		elseif prev = ri:
			prev := node;
			node := pi;
		fi;
	endfor;
)
enddef;
vardef postorder_tree_walk(suffix A)(expr i, xunit, yunit) :=
image(
	pair pos;
	pos := (7 * xunit,yunit);

	label.lft("post-order:", pos);
	pos := (xpart(pos) + .5xunit, ypart(pos));

	numeric prev, node;
	numeric li, ri, pi;

	prev := 0;
	node := i;
	forever:
		exitif node = 0;
		li := lchild(node);
		if unknown(A[li]):
			li := 0;
		fi;
		ri := rchild(node);
		if unknown(A[ri]):
			ri := 0;
		fi;
		pi := parent(node);
		if unknown(A[pi]):
			pi := 0;
		fi;

		if prev = pi:
			if not(li = 0): % left leap
				prev := node;
				node := li;
			elseif not(ri = 0):
				prev := node;
				node := ri;
			else:
				label(decimal(A[node]), pos);
				pos := (xpart(pos) + xunit, ypart(pos));
				prev := node;
				node := pi;
			fi;
		elseif prev = li:
			if not(ri = 0):
				prev := node;
				node := ri;
			else:
				label(decimal(A[node]), pos);
				pos := (xpart(pos) + xunit, ypart(pos));
				prev := node;
				node := pi;
			fi;
		elseif prev = ri:
			label(decimal(A[node]), pos);
			pos := (xpart(pos) + xunit, ypart(pos));
			prev := node;
			node := pi;
		fi;
	endfor;
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
	data[1] := 10;
	data[2] :=  4;
	data[3] := 17;
	data[4] :=  1;
	data[5] :=  5;
	data[6] := 16;
	data[7] := 21;
	data.len := 7;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
	draw preorder_tree_walk(data)(1, 0.5cm, 0cm);
	draw inorder_tree_walk(data)(1, 0.5cm, -1cm);
	draw postorder_tree_walk(data)(1, 0.5cm, -2cm);
endfig;

beginfig(2);
	numeric data[];
	numeric data.len;
	data[1] := 10;
	data[2] :=  4;
	data[3] := 16;
	data[4] :=  1;
	data[5] :=  5;
	data[7] := 17;
	data[15] := 21;
	data.len := 15;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
	draw preorder_tree_walk(data)(1, 0.5cm, 0cm);
	draw inorder_tree_walk(data)(1, 0.5cm, -1cm);
	draw postorder_tree_walk(data)(1, 0.5cm, -2cm);
endfig;

beginfig(3);
	numeric data[];
	numeric data.len;
	data[1] := 5;
	data[2] :=  4;
	data[3] := 10;
	data[4] :=  1;
	data[7] := 16;
	data[15] := 17;
	data[31] := 21;
	data.len := 31;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
	draw preorder_tree_walk(data)(1, 0.5cm, 0cm);
	draw inorder_tree_walk(data)(1, 0.5cm, -1cm);
	draw postorder_tree_walk(data)(1, 0.5cm, -2cm);
endfig;

beginfig(4);
	numeric data[];
	numeric data.len;
	data[1] := 4;
	data[2] := 1;
	data[3] := 5;
	data[7] := 10;
	data[15] := 16;
	data[31] := 17;
	data[63] := 21;
	data.len := 63;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
	draw preorder_tree_walk(data)(1, 0.5cm, 0cm);
	draw inorder_tree_walk(data)(1, 0.5cm, -1cm);
	draw postorder_tree_walk(data)(1, 0.5cm, -2cm);
endfig;

beginfig(5);
	numeric data[];
	numeric data.len;
	data[1] := 1;
	data[3] := 4;
	data[7] := 5;
	data[15] := 10;
	data[31] := 16;
	data[63] := 17;
	data[127] := 21;
	data.len := 127;

	draw img_bin_search_tree(data)(0.5cm, 0.8cm,0.8cm);
	draw preorder_tree_walk(data)(1, 0.5cm, 0cm);
	draw inorder_tree_walk(data)(1, 0.5cm, -1cm);
	draw postorder_tree_walk(data)(1, 0.5cm, -2cm);
endfig;

end;
