input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);
G_add_V(G)
	("a", (0,0))
	("b", (-0.7,-1))
	("c", (2,-0.6));
G_add_E(G)
	("ab")
	("ac")
	("bc");
G_set_EDGEWEIGHT(G)
	("ab", 0.5, 135, 10)
	("ac", 0.5, 45, 2)
	("bc", 0.5, 270, 2);

beginfig(1);
graph_loop_edge(G, draw_EDGEWEIGHT);
draw graph_img(G);
draw ((1,0.5)--(1,-1.5)) scaled 1cm dashed evenly;
endfig;

end;
