input clrs_graph;

vardef dfs_node(suffix nodes)(expr frame, idx) :=
image(
draw frame shifted nodes[ASCII(idx)];
label(idx, nodes[ASCII(idx)]);
)
enddef;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("s")] := (0,0) * 1cm;
nodes[ASCII("u")] := (-0.5,-0.8) * 1cm;
nodes[ASCII("v")] := (0.5,-0.8) * 1cm;

beginfig(1);
draw dfs_node(nodes)(frame, "s");
draw dfs_node(nodes)(frame, "u");
draw dfs_node(nodes)(frame, "v");
drawarrow graph_curve(nodes)(frame, "s", "u", -0.1cm);
drawarrow graph_curve(nodes)(frame, "u", "s", .1cm);
drawarrow graph_line(nodes)(frame, "s", "v");
endfig;

end;
