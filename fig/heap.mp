input memory;

vardef heap_declare(suffix heap) :=
numeric heap.free_list[];

%NOTE: the 'root' and 'n' should be maintained by user
numeric heap.root;
numeric heap.n;

numeric heap[]key;
numeric heap[]child;
numeric heap[]r;	% right brother
numeric heap[]l;	% left brother
numeric heap[]p;
boolean heap[]mark;
numeric heap[]degree;
enddef;

vardef heap_init(suffix heap)(expr max_nodes) :=
init_freelist(heap.free_list)(max_nodes);
heap.root := 0;	% NIL
heap.n := 0;
enddef;

vardef heap_new(suffix heap)(expr k, flag) :=
save idx;
numeric idx;
idx := alloc_node(heap.free_list);
heap[idx]degree := 0;
heap[idx]child := 0;	% NIL
heap[idx]mark := flag;
heap[idx]key := k;
heap[idx]r := idx;
heap[idx]l := idx;
heap[idx]p := 0;

idx
enddef;

vardef heap_add_root(suffix heap)(expr x) :=
if (heap[x]p <> 0) or (heap[x]child <> 0):
	errmessage "please add single node as root!";
fi;
heap.root := x;
heap.n := heap.n + heap_cnt(heap)(x);
enddef;

vardef heap_add_child(suffix heap)(expr parent, x) :=
if (heap[parent]r = parent) and (heap[parent]p = 0) and (heap.root <> parent):
	errmessage "please use a in-heap parent!";
fi;
if heap[parent]child <> 0:
	heap_add_brother(heap)(heap[heap[parent]child]l, x);
else:
	heap[parent]child := x;
	heap[x]p := parent;
	heap.n := heap.n + heap_cnt(heap)(x);
fi;
heap[parent]degree := heap[parent]degree + 1;

enddef;

vardef heap_add_brother(suffix heap)(expr y, x) :=
if (heap[y]r = y) and (heap[y]p = 0) and (heap.root <> y):
	errmessage "please use a in-heap base brother!";
fi;
save next;
numeric next;
next := heap[y]r;

heap[y]r := x;
heap[x]r := next;
heap[next]l := x;
heap[x]l := y;
heap[x]p := heap[y]p;

heap.n := heap.n + heap_cnt(heap)(x);
enddef;

vardef heap_cnt(suffix heap)(expr x) :=
save ret;
numeric ret;
ret := 1;
if heap[x]child <> 0:
	save head, tail;
	numeric head, tail;
	head := heap[x]child;
	tail := heap[head]l;
	forever:
		ret := ret + heap_cnt(heap)(head);
		exitif head = tail;
		head := heap[head]r;
	endfor;
fi;

ret
enddef;

vardef heap_extract(suffix heap)(expr x) :=
save pre, next, parent;
numeric pre, next, parent;
pre := heap[x]l;
next := heap[x]r;
parent := heap[x]p;

if next <> x:
	heap[pre]r := next;
	heap[next]l := pre;
	if parent <> 0:
		if heap[parent]child = x:
			heap[parent]child := next;
		fi;
	fi;
else:
	if parent <> 0:
		heap[parent]child := 0;	% NIL
	fi;
fi;

heap[x]r := x;
heap[x]l := x;
heap[x]p := 0;	% NIL
heap.n := heap.n - heap_cnt(heap)(x);
enddef;

vardef img_subheap(suffix heap)(expr x, frame, gsize) :=
image(
	draw frame withcolor black;
	fill frame withcolor if heap[x]mark: black else: .9 white fi; ;
	label(decimal(heap[x]key), (0,0)) withcolor if heap[x]mark: white else: black fi; ;
	if heap[x]child <> 0:
		save i, c, cpics, cpicsl, cpicsr, len;
		numeric i, c, len;
		picture cpics[];
		numeric cpicsl[];
		numeric cpicsr[];
		len := 0;
		c := heap[x]child;
		for i := 1 upto heap[x]degree:
			cpics[i] := img_subheap(heap)(c, frame, gsize);
			cpicsl[i] := abs(xpart(llcorner(cpics[i])));
			cpicsr[i] := xpart(lrcorner(cpics[i]));
			c := heap[c]r;
		endfor;
		for i := 2 upto heap[x]degree:
			len := len + cpicsr[i-1] + gsize/2 + cpicsl[i];
		endfor;

		len := - len/2 - cpicsl[1];
		for i := 1 upto heap[x]degree:
			len := len + cpicsl[i];
			draw cpics[i] shifted (len, -gsize);
			save line;
			path line;
			line := (0,0)--(len, -gsize);
			draw (frame intersectionpoint line)--
				((frame shifted (len, -gsize)) intersectionpoint line);
			len := len + cpicsr[i] + gsize/2;
		endfor;
	fi;
)
enddef;

vardef img_heap(suffix heap)(expr frame, gsize) :=
image(
save x;
numeric x;
x := heap.root;

if x <> 0:
	save lastx, lastpic;
	numeric lastx;
	picture lastpic;
	forever:
		save curx, curpic;
		numeric curx;
		picture curpic;
		message "heap[x]key is " & decimal(heap[x]key);
		curpic := img_subheap(heap)(x, frame, gsize);
		if known lastpic:
			message "lastx is " & decimal(lastx);
			curx := lastx + xpart(lrcorner(lastpic)) + gsize/2 + abs(xpart(llcorner(curpic)));
		else:
			curx := 0;
		fi;
		draw curpic shifted (curx, 0);
		if known lastpic:
			save line;
			path line;
			line := (lastx, 0)--(curx, 0);
			draw ((frame shifted (lastx, 0)) intersectionpoint line)--
				((frame shifted (curx, 0)) intersectionpoint line) dashed evenly;
		fi;
		exitif heap[x]r = heap.root;
		x := heap[x]r;

		lastx := curx;
		lastpic := curpic;
	endfor;
fi;
)
enddef;
