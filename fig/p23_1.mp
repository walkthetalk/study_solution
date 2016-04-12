input clrs_graph;

vardef graph_simple_line@#(expr snode, enode, lbl) :=
save spos, epos, mpos;
pair spos, epos, mpos;
spos := nodes[ASCII(snode)];
epos := nodes[ASCII(enode)];
mpos := (spos + epos) / 2;
draw (spos--epos);
label@#(lbl, mpos);
enddef;

vardef graph_fat_line@#(expr snode, enode, lbl) :=
save spos, epos, mpos;
pair spos, epos, mpos;
spos := nodes[ASCII(snode)];
epos := nodes[ASCII(enode)];
mpos := (spos + epos) / 2;
draw (spos--epos) withpen pencircle scaled .1cm withcolor .5white;
draw (spos--epos);
label@#(lbl, mpos);
enddef;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("a")] := (0,0);
nodes[ASCII("b")] := (1,-1);
nodes[ASCII("c")] := (0,-1);
nodes[ASCII("d")] := (1,0);
for i := ASCII("a") upto ASCII("d"):
	nodes[i] := nodes[i] * 1cm;
endfor;

beginfig(1);
graph_fat_line.rt("a","b", "1");
graph_fat_line.bot("b","c", "2");
graph_simple_line.lft("a","c", "3");
graph_simple_line.rt("b","d", "5");
graph_fat_line.top("a","d", "4");

for i := ASCII("a") upto ASCII("d"):
	fill frame shifted nodes[i] withcolor white;
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
endfig;

beginfig(2);
graph_fat_line.rt("a","b", "1");
graph_simple_line.bot("b","c", "2");
graph_fat_line.lft("a","c", "3");
graph_simple_line.rt("b","d", "5");
graph_fat_line.top("a","d", "4");

for i := ASCII("a") upto ASCII("d"):
	fill frame shifted nodes[i] withcolor white;
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
endfig;

beginfig(3);
graph_fat_line.rt("a","b", "1");
graph_fat_line.bot("b","c", "2");
graph_simple_line.lft("a","c", "3");
graph_fat_line.rt("b","d", "5");
graph_simple_line.top("a","d", "4");

for i := ASCII("a") upto ASCII("d"):
	fill frame shifted nodes[i] withcolor white;
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
endfig;

end;
