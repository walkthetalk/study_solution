input clrs_graph;

%% global data
declare_graph(G, true, true, .5cm, fullcircle scaled .5cm);

G_add_V(G)
	("a", (0,0.73))
	("b", (-1,-1))
	("c", (1,-1));
G_add_E(G)
	("ab")
	("bc");
G_add_curveE(G)
	("ac", 30,-30)
	("ca", 30,-30);

beginfig(1);
draw graph_img(G);
endfig;

end;
