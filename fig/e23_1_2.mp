input clrs_graph;

%% global data
declare_graph(G, false, 1.5cm, fullcircle scaled .5cm);
graph_add_vertex_a(G)
	("a", (0,0))
	("b", (1,0))
	("c", (2,0))
	("d", (0,-1))
	("e", (1,-1))
	("f", (2,-1));

graph_add_edge_with_weight_a(G)
	("ab", 0.5, 90, 1)
	("bc", 0.5, 90, 1)
	("ad", 0.5, 225, 3)
	("be", 0.5, 225, 1)
	("ef", 0.5, 90, 5)
	("cf", 0.5, 315, 4)
	("ce", 0.5, 90, 5);

beginfig(1);
draw graph_img(G);
draw ((-0.5,-0.5)--(2.5,-0.5)) scaled 1.5cm dashed evenly;
endfig;

end;
