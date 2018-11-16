input clrs_graph;
input clrs_graph_extension;
input clrs_graph_FLOW;

%% global data
declare_graph(G, true, false, 2cm, fullcircle scaled .5cm);
declare_graph_FLOW(G);

G_auto_V(G) 0 Gposition (0,0)   Gid "s";
G_auto_V(G) 1 Gposition (1,0.5);
G_auto_V(G) 2 Gposition (1,-0.5);
G_auto_V(G) 3 Gposition (2,0.5);
G_auto_V(G) 4 Gposition (2,-0.5);
G_auto_V(G) 5 Gposition (3,0)   Gid "t";

G_auto_E(G) (0,1) Gdisp(edge_weight) (0.5,  135) Gdata(edge_weight) (16) Gdata(flow) (11);
G_auto_E(G) (1,3) Gdisp(edge_weight) (0.5,   90) Gdata(edge_weight) (12) Gdata(flow) (12);
G_auto_E(G) (3,5) Gdisp(edge_weight) (0.5,   45) Gdata(edge_weight) (20) Gdata(flow) (15);
G_auto_E(G) (0,2) Gdisp(edge_weight) (0.5, -135) Gdata(edge_weight) (13) Gdata(flow) (8);
G_auto_E(G) (2,1) Gdisp(edge_weight) (0.5,  180) Gdata(edge_weight) ( 4) Gdata(flow) (1);
G_auto_E(G) (3,2) Gdisp(edge_weight) (0.5,  -45) Gdata(edge_weight) ( 9) Gdata(flow) (4);
G_auto_E(G) (2,4) Gdisp(edge_weight) (0.5,  -90) Gdata(edge_weight) (14) Gdata(flow) (11);
G_auto_E(G) (4,3) Gdisp(edge_weight) (0.5,    0) Gdata(edge_weight) ( 7) Gdata(flow) (7);
G_auto_E(G) (4,5) Gdisp(edge_weight) (0.5,  -45) Gdata(edge_weight) ( 4) Gdata(flow) (4);

beginfig(1);
draw graph_img(G);
endfig;

end;
