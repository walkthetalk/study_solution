
input clrs_graph;

beginfig(1);
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[0] := (0,0);
nodes[1] := (1,-0.5);
nodes[2] := (1,0.5);
nodes[3] := (2,-0.5);
nodes[4] := (2,0.5);

for i := 0 upto 4:
	nodes[i] := nodes[i] * 2cm;
	draw frame shifted nodes[i];
endfor;

drawarrow graph_line_idx(nodes)(frame, 0, 1);
drawarrow graph_line_idx(nodes)(frame, 0, 2);
drawarrow graph_line_idx(nodes)(frame, 1, 3) dashed evenly;
drawarrow graph_line_idx(nodes)(frame, 1, 4);
drawarrow graph_line_idx(nodes)(frame, 2, 4) dashed evenly;
drawarrow graph_line_idx(nodes)(frame, 2, 3);

endfig;

end;
