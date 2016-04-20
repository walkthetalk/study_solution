input clrs_graph;

beginfig(1);
declare_graph(G, true, false, 2cm, fullcircle scaled .5cm);
G_add_V(G)
	(0, (0,0))
	(1, (1,-0.5))
	(2, (1,0.5))
	(3, (2,-0.5))
	(4, (2,0.5));

G_add_E(G)
	(0,1)
	(0,2)
	(1,3)
	(1,4)
	(2,4)
	(2,3);

G_set_E_pattern(G)(evenly)(2,4)(1,3);

draw graph_img(G);
endfig;

end;
