input clrs_graph;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("a")] := (0,0.73);
nodes[ASCII("b")] := (-1,-1);
nodes[ASCII("c")] := (1,-1);

beginfig(1);

for i := ASCII("a") upto ASCII("c"):
	nodes[i] := nodes[i] * .5cm;
	draw graph_node(nodes)(frame, char(i));
endfor;

drawarrow graph_line(nodes)(frame, "a", "b");
drawarrow graph_line(nodes)(frame, "b", "c");
drawarrow graph_curve(nodes)(frame, "a", "c", .1cm);
drawarrow graph_curve(nodes)(frame, "c", "a", -.1cm);
endfig;

end;
