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
nodes[ASCII("b")] := (-0.5,0.8);
nodes[ASCII("c")] := (0.5,0.8);
for i := ASCII("a") upto ASCII("c"):
	nodes[i] := nodes[i] * 1.5cm;
endfor;

beginfig(1);
graph_simple_line.llft("a","b", "-1");
graph_simple_line.lrt("a","c", "-3");
graph_simple_line.top("b","c", "-2");

for i := ASCII("a") upto ASCII("c"):
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
endfig;

end;
