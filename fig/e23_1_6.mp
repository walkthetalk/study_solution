input clrs_graph;

%% global data
declare_graph(G, false, 1.5cm, fullcircle scaled .5cm);
graph_add_vertex_a(G)
	("a", (0,0))
	("b", (-0.5,0.8))
	("c", (0.5,0.8));
graph_add_edge_with_weight_a(G)
	("ab", 0.5, 225, 1)
	("ac", 0.5, 315, 1);

beginfig(1);
draw graph_img(G);
draw ((-1,0.4)--(1,0.4)) scaled 1.5cm dashed evenly;
endfig;

end;
