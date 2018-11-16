input memory;

vardef btree_search(suffix tree)(expr x, k) :=
	numeric i;
	i := 1;
	forever:
		exitif (i > tree[x]n) or (k <= tree[x]key[i]);
		i := i + 1;
	endfor;
	if (i <= tree[x]n) and (k == tree[x]key[i]):
		(x, i)
	elseif tree[x]leaf:
		(0, 0)
	else:
		btree_search(tree)(tree[x]child[i], k)
	fi;
enddef;

vardef btree_create(suffix tree)(expr maxnodes, mindegree) :=
	init_freelist(tree.free_list)(maxnodes);
	tree.root := alloc_node(tree.free_list);
	%message "create: root is " & decimal(tree.root);
	tree[tree.root]leaf := true;
	tree[tree.root]n := 0;
	tree.t := mindegree;
	tree.height := 0;
enddef;

vardef btree_split_child(suffix tree)(expr x, i) :=
	save y,z;
	numeric y,z;
	z := alloc_node(tree.free_list);
	y := tree[x]child[i];
	%message "split child " & decimal(x) & " at " & decimal(i) & " y(" & decimal(y) & ") z(" & decimal(z) & ")";
	tree[z]leaf := tree[y]leaf;
	tree[z]n := tree.t - 1;
	save j;
	numeric j;
	for j := 1 upto (tree.t - 1):
		tree[z]key[j] := tree[y]key[j+tree.t];
	endfor;
	if not tree[y]leaf:
		for j := 1 upto tree.t:
			tree[z]child[j] := tree[y]child[j+tree.t];
		endfor;
	fi;
	tree[y]n := tree.t - 1;
	for j := (tree[x]n + 1) downto (i + 1):
		tree[x]child[j+1] := tree[x]child[j];
	endfor;
	tree[x]child[i+1] := z;
	for j := tree[x]n downto i:
		tree[x]key[j+1] := tree[x]key[j];
	endfor;
	tree[x]key[i] := tree[y]key[tree.t];
	tree[x]n := tree[x]n + 1;
	%message "after split, y contain:";
	%for j := 1 upto tree[y]n:
	%	message "    " & char(tree[y]key[j]);
	%endfor;
	%message "after split, z contain:";
	%for j := 1 upto tree[z]n:
	%	message "    " & char(tree[z]key[j]);
	%endfor;
enddef;

vardef btree_insert_nonfull(suffix tree)(expr x, k) :=
	save i;
	numeric i;
	i := tree[x]n;
	%message " insert nonfull at " & decimal(x) & " for " & char(k) & " original contain " & decimal(i);
	if tree[x]leaf:
		forever:
			exitif (i < 1);
			exitif (k >= tree[x]key[i]);
			tree[x]key[i+1] := tree[x]key[i];
			i := i - 1;
		endfor;
		tree[x]key[i+1] := k;
		tree[x]n := tree[x]n + 1;
	else:
		forever:
			exitif i < 1;
			exitif k >= tree[x]key[i];
			i := i - 1;
		endfor;
		i := i + 1;
		if tree[tree[x]child[i]]n = (2 * tree.t - 1):
			btree_split_child(tree)(x, i);
			if (k > tree[x]key[i]):
				i := i + 1;
			fi;
		fi;
		btree_insert_nonfull(tree)(tree[x]child[i], k);
	fi;
enddef;

vardef btree_insert(suffix tree)(expr k) :=
	save r;
	numeric r;
	r := tree.root;
	%message "insert : root is " & decimal(r) & " and contain " & decimal(tree[r]n);
	if tree[r]n <> (2 * tree.t - 1):
		%message "    r is not full";
		btree_insert_nonfull(tree)(r, k);
	else:
		save s;
		numeric s;
		s := alloc_node(tree.free_list);
		tree.root := s;
		tree.height := tree.height + 1;
		tree[s]leaf := false;
		tree[s]n := 0;
		tree[s]child[1] := r;
		%message "    root " & decimal(r) & " is full and changed to " & decimal(s);
		btree_split_child(tree)(s, 1);
		btree_insert_nonfull(tree)(s, k);
	fi;
enddef;

vardef btree_merge(suffix tree)(expr idx, ith) :=
	save preidx, postidx, idxn;
	numeric preidx, postidx, idxn;
	save i,j;
	numeric i,j;
	i := ith;
	preidx := tree[idx]child[i];
	postidx := tree[idx]child[i + 1];
	idxn := tree[idx]n;

	save keyn;
	numeric keyn;
	keyn := tree[preidx]n;

	% merge
	keyn := keyn + 1;
	tree[preidx]n := keyn;
	tree[preidx]key[keyn] := tree[idx]key[i];
	for j := 1 upto tree[postidx]n:
		keyn := keyn + 1;
		tree[preidx]n := keyn;
		tree[preidx]key[keyn] := tree[postidx]key[j];
		if not tree[preidx]leaf:
			tree[preidx]child[keyn] := tree[postidx]child[j];
		fi;
	endfor;
	if not tree[preidx]leaf:
		tree[preidx]child[keyn + 1] := tree[postidx]child[ tree[postidx]n + 1 ];
	fi;

	message "preidx is " & decimal(preidx);
	for j := 1 upto tree[preidx]n:
		message " " & char(tree[preidx]key[j]);
	endfor;
	% decrease self
	for j := i upto (idxn - 1):
		tree[idx]key[j] := tree[idx]key[j+1];
		tree[idx]child[j+1] := tree[idx]child[j+2];
	endfor;
	tree[idx]n := idxn - 1;

	free_node(tree.free_list)(postidx);

	% check null node
	if tree[idx]n = 0:
		if tree.root = idx:
			tree.root := preidx;
		else:
			errmessage "the delete algorithm can't ensure t key at least";
		fi;
	fi;
enddef;

vardef btree_counter_clockwise_rotate(suffix tree)(expr idx, ith) :=
	save i, j;
	numeric i,j;
	i := ith;

	save ret;
	boolean ret;
	ret := false;

	if (i <= idxn):
		save rightbrotheridx;
		numeric rightbrotheridx;
		rightbrotheridx := tree[idx]child[i + 1];
		if (tree[rightbrotheridx]n >= tree.t):
			save childidx, childidxn;
			numeric childidx, childidxn;
			childidx := tree[idx]child[i];
			childidxn := tree[childidx]n;

			childidxn := childidxn + 1;
			tree[childidx]n := childidxn;
			tree[childidx]key[childidxn] := tree[idx]key[i];

			tree[idx]key[i] := tree[rightbrotheridx]key[1];
			for j := 1 upto (tree[rightbrotheridx]n - 1):
				tree[rightbrotheridx]key[j] := tree[rightbrotheridx]key[j + 1];
			endfor;
			if not tree[childidx]leaf:
				tree[childidx]child[childidxn + 1] := tree[rightbrotheridx]child[1];
				for j := 1 upto tree[rightbrotheridx]n:
					tree[rightbrotheridx]child[j] := tree[rightbrotheridx]child[j + 1];
				endfor;
			fi;
			tree[rightbrotheridx]n := tree[rightbrotheridx]n - 1;
			ret := true;
		fi;
	fi;

	ret
enddef;

vardef btree_clockwise_rotate(suffix tree)(expr idx, ith) :=
	save i, j;
	numeric i,j;
	i := ith;

	save ret;
	boolean ret;
	ret := false;

	if (i > 1):
		save leftbrotheridx;
		numeric leftbrotheridx;
		leftbrotheridx := tree[idx]child[i - 1];
		if (tree[leftbrotheridx]n >= tree.t):
			save childidx, childidxn;
			numeric childidx, childidxn;
			childidx := tree[idx]child[i];
			childidxn := tree[childidx]n;

			for j := childidxn downto 1:
				tree[childidx]key[j+1] := tree[childidx]key[j];
			endfor;
			tree[childidx]key[1] := tree[idx]key[i-1];
			childidxn := childidxn + 1;
			tree[childidx]n := childidxn;

			tree[idx]key[i-1] := tree[leftbrotheridx]key[ tree[leftbrotheridx]n ];
			if not tree[childidx]leaf:
				for j := childidxn downto 1:
					tree[childidx]child[j+1] := tree[childidx]child[j];
				endfor;
				tree[childidx]child[1] := tree[leftbrotheridx]child[ tree[leftbrotheridx]n + 1 ];
			fi;
			tree[leftbrotheridx]n := tree[leftbrotheridx]n - 1;

			ret := true;
		fi;
	fi;

	ret
enddef;

vardef btree_subdelete(suffix tree)(expr idx, k) :=
	save i,j;
	numeric i,j;
	save idxn;
	numeric idxn;
	idxn := tree[idx]n;
	i := 1;
	forever:
		exitif i > idxn;
		exitif tree[idx]key[i] >= k;
		i := i + 1;
	endfor;
	if (i <= idxn) and (tree[idx]key[i] = k): % found key
		if tree[idx]leaf:
			message "leaf is " & decimal(idx) & " i(" & decimal(i) & ")" & " idxn(" & decimal(tree[idx]n) & ")";
			for j := 1 upto tree[idx]n:
				message " " & char(tree[idx]key[j]);
			endfor;
			for j := i upto (idxn - 1):
				tree[idx]key[j] := tree[idx]key[j+1];
			endfor;
			tree[idx]n := idxn - 1;
			message "after delete - leaf is " & decimal(idx) & " idxn(" & decimal(tree[idx]n) & ")";
			for j := 1 upto tree[idx]n:
				message " " & char(tree[idx]key[j]);
			endfor;
			message "done";
		else:
			save preidx, postidx;
			numeric preidx, postidx;
			preidx := tree[idx]child[i];
			postidx := tree[idx]child[i+1];
			if (tree[preidx]n >= tree.t):
				save deleteidx, keypie;
				numeric deleteidx, keypie;
				deleteidx := preidx;
				forever:
					exitif tree[deleteidx]leaf;
					deleteidx := tree[deleteidx]child[tree[deleteidx]n + 1];
				endfor;
				keypie := tree[deleteidx]key[ tree[deleteidx]n ];
				tree[idx]key[i] := keypie;
				btree_subdelete(tree)(preidx, keypie);
			elseif (tree[postidx]n >= tree.t):
				save deleteidx, keypie;
				numeric deleteidx, keypie;
				deleteidx := postidx;
				forever:
					exitif tree[deleteidx]leaf;
					deleteidx := tree[deleteidx]child[1];
				endfor;
				keypie := tree[deleteidx]key[1];
				tree[idx]key[i] := keypie;
				btree_subdelete(tree)(postidx, keypie);
			else:
				btree_merge(tree)(idx, i);
				% recursive
				btree_subdelete(tree)(preidx, k);
			fi;
		fi;
	else:	% not found key
		if tree[idx]leaf:
			message "not found key (" & char(k) & ")";
		else:
			save childidx, childidxn;
			numeric childidx, childidxn;
			childidx := tree[idx]child[i];
			childidxn := tree[childidx]n;
			if tree[childidx]n = (tree.t - 1):
				save rotateresult;
				boolean rotateresult;
				% try rightbrother
				rotateresult := btree_counter_clockwise_rotate(tree)(idx, i);
				if not rotateresult:
					% try leftbrother
					rotateresult := btree_clockwise_rotate(tree)(idx, i);
					if not rotateresult:
						if (i > idxn):
							i := i - 1;
						fi;
						btree_merge(tree)(idx, i);
					fi;
				fi;
			fi;
			btree_subdelete(tree)(tree[idx]child[i], k);
		fi;
	fi;
enddef;

vardef btree_delete(suffix tree)(expr k) :=
	btree_subdelete(tree)(tree.root, k);
enddef;

vardef btree_draw_style_uniform := 1 enddef;
vardef btree_draw_style_shrink := 2 enddef;

vardef img_subbtree(suffix tree)(expr idx, lvl, style, keysize, gsize, textcolor, linecolor) :=
image(
	save idxn;
	numeric idxn;
	idxn := tree[idx]n;

	save leftx;
	numeric leftx;
	leftx := -(idxn - 1) * keysize / 2;
	%message "self start:";
	for i := 0 upto (idxn - 1):
		%message "      " & char(tree[idx]key[i + 1]);
		label(char(tree[idx]key[i + 1]), (leftx + i * keysize, 0)) withcolor textcolor;
	endfor;
	%message "self done.";
	if not tree[idx]leaf:
		leftx := leftx - keysize / 2;

		save childpics;
		picture childpics[];	% 0 to idxn
		save righthalfwidth, lefthalfwidth;
		numeric righthalfwidth[];
		numeric lefthalfwidth[];
		for i := 0 upto idxn:
			childpics[i] := img_subbtree(tree)(tree[idx]child[i + 1], lvl-1, style, keysize, gsize, textcolor, linecolor);
			righthalfwidth[i] := xpart(lrcorner(childpics[i]));
			lefthalfwidth[i] := abs(xpart(llcorner(childpics[i])));
		endfor;

		save maxwidth, tmp;
		numeric maxwidth, tmp;
		maxwidth := 0;
		for i := 0 upto (idxn - 1):
			tmp := righthalfwidth[i] + lefthalfwidth[i+1];
			if tmp > maxwidth:
				maxwidth := tmp;
			fi;
		endfor;
		maxwidth := maxwidth + keysize;
		save childx, childy;
		numeric childx, childy;
		if style = btree_draw_style_uniform:
			childx := -maxwidth * idxn / 2;
		else:
			childx := 0;
			for i := 1 upto (idxn - 1):
				childx := childx + lefthalfwidth[i];
				childx := childx + righthalfwidth[i];
			endfor;
			childx := childx + righthalfwidth[0];
			childx := childx + lefthalfwidth[idxn];
			childx := -(childx + keysize * idxn) / 2;
		fi;
		childy := -gsize;
		for i := 0 upto idxn:
			%message " child node at " & decimal(i+1) & " x(" & decimal(childx) & ")";
			draw (leftx, -keysize/2)--(childx, childy + keysize/2) withcolor linecolor;
			draw childpics[i] shifted (childx, childy);
			exitif i = idxn;
			leftx := leftx + keysize;
			if style = btree_draw_style_uniform:
				childx := childx + maxwidth;
			else:
				childx := childx + righthalfwidth[i] + keysize + lefthalfwidth[i+1];
			fi;
		endfor;
	fi;
)
enddef;

vardef img_btree(suffix tree)(expr style, keysize, gsize, textcolor, linecolor) :=
image(
	draw img_subbtree(tree)(tree.root, tree.height, style, keysize, gsize, textcolor, linecolor);
)
enddef;

vardef btree_declare(suffix tree) :=
numeric tree.free_list[];
numeric tree.t;
numeric tree.height;
numeric tree.root;
numeric tree[]n;
numeric tree[]key[];
boolean tree[]leaf;
numeric tree[]child[];
enddef;

vardef btree_insert_seq(suffix tree)(expr k) :=
	save strlen;
	numeric strlen;
	strlen := length k;
	for i := 1 upto strlen:
		btree_insert(tree)(ASCII(substring (i-1, i) of k));
	endfor;
enddef;

vardef btree_delete_seq(suffix tree)(expr k) :=
	save strlen;
	numeric strlen;
	strlen := length k;
	for i := 1 upto strlen:
		btree_delete(tree)(ASCII(substring (i-1, i) of k));
	endfor;
enddef;

vardef btree_build(suffix tree)(expr max_nodes, mindegree, k) :=
	btree_declare(tree);
	btree_create(tree)(max_nodes, mindegree);
	%message "create done";
	btree_insert_seq(tree)(k);
enddef;
