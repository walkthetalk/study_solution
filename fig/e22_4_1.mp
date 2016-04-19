input clrs_graph;

%% global data
declare_graph(G, true, 1cm, fullcircle scaled .5cm);
graph_add_vertex_a(G)
	("m", (0,0))
	("n", (2,0))
	("o", (4,0))
	("p", (6,0))
	("q", (1,-1))
	("r", (3,-1))
	("s", (5,-1))
	("t", (0,-2))
	("u", (2,-2))
	("v", (4,-2))
	("w", (6,-2))
	("x", (1,-3))
	("y", (3,-3))
	("z", (5,-3));
graph_add_edge_a(G)
	("mx")
	("mq")
	("mr")
	("nq")
	("nu")
	("no")
	("or")
	("ov")
	("os")
	("po")
	("ps")
	("pz")
	("qt")
	("ru")
	("ry")
	("sr")
	("ut")
	("vw")
	("vx")
	("wz")
	("yv");

beginfig(1);
draw graph_img(G);
endfig;

end;
