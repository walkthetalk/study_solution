input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1.5cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);
G_add_V(G)
	("a", (0,0))
	("b", (-0.5,0.8))
	("c", (0.5,0.8));
G_add_E(G)
	("ab")
	("ac")
	("bc");
G_set_EDGEWEIGHT(G)
	("ab", 0.5, 225, -1)
	("ac", 0.5, 315, -3)
	("bc", 0.5, 90, -2);

beginfig(1);
graph_loop_edge(G, draw_EDGEWEIGHT);
draw graph_img(G);
endfig;

end;
