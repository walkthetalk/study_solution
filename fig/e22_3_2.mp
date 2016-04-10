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
for i := ASCII("q") upto ASCII("z"):
	draw frame shifted nodes[i];
	label(char(i), nodes[i]);
endfor;
drawarrow graph_line(nodes)(frame, "q", "s");
drawarrow graph_line(nodes)(frame, "q", "w");
drawarrow graph_line(nodes)(frame, "w", "s");
drawarrow graph_line(nodes)(frame, "s", "v");
drawarrow graph_line(nodes)(frame, "v", "w");
drawarrow graph_line(nodes)(frame, "q", "t");
drawarrow graph_line(nodes)(frame, "t", "x");
drawarrow graph_line(nodes)(frame, "x", "z");
drawarrow graph_line(nodes)(frame, "t", "y");
drawarrow graph_line(nodes)(frame, "r", "u");
drawarrow graph_line(nodes)(frame, "r", "y");
drawarrow graph_line(nodes)(frame, "u", "y");
drawarrow graph_curve(nodes)(frame, "y", "q", .5cm);
drawarrow graph_curve(nodes)(frame, "z", "x", .5cm);
endfig;

beginfig(2);
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

save color_TreeEdge, color_BackEdge, color_ForwardEdge;
color color_TreeEdge, color_BackEdge, color_ForwardEdge;
color_TreeEdge := red;
color_BackEdge := black;
color_ForwardEdge := blue;

drawarrow graph_line(nodes)(frame, "q", "s") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "q", "w") withcolor color_ForwardEdge;
drawarrow graph_line(nodes)(frame, "w", "s") withcolor color_BackEdge;
drawarrow graph_line(nodes)(frame, "s", "v") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "v", "w") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "q", "t") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "t", "x") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "x", "z") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "t", "y") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "r", "u") withcolor color_TreeEdge;
drawarrow graph_line(nodes)(frame, "r", "y") dashed evenly;
drawarrow graph_line(nodes)(frame, "u", "y") dashed evenly;
drawarrow graph_curve(nodes)(frame, "y", "q", .5cm) withcolor color_BackEdge;
drawarrow graph_curve(nodes)(frame, "z", "x", .5cm) withcolor color_BackEdge;
endfig;

end;
