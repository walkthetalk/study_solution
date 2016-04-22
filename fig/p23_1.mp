input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) "a" Gposition (0,0);
G_auto_V(G) "b" Gposition (1,-1);
G_auto_V(G) "c" Gposition (0,-1);
G_auto_V(G) "d" Gposition (1,0);

G_auto_E(G) "ab" Gdisp(edge_weight) (0.5,  90) Gdata(edge_weight) (1);
G_auto_E(G) "bc" Gdisp(edge_weight) (0.5, 270) Gdata(edge_weight) (2);
G_auto_E(G) "ac" Gdisp(edge_weight) (0.5, 180) Gdata(edge_weight) (3);
G_auto_E(G) "bd" Gdisp(edge_weight) (0.5,   0) Gdata(edge_weight) (5);
G_auto_E(G) "ad" Gdisp(edge_weight) (0.5,  90) Gdata(edge_weight) (4);

vardef draw_edge_background_n(suffix G)(expr sidx, eidx)text _remain :=
	draw __graph_edge_path(G)(sidx, eidx) withpen pencircle scaled .25cm withcolor .7white;
	if not __emptytext(_remain) :
		draw_edge_background_n(G)_remain;
	fi;
enddef;

vardef draw_edge_background_a(suffix G)(expr seidx)text _remain :=
	draw_edge_background_n(G)(ASCII substring(0,1)of seidx,
				ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		draw_edge_background_a(G)_remain;
	fi;
enddef;

beginfig(1);
draw_edge_background_a(G)("ad")("ab")("bc");
draw graph_img(G);
endfig;

beginfig(2);
draw_edge_background_a(G)("ad")("ab")("ac");
draw graph_img(G);
endfig;

beginfig(3);
draw_edge_background_a(G)("ab")("bd")("bc");
draw graph_img(G);
endfig;

end;
