input clrs_graph;

beginfig(1);
declare_graph(G, true, 2cm, fullcircle scaled .5cm);
graph_add_vertex_n(G)
	(0, (0,0))
	(1, (1,-0.5))
	(2, (1,0.5))
	(3, (2,-0.5))
	(4, (2,0.5));

graph_add_edge_n(G)
	(0,1)
	(0,2)
	(1,3)
	(1,4)
	(2,4)
	(2,3);

graph_assign_edge_pattern_n(G)(evenly)(2,4)(1,3);

draw graph_img(G);
endfig;

end;
