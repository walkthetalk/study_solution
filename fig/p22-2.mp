input clrs_graph;

vardef outer_frame(suffix nodes)(expr frame, lbls) :=
image(
save len;
numeric len;
len := length(lbls);

save dm;
numeric dm;
dm := xpart(lrcorner(image(draw frame;)) - llcorner(image(draw frame;))) / 2;

save p;
path p;
p := nodes[ASCII(substring(0,1) of lbls)];
for i := 1 upto (len - 1):
	p := p -- nodes[ASCII(substring(i,i+1) of lbls)];
endfor;
p := p -- cycle;

fill p withpen (pencircle scaled dm) withcolor .7white;
)
enddef;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("a")] := (0,0);
nodes[ASCII("b")] := (1,1);
nodes[ASCII("c")] := (1,-1);
nodes[ASCII("d")] := (2,0);
nodes[ASCII("e")] := (4,0);
nodes[ASCII("f")] := (3,1);
nodes[ASCII("g")] := (4,1);
nodes[ASCII("h")] := (3,-1);
nodes[ASCII("i")] := (4,-1);
nodes[ASCII("j")] := (3,-2);
nodes[ASCII("k")] := (5,0);
nodes[ASCII("l")] := (6,1);
nodes[ASCII("m")] := (6,-1);
nodes[ASCII("n")] := (7,0);
nodes[ASCII("o")] := (9,0);
nodes[ASCII("p")] := (10,1);
nodes[ASCII("q")] := (10,-1);
nodes[ASCII("r")] := (11,0);
nodes[ASCII("s")] := (12,0);
nodes[ASCII("t")] := (9,-2);
nodes[ASCII("u")] := (8,-1);
nodes[ASCII("v")] := (8,-2);
nodes[ASCII("w")] := (11,-2);
for i := ASCII("a") upto ASCII("w"):
	nodes[i] := nodes[i] * 1cm;
endfor;

beginfig(1);

save edges, bridges, artpoints, commonpoints;
string edges, bridges, artpoints, commonpoints;
edges := "abacadbcbdcdfgfegeehhiieklkmlnmnoroqqpqrpsrsuvutvt";
bridges := "dehjeknoqtqw";
artpoints := "deknoqtwh";
commonpoints := "abcfgijlmprswuv";

% outer frame
draw outer_frame(nodes)(frame, "acdb");
draw outer_frame(nodes)(frame, "efg");
draw outer_frame(nodes)(frame, "ehi");
draw outer_frame(nodes)(frame, "klnm");
draw outer_frame(nodes)(frame, "opsq");
draw outer_frame(nodes)(frame, "uvt");

% bridges
for i := 0 step 2 until (length bridges - 1):
	save conn;
	path conn;
	conn := nodes[ASCII(substring(i,i+1)of bridges)]--nodes[ASCII(substring(i+1,i+2)of bridges)];
	draw conn withpen (pencircle scaled .25cm) withcolor .3 white;
	draw conn;
endfor;

% edges
for i := 0 step 2 until (length edges - 1):
	draw nodes[ASCII(substring(i,i+1)of edges)]--nodes[ASCII(substring(i+1,i+2)of edges)];
endfor;

% commonpoints
for i := 0 upto (length commonpoints - 1):
	save pf;
	path pf;
	pf := frame shifted nodes[ASCII(substring(i,i+1)of commonpoints)];
	fill pf withcolor white;
	draw pf;
endfor;

% artpoints
for i := 0 upto (length artpoints - 1):
	save pf;
	path pf;
	pf := frame shifted nodes[ASCII(substring(i,i+1)of artpoints)];
	fill pf withcolor black;
	draw pf;
endfor;

%lbl
label.urt("1", (1,0) * 1cm);
label.urt("2", (3.5,0.5) * 1cm);
label.lrt("3", (3.5,-0.5) * 1cm);
label("4", (6,0) * 1cm);
label.llft("5", (8.5,-1.5) * 1cm);
label.ulft("6", (10,0) * 1cm);

endfig;

end;
