input clrs_graph;

vardef graph_simple_line@#(expr snode, enode, lbl) :=
save spos, epos, mpos;
pair spos, epos, mpos;
spos := nodes[ASCII(snode)];
epos := nodes[ASCII(enode)];
mpos := (spos + epos) / 2;
draw (spos--epos) cutbefore (frame shifted spos) cutafter (frame shifted epos);
label@#(lbl, mpos);
enddef;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("a")] := (0,0);
nodes[ASCII("b")] := (1,0);
nodes[ASCII("c")] := (2,0);
nodes[ASCII("d")] := (0,-1);
nodes[ASCII("e")] := (1,-1);
nodes[ASCII("f")] := (2,-1);
for i := ASCII("a") upto ASCII("f"):
	nodes[i] := nodes[i] * 1.5cm;
endfor;

beginfig(1);
graph_simple_line.top("a","b", "1");
graph_simple_line.top("b","c", "1");
graph_simple_line.llft("a","d", "3");
graph_simple_line.llft("b","e", "1");
graph_simple_line.top("e","f", "5");
graph_simple_line.lrt("c","f", "4");
graph_simple_line.top("c","e", "5");

draw ((-0.5,-0.5)--(2.5,-0.5)) scaled 1.5cm dashed evenly;

for i := ASCII("a") upto ASCII("f"):
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
endfig;

end;
