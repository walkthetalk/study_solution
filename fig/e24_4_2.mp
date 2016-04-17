input TEX;

save node, edge;
numeric node[]adj;	% store the first adj id
numeric edge[][]next; % store next adj
numeric edge[][]weight;

save nodeidx_min, nodeidx_max;
numeric nodeidx_min;
numeric nodeidx_max;

% for display
save gsize, node_frame;
numeric gsize;
pair node[]pos;
string node[]lbl_dir;
numeric edge[][]curve_dist;
numeric edge[][]lbl_arc;
string edge[][]lbl_dir;	% must use suffix of label
path node_frame;

vardef graph_edge(expr snode, enode, weight_v) :=
edge[snode][enode]weight := weight_v;
if unknown node[snode]adj:
	node[snode]adj := enode;
else:
	save tmp;
	numeric tmp;
	tmp := node[snode]adj;
	node[snode]adj := enode;
	edge[snode][enode]next := tmp;
fi;
enddef;

vardef graph_disp_node(expr snode, position, lbl_dir_v) :=
node[snode]pos := position * gsize;
node[snode]lbl_dir := lbl_dir_v;
enddef;

vardef graph_disp_edge(expr snode, enode, curve_dist_v, lbl_arc_v, lbl_dir_v) :=
edge[snode][enode]curve_dist := curve_dist_v;
edge[snode][enode]lbl_arc := lbl_arc_v;
edge[snode][enode]lbl_dir := lbl_dir_v;
enddef;

vardef graph_link_path(expr snode, enode) :=
	save spos, epos, mpos;
	pair spos, epos, mpos;
	spos := node[snode]pos;
	epos := node[enode]pos;
	mpos := (spos + epos) / 2;
	save oridir;
	pair oridir;
	oridir := unitvector direction 0.5 of (spos--epos);
	if known (edge[snode][enode]curve_dist):
		save newdir;
		pair newdir;
		if edge[snode][enode]curve_dist < 0:
			newdir := oridir rotated 90;
		else:
			newdir := oridir rotated -90;
		fi;
		newdir := newdir * abs(edge[snode][enode]curve_dist) * gsize;
		mpos := mpos + newdir;
	fi;
	save arrowpath;
	path arrowpath;
	arrowpath := spos..mpos..epos;

	arrowpath
enddef;

vardef graph_edge_path(expr snode, enode) :=
	save spos, epos;
	pair spos, epos;
	spos := node[snode]pos;
	epos := node[enode]pos;
	save arrowpath;
	path arrowpath;
	arrowpath := graph_link_path(snode, enode) cutbefore (node_frame shifted spos) cutafter (node_frame shifted epos);

	arrowpath
enddef;

vardef graph_simple_line(expr snode, enode) text line_modifier:=
save arrowpath;
path arrowpath;
arrowpath := graph_edge_path(snode, enode);
drawarrow arrowpath line_modifier;

if known edge[snode][enode]weight:
	save lbl_arc_v;
	numeric lbl_arc_v;
	if known edge[snode][enode]lbl_arc:
		lbl_arc_v := edge[snode][enode]lbl_arc * 2;
	else:
		lbl_arc_v := 1;
	fi;
	label.scantokens(edge[snode][enode]lbl_dir)
	(decimal(edge[snode][enode]weight), point lbl_arc_v of arrowpath);
fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% bellman-ford algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numeric node[]dist;
numeric node[]pi;
boolean node[]accessed;

vardef INITIALIZE_SINGLE_SOURCE(expr snode) :=
	save nodeid;
	numeric nodeid;
	for nodeid := nodeidx_min upto nodeidx_max:
		node[nodeid]dist := infinity;
		node[nodeid]pi := infinity;
		node[nodeid]accessed := false;
	endfor;
	node[snode]dist := 0;
enddef;

vardef SMP_RELAX(expr unode, vnode) :=
	if (node[unode]dist <> infinity) and (node[vnode]dist > (node[unode]dist + edge[unode][vnode]weight)):
		node[vnode]dist := node[unode]dist + edge[unode][vnode]weight;
		node[vnode]pi := unode;
	fi;
enddef;

vardef BELLMAN_FORD_NODE(expr snode) :=
image(
	save fillcolor, valcolor;
	color fillcolor, valcolor;
	if node[snode]accessed:
		fillcolor := black;
		valcolor := white;
	else:
		fillcolor := .8 white;
		valcolor := black;
	fi;
	draw node_frame shifted node[snode]pos;
	fill node_frame shifted node[snode]pos withcolor fillcolor;
	save lbl;
	string lbl;
	if node[snode]dist = infinity:
		lbl := "\infty";
	else:
		lbl := decimal(node[snode]dist);
	fi;
	label(TEX("$" & lbl & "$"), node[snode]pos) withcolor valcolor;
	save lbl_rel_dir, lbl_dir_str;
	numeric lbl_rel_dir; string lbl_dir_str;
	lbl_dir_str := node[snode]lbl_dir;
	if lbl_dir_str = "rt":
		lbl_rel_dir := 0;
	elseif lbl_dir_str = "urt":
		lbl_rel_dir := 45;
	elseif lbl_dir_str = "top":
		lbl_rel_dir := 90;
	elseif lbl_dir_str = "ulft":
		lbl_rel_dir := 135;
	elseif lbl_dir_str = "lft":
		lbl_rel_dir := 180;
	elseif lbl_dir_str = "llft":
		lbl_rel_dir := 225;
	elseif lbl_dir_str = "bot":
		lbl_rel_dir := 270;
	elseif lbl_dir_str = "rlft":
		lbl_rel_dir := 315;
	else:
		errmessage "lbl_dir_str not known";
	fi;
	label.scantokens(node[snode]lbl_dir)(TEX("$v_{" & decimal(snode) & "}$"),
		node_frame intersectionpoint ((0,0)--((dir lbl_rel_dir) * gsize))) shifted node[snode]pos;
)
enddef;

vardef BELLMAN_FORD_IMAGE :=
image(
save nodeid;
numeric nodeid;
for nodeid := nodeidx_min upto nodeidx_max:
	if node[nodeid]pi <> infinity:
		draw graph_link_path(node[nodeid]pi, nodeid) withcolor .8 white withpen pencircle scaled 5;
	fi;
endfor;

for nodeid := nodeidx_min upto nodeidx_max:
	if known (node[nodeid]adj):
		save nextid;
		numeric nextid;
		nextid := node[nodeid]adj;
		forever:
			graph_simple_line(nodeid, nextid);
			exitif unknown edge[nodeid][nextid]next;
			nextid := edge[nodeid][nextid]next;
		endfor;
	fi;
endfor;
for nodeid := nodeidx_min upto nodeidx_max:
	draw BELLMAN_FORD_NODE(nodeid);
endfor;
)
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% graph data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef ADD_GRAPH_NODE(expr idx, position, lbl_dir_v) :=
graph_disp_node(idx, position, lbl_dir_v);
enddef;

vardef ADD_GRAPH_EDGE(expr sidx, eidx, weight_v, curve_dist_v, lbl_pos_v, lbl_dir_v) :=
graph_edge(sidx, eidx, weight_v);
graph_disp_edge(sidx, eidx, curve_dist_v, lbl_pos_v, lbl_dir_v);
enddef;

% node data
nodeidx_min := 0;
nodeidx_max := 5;

gsize := 1.5cm;

ADD_GRAPH_NODE(0, (0,0), "lft");
ADD_GRAPH_NODE(1, (1,0), "top");
ADD_GRAPH_NODE(2, (2,0), "top");
ADD_GRAPH_NODE(3, (3,0), "top");
ADD_GRAPH_NODE(4, (2,-1), "rt");
ADD_GRAPH_NODE(5, (2,-2), "bot");

ADD_GRAPH_EDGE(0, 1, 0,  0, 0.5, "top");
ADD_GRAPH_EDGE(0, 2, 0, -0.5, 0.6, "urt");
ADD_GRAPH_EDGE(0, 3, 0, -1, 0.8, "urt");
ADD_GRAPH_EDGE(0, 4, 0, 0.5, 0.2, "rt");
ADD_GRAPH_EDGE(0, 5, 0, 0.8, 0.8, "bot");

ADD_GRAPH_EDGE(2, 1, 4, 0, 0.5, "top");
ADD_GRAPH_EDGE(5, 1, 5, -0.4, 0.8, "lft");
ADD_GRAPH_EDGE(4, 2, -6, 0, 0.8, "rt");
ADD_GRAPH_EDGE(2, 3, 1, 0, 0.5, "top");
ADD_GRAPH_EDGE(1, 4, 3, 0, 0.5, "urt");
ADD_GRAPH_EDGE(3, 4, 5, 0, 0.5, "rt");
ADD_GRAPH_EDGE(5, 4, 10, 0.1, 0.5, "rt");
ADD_GRAPH_EDGE(3, 5, -4, -0.4, 0.8, "rt");
ADD_GRAPH_EDGE(4, 5, -8, 0.1, 0.5, "lft");

node_frame := fullcircle scaled .5cm;

%%%%%
save figidx;
numeric figidx;
figidx := 1;

vardef output_bellman_ford_image :=
beginfig(figidx);
draw BELLMAN_FORD_IMAGE;
endfig;
figidx := figidx + 1;
enddef;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef ALGO_BELLMAN_FORD(expr snode) :=
INITIALIZE_SINGLE_SOURCE(snode);
output_bellman_ford_image;

for i := 1 upto (nodeidx_max - nodeidx_min + 1):
	save nodeid;
	numeric nodeid;
	for nodeid := nodeidx_min upto nodeidx_max:
		if known (node[nodeid]adj):
			save nextid;
			numeric nextid;
			nextid := node[nodeid]adj;
			forever:
				SMP_RELAX(nodeid, nextid);
				exitif unknown edge[nodeid][nextid]next;
				nextid := edge[nodeid][nextid]next;
			endfor;
		fi;
		node[nodeid]accessed := true;
	endfor;
	output_bellman_ford_image;
endfor;

save ret;
boolean ret;
ret := true;

save nodeid;
numeric nodeid;
for nodeid := nodeidx_min upto nodeidx_max:
	if known (node[nodeid]adj):
		save nextid;
		numeric nextid;
		nextid := node[nodeid]adj;
		forever:
			if node[nextid]dist > node[nodeid]dist + edge[nodeid][nextid]weight:
				ret := false;
			fi;
			exitif not ret;
			exitif unknown edge[nodeid][nextid]next;
			nextid := edge[nodeid][nextid]next;
		endfor;
	fi;
	exitif not ret;
endfor;

if not ret:
	message "bellman_ford start from  " & decimal(snode) & " return: false";
fi;
enddef;

ALGO_BELLMAN_FORD(0);

end;
