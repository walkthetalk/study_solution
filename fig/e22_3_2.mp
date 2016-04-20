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
draw graph_img(G);
endfig;

beginfig(2);
G_set_V.df(G)
	("q",  90,  1,16)
	("r",  90, 17,20)
	("s", 135,  2, 7)
	("t", 180,  8,15)
	("u",  45, 18,19)
	("v", 135,  3, 6)
	("w",   0,  4, 5)
	("x", 180,  9,12)
	("y", 315, 13,14)
	("z", 180, 10,11);

G_set_E_color(G)(red)
	("qs")
	("sv")
	("vw")
	("qt")
	("tx")
	("xz")
	("ty")
	("ru");
G_set_E_color(G)(blue)("qw");
G_set_E_color(G)(black)("ws")("yq")("zx");
G_set_E_pattern(G)(evenly)("ry")("uy");

draw graph_img(G);
endfig;

end;
