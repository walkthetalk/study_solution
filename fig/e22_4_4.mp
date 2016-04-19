input clrs_graph;

%% global data
declare_graph(G, true, .5cm, fullcircle scaled .5cm);

graph_add_vertex_a(G)
	("a", (0,0.73))
	("b", (-1,-1))
	("c", (1,-1));
graph_add_edge_a(G)
	("ab")
	("bc");
graph_add_curve_edge_a(G)
	("ac", 30,-30)
	("ca", 30,-30);

beginfig(1);
draw graph_img(G);
endfig;

end;
