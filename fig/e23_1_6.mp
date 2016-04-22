input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1.5cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) "a" Gposition (0,0);
G_auto_V(G) "b" Gposition (-0.5,0.8);
G_auto_V(G) "c" Gposition (0.5,0.8);

G_auto_E(G) "ab" Gext.edge_weight (0.5, 225, 1);
G_auto_E(G) "ac" Gext.edge_weight (0.5, 315, 1);

beginfig(1);
draw graph_img(G);
draw ((-1,0.4)--(1,0.4)) scaled 1.5cm dashed evenly;
endfig;

end;
