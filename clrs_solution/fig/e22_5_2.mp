input clrs_graph;
input clrs_graph_extension;
input clrs_graph_BDSEARCH;

%% global data
declare_graph(G, true, true, 1cm, fullcircle scaled .5cm);
declare_graph_DF(G);

G_add_V(G)
	("q", (0,0))
	("r", (3,0))
	("s", (-1.5,-1))
	("t", (1,-1))
	("u", (4,-1))
	("v", (-2,-1.8))
	("w", (-1,-1.8))
	("x", (1,-2))
	("y", (2,-2))
	("z", (1,-3));

G_add_E(G)
	("qs")
	("qw")
	("ws")
	("sv")
	("vw")
	("qt")
	("tx")
	("xz")
	("ty")
	("ru")
	("ry")
	("uy");
G_add_curveE(G)
	("yq", -30, 30)
	("zx", -45, 45);

beginfig(1);
G_set_V.df(G)
	("q",  90,  1,16)
	("r",  90, 17,20)
	("s", 135,  2, 7)
	("t", 180,  8,15)
	("u",  45, 18,19)
	("v", 135,  3, 6)
	("w", 270,  4, 5)
	("x", 180,  9,12)
	("y", 315, 13,14)
	("z", 180, 10,11);

draw graph_img(G);
endfig;

beginfig(2);
G_set_V.df(G)
	("q",  90,  5,10)
	("r",  90,  1, 2)
	("s", 135, 15,20)
	("t", 180,  7, 8)
	("u",  45,  3, 4)
	("v", 135, 17,18)
	("w", 270, 16,19)
	("x", 180, 11,14)
	("y", 315,  6, 9)
	("z", 180, 12,13);

G_set_E_color(G)(red)
	("ws")("sv")("vw");
G_set_E_color(G)(blue)
	("qt")("ty")("yq");
G_set_E_color(G)(green)
	("zx")("xz");

draw graph_img(G);
endfig;

end;
