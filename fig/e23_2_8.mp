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
nodes[ASCII("b")] := (-0.7,-1);
nodes[ASCII("c")] := (2,-0.6);
for i := ASCII("a") upto ASCII("c"):
	nodes[i] := nodes[i] * 1cm;
endfor;

beginfig(1);
graph_simple_line.ulft("a","b", "10");
graph_simple_line.urt("a","c", "2");
graph_simple_line.llft("b","c", "2");
draw ((1,0.5)--(1,-1.5)) scaled 1cm dashed evenly;

for i := ASCII("a") upto ASCII("c"):
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
endfig;

end;
