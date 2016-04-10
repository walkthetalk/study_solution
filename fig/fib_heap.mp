input heap;

vardef fib_heap_insert(suffix heap)(expr x) :=
if heap.root = 0:
	heap.root := x;
else:
	save pre;
	numeric pre;
	pre := heap[heap.root]l;
	heap[x]r := heap.root;
	heap[heap.root]l := x;
	heap[x]l := pre;
	heap[pre]r := x;
	if heap[x]key < heap[heap.root]key:
		heap.root := x;
	fi;
fi;

heap.n := heap.n + 1;
enddef;

vardef fib_heap_extract_min(suffix heap) :=
save z;
numeric z;
z := heap.root;
if z <> 0:
	forever:
		exitif heap[z]child = 0;
		save c;
		numeric c;
		c := heap[z]child;
		heap_extract(heap)(c);
		heap_add_brother(heap)(heap[z]l, c);
	endfor;
	if heap[z]r = z:
		heap.root := 0;	% NIL
		heap_extract(heap)(z);
	else:
		heap.root := heap[z]r;
		heap_extract(heap)(z);
		fib_heap_consolidate(heap);
	fi;
fi;
enddef;

vardef fib_heap_consolidate(suffix heap) :=
save A;
numeric A[];

save omega, x, next, tail;
numeric omega, x, next, tail;
omega := heap.root;
tail := heap[omega]l;
forever:
	x := omega;
	next := heap[x]r;
	deg := heap[x]degree;

	forever:
		exitif unknown A[deg];
		exitif A[deg] = 0;
		save y;
		numeric y;
		y := A[deg];
		if heap[x]key > heap[y]key:
			fib_heap_link(heap)(x,y);
			x := y;
		else:
			fib_heap_link(heap)(y,x);
		fi;
		A[deg] := 0;
		deg := deg + 1;
	endfor;
	A[deg] := x;

	exitif omega = tail;
	omega := next;
endfor;

heap.root := x;
%message "++++++++++++after extract min: root is " & decimal(heap[heap.root]key);
tail := heap[x]l;
forever:
	exitif x = tail;
	x := heap[x]r;
%message "++++++++++++compare to : root is " & decimal(heap[heap.root]key) & "  " & decimal(heap[x]key);
	if heap[heap.root]key > heap[x]key:
		heap.root := x;
	fi;
endfor;

enddef;

vardef fib_heap_link(suffix heap)(expr y, x) :=
heap_extract(heap)(y);
heap_add_child(heap)(x, y);
heap[y]mark := false;
enddef;

vardef fib_heap_decrease_key(suffix heap)(expr x, k) :=
if k > heap[x]key:
	errmessage "new key is greater than current key.";
fi;
save y;
numeric y;

heap[x]key := k;
y := heap[x]p;
if y <> 0:
	if heap[x]key < heap[y]key:
		fib_heap_cut(heap)(x, y);
		fib_heap_cascading_cut(heap)(y);
	fi;
fi;
if heap[x]key < heap[heap.root]key:
	heap.root := x;
fi;
enddef;

vardef fib_heap_cut(suffix heap)(expr x, y) :=
heap_extract(heap)(x);
heap_add_brother(heap)(heap[heap.root]l, x);
heap[x]mark := false;
enddef;

vardef fib_heap_cascading_cut(suffix heap)(expr y) :=
save z;
numeric z;
z := heap[y]p;
if z <> 0:
	if heap[y]mark = false:
		heap[y]mark := true;
	else:
		fib_heap_cut(heap)(y, z);
		fib_heap_cascading_cut(heap)(z);
	fi;
fi;
enddef;

vardef img_fib_heap(suffix heap)(expr frame, gsize) :=
image(
draw img_heap(heap)(frame, gsize);
label("H.min", (0, gsize));
save line;
path line;
line := (0,gsize) -- (0,0);
drawarrow (frame shifted (0,gsize) intersectionpoint line)--
	(frame scaled 1.2 intersectionpoint line);
)
enddef;
