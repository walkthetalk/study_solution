input clrs_graph;

vardef dfs_idx(suffix nodes)(expr frame, node, idx, direct) :=
image(
save diameter;
numeric diameter;
diameter := xpart(lrcorner(image(draw frame;))-llcorner(image(draw frame;))) * 0.5;

save lbl;
string lbl;
lbl := decimal(xpart(idx)) & "," & decimal(ypart(idx));
if direct = "top":
	label.top(lbl, (diameter,0) rotated 90 shifted nodes[node]);
elseif direct = "ulft":
	label.ulft(lbl, (diameter,0) rotated 135 shifted nodes[node]);
elseif direct = "lft":
	label.lft(lbl, (diameter,0) rotated 180 shifted nodes[node]);
elseif direct = "llft":
	label.llft(lbl, (diameter,0) rotated 225 shifted nodes[node]);
elseif direct = "bot":
	label.bot(lbl, (diameter,0) rotated 270 shifted nodes[node]);
elseif direct = "lrt":
	label.lrt(lbl, (diameter,0) rotated 315 shifted nodes[node]);
elseif direct = "rt":
	label.rt(lbl, (diameter,0) rotated 360 shifted nodes[node]);
elseif direct = "urt":
	label.urt(lbl, (diameter,0) rotated 45 shifted nodes[node]);
fi;
)
enddef;

%% global data
save frame;
path frame;
frame := fullcircle scaled .5cm;

save nodes;
pair nodes[];
nodes[ASCII("q")] := (0,0);
nodes[ASCII("r")] := (3,0);
nodes[ASCII("s")] := (-1.5,-1);
nodes[ASCII("t")] := (1,-1);
nodes[ASCII("u")] := (4,-1);
nodes[ASCII("v")] := (-2,-1.8);
nodes[ASCII("w")] := (-1,-1.8);
nodes[ASCII("x")] := (1,-2);
nodes[ASCII("y")] := (2,-2);
nodes[ASCII("z")] := (1,-3);
for i := ASCII("q") upto ASCII("z"):
	nodes[i] := nodes[i] * 1cm;
endfor;

beginfig(1);
save nodesid, nodespos;
pair nodesid[];
string  nodespos[];
nodesid[ASCII("q")] := (1,16);	nodespos[ASCII("q")] := "top";
nodesid[ASCII("r")] := (17,20);	nodespos[ASCII("r")] := "top";
nodesid[ASCII("s")] := (2,7);	nodespos[ASCII("s")] := "ulft";
nodesid[ASCII("t")] := (8,15);	nodespos[ASCII("t")] := "lft";
nodesid[ASCII("u")] := (18,19);	nodespos[ASCII("u")] := "urt";
nodesid[ASCII("v")] := (3,6);	nodespos[ASCII("v")] := "ulft";
nodesid[ASCII("w")] := (4,5);	nodespos[ASCII("w")] := "rt";
nodesid[ASCII("x")] := (9,12);	nodespos[ASCII("x")] := "lft";
nodesid[ASCII("y")] := (13,14);	nodespos[ASCII("y")] := "lrt";
nodesid[ASCII("z")] := (10,11);	nodespos[ASCII("z")] := "lft";

for i := ASCII("q") upto ASCII("z"):
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
	draw dfs_idx(nodes)(frame, i, nodesid[i], nodespos[i]);
endfor;

drawarrow graph_line(nodes)(frame, "s", "q");
drawarrow graph_line(nodes)(frame, "w", "q");
drawarrow graph_line(nodes)(frame, "s", "w") withcolor red;
drawarrow graph_line(nodes)(frame, "v", "s") withcolor red;
drawarrow graph_line(nodes)(frame, "w", "v") withcolor red;
drawarrow graph_line(nodes)(frame, "t", "q") withcolor blue;
drawarrow graph_line(nodes)(frame, "x", "t");
drawarrow graph_line(nodes)(frame, "z", "x") withcolor green;
drawarrow graph_line(nodes)(frame, "y", "t") withcolor blue;
drawarrow graph_line(nodes)(frame, "u", "r");
drawarrow graph_line(nodes)(frame, "y", "r");
drawarrow graph_line(nodes)(frame, "y", "u");
drawarrow graph_curve(nodes)(frame, "q", "y", .5cm) withcolor blue;
drawarrow graph_curve(nodes)(frame, "x", "z", .5cm) withcolor green;
endfig;

end;
