input clrs_graph;

%% global data
declare_graph(G, true, true, 1cm, fullcircle scaled .5cm);

G_add_V(G)
	("s", (0,0))
	("u", (-0.5,-0.8))
	("v", (0.5,-0.8));
G_add_E(G)("sv");
G_add_curveE(G)
	("su", 30, -30)
	("us", 30, -30);

beginfig(1);

draw graph_img(G);
endfig;

end;
