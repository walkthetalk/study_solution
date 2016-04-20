input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1.5cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);
G_add_V(G)
	("a", (0,0))
	("b", (1,0))
	("c", (2,0))
	("d", (0,-1))
	("e", (1,-1))
	("f", (2,-1));

G_add_E(G)
	("ab")
	("bc")
	("ad")
	("be")
	("ef")
	("cf")
	("ce");

G_set_EDGEWEIGHT(G)
	("ab", 0.5, 90, 1)
	("bc", 0.5, 90, 1)
	("ad", 0.5, 225, 3)
	("be", 0.5, 225, 1)
	("ef", 0.5, 90, 5)
	("cf", 0.5, 315, 4)
	("ce", 0.5, 90, 5);

beginfig(1);
graph_loop_edge(G, draw_EDGEWEIGHT);
draw graph_img(G);
draw ((-0.5,-0.5)--(2.5,-0.5)) scaled 1.5cm dashed evenly;
endfig;

end;
