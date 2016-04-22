input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1.5cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) "a" Gposition (0,0);
G_auto_V(G) "b" Gposition (1,0);
G_auto_V(G) "c" Gposition (2,0);
G_auto_V(G) "d" Gposition (0,-1);
G_auto_V(G) "e" Gposition (1,-1);
G_auto_V(G) "f" Gposition (2,-1);

G_auto_E(G) "ab" Gext.edge_weight (0.5, 90, 1);
G_auto_E(G) "bc" Gext.edge_weight (0.5, 90, 1);
G_auto_E(G) "ad" Gext.edge_weight (0.5, 225, 3);
G_auto_E(G) "be" Gext.edge_weight (0.5, 225, 1);
G_auto_E(G) "ef" Gext.edge_weight (0.5, 90, 5);
G_auto_E(G) "cf" Gext.edge_weight (0.5, 315, 4);
G_auto_E(G) "ce" Gext.edge_weight (0.5, 90, 5);

beginfig(1);
draw graph_img(G);
draw ((-0.5,-0.5)--(2.5,-0.5)) scaled 1.5cm dashed evenly;
endfig;

end;
