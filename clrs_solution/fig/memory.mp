
% freelist[0] store list head
vardef init_freelist(suffix freelist)(expr max_nodes) :=
	numeric i;
	i := 0;
	forever:
		exitif i >= max_nodes;
		freelist[i] := i + 1;
		i := i + 1;
	endfor;
	% 0 means tail
	freelist[max_nodes] := 0;
enddef;
vardef free_node(suffix freelist)(expr idx) :=
	freelist[idx] := freelist[0];
	freelist[0] := idx;
enddef;
vardef alloc_node(suffix freelist) :=
	save ret;
	numeric ret;
	ret := freelist[0];
	%message "alloc node " & decimal(ret);
	freelist[0] := freelist[freelist[0]];
	%message "next alloc node " & decimal(freelist[0]);

	ret
enddef;
