input clrs_graph;

%% global data
declare_graph(G, false, 1cm, fullcircle scaled .5cm);

graph_add_vertex_a(G)
	("a", (0,0))
	("b", (1,-1))
	("c", (0,-1))
	("d", (1,0));
graph_add_edge_with_weight_a(G)
	("ab", 0.5, 90, 1)
	("bc", 0.5, 270, 2)
	("ac", 0.5, 180, 3)
	("bd", 0.5, 0, 5)
	("ad", 0.5, 90, 4);

vardef draw_edge_background_n(suffix G)(expr sidx, eidx)text _remain :=
	draw graph_edge_path_n(G)(sidx, eidx) withpen pencircle scaled .25cm withcolor .7white;
	if not __emptytext(_remain) :
		draw_edge_background_n(G)_remain;
	fi;
enddef;

vardef draw_edge_background_a(suffix G)(expr seidx)text _remain :=
	draw_edge_background_n(G)(ASCII substring(0,1)of seidx,
				ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		draw_edge_background_a(G)_remain;
	fi;
enddef;

beginfig(1);
draw_edge_background_a(G)("ad")("ab")("bc");
draw graph_img(G);
endfig;

beginfig(2);
draw_edge_background_a(G)("ad")("ab")("ac");
draw graph_img(G);
endfig;

beginfig(3);
draw_edge_background_a(G)("ab")("bd")("bc");
draw graph_img(G);
endfig;

end;
