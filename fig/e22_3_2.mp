input clrs_graph;
input clrs_graph_extension;
input clrs_graph_BDSEARCH;

%% global data
declare_graph(G, true, true, 1cm, fullcircle scaled .5cm);
declare_graph_DF(G);

G_auto_V(G) "q" Gposition (0,0);
G_auto_V(G) "r" Gposition (3,0);
G_auto_V(G) "s" Gposition (-1.5,-1);
G_auto_V(G) "t" Gposition (1,-1);
G_auto_V(G) "u" Gposition (4,-1);
G_auto_V(G) "v" Gposition (-2,-1.8);
G_auto_V(G) "w" Gposition (-1,-1.8);
G_auto_V(G) "x" Gposition (1,-2);
G_auto_V(G) "y" Gposition (2,-2);
G_auto_V(G) "z" Gposition (1,-3);

G_auto_E(G) "qs";
G_auto_E(G) "qw";
G_auto_E(G) "ws";
G_auto_E(G) "sv";
G_auto_E(G) "vw";
G_auto_E(G) "qt";
G_auto_E(G) "tx";
G_auto_E(G) "xz";
G_auto_E(G) "ty";
G_auto_E(G) "ru";
G_auto_E(G) "ry";
G_auto_E(G) "uy";
G_auto_E(G) "yq" Gpath (-30,30);
G_auto_E(G) "zx" Gpath (-45,45);

beginfig(1);
draw graph_img(G);
endfig;

beginfig(2);
G_auto_V(G) "q" Gdisp(df) ( 90) Gdata(df) ( 1,16);
G_auto_V(G) "r" Gdisp(df) ( 90) Gdata(df) (17,20);
G_auto_V(G) "s" Gdisp(df) (135) Gdata(df) ( 2, 7);
G_auto_V(G) "t" Gdisp(df) (180) Gdata(df) ( 8,15);
G_auto_V(G) "u" Gdisp(df) ( 45) Gdata(df) (18,19);
G_auto_V(G) "v" Gdisp(df) (135) Gdata(df) ( 3, 6);
G_auto_V(G) "w" Gdisp(df) (  0) Gdata(df) ( 4, 5);
G_auto_V(G) "x" Gdisp(df) (180) Gdata(df) ( 9,12);
G_auto_V(G) "y" Gdisp(df) (315) Gdata(df) (13,14);
G_auto_V(G) "z" Gdisp(df) (180) Gdata(df) (10,11);

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
G_set_E_pattern(G)(GEP_dashedvenly)("ry")("uy");

draw graph_img(G);
endfig;

end;
