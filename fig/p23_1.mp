input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_add_V(G)
	("a", (0,0))
	("b", (1,-1))
	("c", (0,-1))
	("d", (1,0));
G_add_E(G)
	("ab")
	("bc")
	("ac")
	("bd")
	("ad");
G_set_EDGEWEIGHT(G)
	("ab", 0.5, 90, 1)
	("bc", 0.5, 270, 2)
	("ac", 0.5, 180, 3)
	("bd", 0.5, 0, 5)
	("ad", 0.5, 90, 4);

vardef draw_edge_background_n(suffix G)(expr sidx, eidx)text _remain :=
	draw __graph_edge_path(G)(sidx, eidx) withpen pencircle scaled .25cm withcolor .7white;
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
graph_loop_edge(G, draw_EDGEWEIGHT);
endfig;

beginfig(2);
draw_edge_background_a(G)("ad")("ab")("ac");
draw graph_img(G);
graph_loop_edge(G, draw_EDGEWEIGHT);
endfig;

beginfig(3);
draw_edge_background_a(G)("ab")("bd")("bc");
draw graph_img(G);
graph_loop_edge(G, draw_EDGEWEIGHT);
endfig;

end;
