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
	("ac");
G_set_E.edge_weight(G)
	("ab", 0.5, 225, 1)
	("ac", 0.5, 315, 1);

beginfig(1);
draw graph_img(G);
draw ((-1,0.4)--(1,0.4)) scaled 1.5cm dashed evenly;
endfig;

end;
