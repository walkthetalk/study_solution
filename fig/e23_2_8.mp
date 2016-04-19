input clrs_graph;

%% global data
declare_graph(G, false, 1cm, fullcircle scaled .5cm);
graph_add_vertex_a(G)
	("a", (0,0))
	("b", (-0.7,-1))
	("c", (2,-0.6));
graph_add_edge_with_weight_a(G)
	("ab", 0.5, 135, 10)
	("ac", 0.5, 45, 2)
	("bc", 0.5, 270, 2);

beginfig(1);
draw graph_img(G);
draw ((1,0.5)--(1,-1.5)) scaled 1cm dashed evenly;
endfig;

end;
