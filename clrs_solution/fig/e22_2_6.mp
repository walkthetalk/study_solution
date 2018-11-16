input clrs_graph;

beginfig(1);
declare_graph(G, true, false, 2cm, fullcircle scaled .5cm);
if false:
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

G_set_E_pattern(G)(GEP_dashedvenly)(2,4)(1,3);
else:
	G_auto_V(G) 0 Gposition (0,0);
	G_auto_V(G) 1 Gposition (1,-0.5);
	G_auto_V(G) 2 Gposition (1,0.5);
	G_auto_V(G) 3 Gposition (2,-0.5);
	G_auto_V(G) 4 Gposition (2,0.5);

	G_auto_E(G) (0,1);
	G_auto_E(G) (0,2);
	G_auto_E(G) (1,3) Gpattern GEP_dashedvenly;
	G_auto_E(G) (1,4);
	G_auto_E(G) (2,4) Gpattern GEP_dashedvenly;
	G_auto_E(G) (2,3);
fi;

draw graph_img(G);
endfig;

end;
