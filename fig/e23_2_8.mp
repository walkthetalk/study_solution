input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, false, true, 1cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) "a" Gposition (0,0);
G_auto_V(G) "b" Gposition (-0.7,-1);
G_auto_V(G) "c" Gposition (2,-0.6);

G_auto_E(G) "ab" Gdisp(edge_weight) (0.5, 135) Gdata(edge_weight) (10);
G_auto_E(G) "ac" Gdisp(edge_weight) (0.5,  45) Gdata(edge_weight) (2);
G_auto_E(G) "bc" Gdisp(edge_weight) (0.5, 270) Gdata(edge_weight) (2);

beginfig(1);
draw graph_img(G);
draw ((1,0.5)--(1,-1.5)) scaled 1cm dashed evenly;
endfig;

end;
