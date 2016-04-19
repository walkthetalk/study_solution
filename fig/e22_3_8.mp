input clrs_graph;

%% global data
declare_graph(G, true, 1cm, fullcircle scaled .5cm);

graph_add_vertex_a(G)
	("s", (0,0))
	("u", (-0.5,-0.8))
	("v", (0.5,-0.8));

beginfig(1);
graph_add_edge_a(G)("sv");
graph_add_curve_edge_a(G)
	("su", 30, -30)
	("us", 30, -30);

draw graph_img(G);
endfig;

end;
