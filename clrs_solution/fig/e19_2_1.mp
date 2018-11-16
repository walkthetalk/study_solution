input fib_heap;

% build fib heap
heap_declare(fib_heap);
heap_init(fib_heap)(20);

numeric nodes[];
nodes[ 7] := heap_new(fib_heap)( 7, false);
nodes[18] := heap_new(fib_heap)(18, true);
nodes[38] := heap_new(fib_heap)(38, false);
nodes[24] := heap_new(fib_heap)(24, false);
nodes[17] := heap_new(fib_heap)(17, false);
nodes[23] := heap_new(fib_heap)(23, false);
nodes[21] := heap_new(fib_heap)(21, false);
nodes[39] := heap_new(fib_heap)(39, true);
nodes[41] := heap_new(fib_heap)(41, false);
nodes[26] := heap_new(fib_heap)(26, true);
nodes[46] := heap_new(fib_heap)(46, false);
nodes[30] := heap_new(fib_heap)(30, false);
nodes[52] := heap_new(fib_heap)(52, false);
nodes[35] := heap_new(fib_heap)(35, false);

heap_add_root(fib_heap)(nodes[7]);
heap_add_child(fib_heap)(nodes[7], nodes[24]);
heap_add_child(fib_heap)(nodes[7], nodes[17]);
heap_add_child(fib_heap)(nodes[7], nodes[23]);
heap_add_child(fib_heap)(nodes[24], nodes[26]);
heap_add_child(fib_heap)(nodes[24], nodes[46]);
heap_add_child(fib_heap)(nodes[17], nodes[30]);
heap_add_child(fib_heap)(nodes[26], nodes[35]);
heap_add_brother(fib_heap)(nodes[7], nodes[18]);
heap_add_child(fib_heap)(nodes[18], nodes[21]);
heap_add_child(fib_heap)(nodes[21], nodes[52]);
heap_add_child(fib_heap)(nodes[18], nodes[39]);
heap_add_brother(fib_heap)(nodes[18], nodes[38]);
heap_add_child(fib_heap)(nodes[38], nodes[41]);

beginfig(1);
draw img_fib_heap(fib_heap)(fullcircle scaled 0.5cm, 1.0cm);
%message "-----------heap.n is " & decimal(fib_heap.n);
endfig;

beginfig(2);
fib_heap_extract_min(fib_heap);
%message "-----------heap.n is " & decimal(fib_heap.n);
draw img_fib_heap(fib_heap)(fullcircle scaled 0.5cm, 1.0cm);
endfig;

end;
