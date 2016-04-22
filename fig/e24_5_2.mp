input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, true, true, 2.5cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) "s" Gposition (0,0);
G_auto_V(G) "x" Gposition (0.7,0.5);
G_auto_V(G) "y" Gposition (0.7,-0.5);
G_auto_V(G) "u" Gposition (0.7,0);
G_auto_V(G) "v" Gposition (1.4,0);

G_auto_E(G) "sx" Gdisp(edge_weight) (0.5, 135) Gdata(edge_weight) (1);
G_auto_E(G) "sy" Gdisp(edge_weight) (0.5,-135) Gdata(edge_weight) (1);
G_auto_E(G) "su" Gdisp(edge_weight) (0.5, 90) Gdata(edge_weight) (3);
G_auto_E(G) "ux" Gdisp(edge_weight) (0.5, 0) Gdata(edge_weight) (-2);
G_auto_E(G) "uy" Gdisp(edge_weight) (0.5,0) Gdata(edge_weight) (-2);
G_auto_E(G) "vu" Gdisp(edge_weight) (0.5,90) Gdata(edge_weight) (1);
G_auto_E(G) "xv" Gdisp(edge_weight) (0.5,45) Gdata(edge_weight) (1);
G_auto_E(G) "yv" Gdisp(edge_weight) (0.5,-45) Gdata(edge_weight) (1);

beginfig(1);
draw graph_img(G);
endfig;

end;
