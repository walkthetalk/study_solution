input clrs_graph;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("m")] := (0,0);
nodes[ASCII("n")] := (2,0);
nodes[ASCII("o")] := (4,0);
nodes[ASCII("p")] := (6,0);
nodes[ASCII("q")] := (1,-1);
nodes[ASCII("r")] := (3,-1);
nodes[ASCII("s")] := (5,-1);
nodes[ASCII("t")] := (0,-2);
nodes[ASCII("u")] := (2,-2);
nodes[ASCII("v")] := (4,-2);
nodes[ASCII("w")] := (6,-2);
nodes[ASCII("x")] := (1,-3);
nodes[ASCII("y")] := (3,-3);
nodes[ASCII("z")] := (5,-3);

beginfig(1);

for i := ASCII("m") upto ASCII("z"):
	nodes[i] := nodes[i] * 1cm;
	draw graph_node(nodes)(frame, char(i));
endfor;

drawarrow graph_line(nodes)(frame, "m", "x");
drawarrow graph_line(nodes)(frame, "m", "q");
drawarrow graph_line(nodes)(frame, "m", "r");
drawarrow graph_line(nodes)(frame, "n", "q");
drawarrow graph_line(nodes)(frame, "n", "u");
drawarrow graph_line(nodes)(frame, "n", "o");
drawarrow graph_line(nodes)(frame, "o", "r");
drawarrow graph_line(nodes)(frame, "o", "v");
drawarrow graph_line(nodes)(frame, "o", "s");
drawarrow graph_line(nodes)(frame, "p", "o");
drawarrow graph_line(nodes)(frame, "p", "s");
drawarrow graph_line(nodes)(frame, "p", "z");
drawarrow graph_line(nodes)(frame, "q", "t");
drawarrow graph_line(nodes)(frame, "r", "u");
drawarrow graph_line(nodes)(frame, "r", "y");
drawarrow graph_line(nodes)(frame, "s", "r");
drawarrow graph_line(nodes)(frame, "u", "t");
drawarrow graph_line(nodes)(frame, "v", "w");
drawarrow graph_line(nodes)(frame, "v", "x");
drawarrow graph_line(nodes)(frame, "w", "z");
drawarrow graph_line(nodes)(frame, "y", "v");
endfig;

end;
