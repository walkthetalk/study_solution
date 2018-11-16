input TEX;

save node, edge;
numeric node[]adj;	% store the first adj id
numeric edge[][]next; % store next adj
numeric edge[][]weight;

save nodeslist;
string nodeslist;

% for display
save gsize, node_frame;
numeric gsize;
pair node[]pos;
string node[]lbl_dir;
numeric edge[][]curve_dist;
numeric edge[][]lbl_arc;
string edge[][]lbl_dir;	% must use suffix of label
path node_frame;

vardef graph_adj(expr snode, adjnodes) :=
node[ASCII snode]adj := ASCII substring (0,1) of adjnodes;
for i := 0 upto (length (adjnodes) - 2):
	edge[ASCII snode][ASCII substring (i,i+1) of adjnodes]next := ASCII substring (i+1,i+2) of adjnodes;
endfor;
enddef;

vardef graph_edge(expr senode, weight_v) :=
edge[ASCII substring (0,1) of senode][ASCII substring (1,2) of senode]weight := weight_v;
enddef;

vardef graph_disp_node(expr snode, position, lbl_dir_v) :=
node[ASCII snode]pos := position * gsize;
node[ASCII snode]lbl_dir := lbl_dir_v;
enddef;

vardef graph_disp_edge(expr senode, curve_dist_v, lbl_arc_v, lbl_dir_v) :=
save snode, enode;
numeric snode, enode;
snode := ASCII substring (0,1) of senode;
enode := ASCII substring (1,2) of senode;
edge[snode][enode]curve_dist := curve_dist_v;
edge[snode][enode]lbl_arc := lbl_arc_v;
edge[snode][enode]lbl_dir := lbl_dir_v;
enddef;

vardef graph_link_path(expr senode) :=
	save snode, enode;
	numeric snode, enode;
	snode := ASCII substring (0,1) of senode;
	enode := ASCII substring (1,2) of senode;

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

vardef graph_edge_path(expr senode) :=
	save snode, enode;
	numeric snode, enode;
	snode := ASCII substring (0,1) of senode;
	enode := ASCII substring (1,2) of senode;

	save spos, epos;
	pair spos, epos;
	spos := node[snode]pos;
	epos := node[enode]pos;
	save arrowpath;
	path arrowpath;
	arrowpath := graph_link_path(senode) cutbefore (node_frame shifted spos) cutafter (node_frame shifted epos);

	arrowpath
enddef;

vardef graph_simple_line(expr senode) text line_modifier:=
save snode, enode;
numeric snode, enode;
snode := ASCII substring (0,1) of senode;
enode := ASCII substring (1,2) of senode;

save arrowpath;
path arrowpath;
arrowpath := graph_edge_path(senode);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dijkstra algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numeric node[]dist;
numeric node[]pi;
boolean node[]accessed;
string subst_equal_seq;

vardef INITIALIZE_SINGLE_SOURCE(expr snode) :=
	for i := 0 upto (length nodeslist - 1):
		save nodeid;
		numeric nodeid;
		nodeid := ASCII substring (i,i+1) of nodeslist;
		node[nodeid]dist := infinity;
		node[nodeid]pi := infinity;
		node[nodeid]accessed := false;
	endfor;
	node[ASCII snode]dist := 0;
enddef;

vardef SMP_RELAX(expr uvnode) :=
	save unode, vnode;
	numeric unode, vnode;
	unode := ASCII substring (0,1) of uvnode;
	vnode := ASCII substring (1,2) of uvnode;
	if (node[unode]dist <> infinity):
		save sum_weight;
		numeric sum_weight;
		sum_weight := node[unode]dist + edge[unode][vnode]weight;
		if node[vnode]dist > sum_weight:
			node[vnode]dist := sum_weight;
			node[vnode]pi := unode;
		elseif (node[vnode]dist = sum_weight):	% extra variable
			if (substring (0,1) of subst_equal_seq) = "1":
				node[vnode]dist := sum_weight;
				node[vnode]pi := unode;
			fi;
			subst_equal_seq := substring (1, length subst_equal_seq) of subst_equal_seq;
		fi;
	fi;
enddef;

vardef DIJKSTRA_NODE(expr snode) :=
image(
	save fillcolor, valcolor;
	color fillcolor, valcolor;
	if node[ASCII snode]accessed:
		fillcolor := black;
		valcolor := white;
	else:
		fillcolor := .8 white;
		valcolor := black;
	fi;
	draw node_frame shifted node[ASCII snode]pos;
	fill node_frame shifted node[ASCII snode]pos withcolor fillcolor;
	save lbl;
	string lbl;
	if node[ASCII snode]dist = infinity:
		lbl := "\infty";
	else:
		lbl := decimal(node[ASCII snode]dist);
	fi;
	label(TEX("$" & lbl & "$"), node[ASCII snode]pos) withcolor valcolor;
	save lbl_rel_dir, lbl_dir_str;
	numeric lbl_rel_dir; string lbl_dir_str;
	lbl_dir_str := node[ASCII snode]lbl_dir;
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
	fi;
	label.scantokens(node[ASCII snode]lbl_dir)(TEX("$" & snode & "$"),
		node_frame intersectionpoint ((0,0)--((dir lbl_rel_dir) * gsize))) shifted node[ASCII snode]pos;
)
enddef;

vardef DIJKSTRA_IMAGE :=
image(
for i := 0 upto (length nodeslist - 1):
	save nodeid;
	numeric nodeid;
	nodeid := ASCII substring (i,i+1) of nodeslist;
	if node[nodeid]pi <> infinity:
		draw graph_link_path((char node[nodeid]pi) & (char nodeid)) withcolor .8 white withpen pencircle scaled 5;
	fi;
endfor;

for i := 0 upto (length nodeslist - 1):
	save nodeid;
	numeric nodeid;
	nodeid := ASCII substring (i,i+1) of nodeslist;
	if known (node[nodeid]adj):
		save nextid;
		numeric nextid;
		nextid := node[nodeid]adj;
		forever:
			graph_simple_line((char nodeid) & (char nextid));
			exitif unknown edge[nodeid][nextid]next;
			nextid := edge[nodeid][nextid]next;
		endfor;
	fi;
endfor;
for i := 0 upto (length nodeslist - 1):
	draw DIJKSTRA_NODE(substring (i,i+1) of nodeslist);
endfor;
)
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% graph data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% edge and weight
graph_adj("s", "ty");
graph_edge("st", 3);
graph_edge("sy", 5);

graph_adj("t", "xy");
graph_edge("tx", 6);
graph_edge("ty", 2);

graph_adj("x", "z");
graph_edge("xz", 2);

graph_adj("y", "txz");
graph_edge("yt", 1);
graph_edge("yx", 4);
graph_edge("yz", 6);

graph_adj("z", "sx");
graph_edge("zs", 3);
graph_edge("zx", 7);

% node list
nodeslist := "stxyz";

% node position used for display
gsize := 1.2cm;
graph_disp_node("s", (0,0), "lft");
graph_disp_node("t", (1,1), "top");
graph_disp_node("x", (2.5,1), "top");
graph_disp_node("y", (1,-1), "bot");
graph_disp_node("z", (2.5,-1), "bot");

graph_disp_edge("st", 0, 0.5, "ulft");
graph_disp_edge("sy", 0, 0.5, "llft");
graph_disp_edge("tx", 0, 0.5, "top");
graph_disp_edge("ty", 0.2, 0.3, "lft");
graph_disp_edge("xz", 0.2, 0.5, "lft");
graph_disp_edge("yt", 0.2, 0.8, "rt");
graph_disp_edge("yx", 0, 0.8, "ulft");
graph_disp_edge("yz", 0, 0.5, "bot");
graph_disp_edge("zx", 0.2, 0.5, "rt");
graph_disp_edge("zs", 0, 0.2, "urt");

node_frame := fullcircle scaled .5cm;

%%%%%
save figidx;
numeric figidx;
figidx := 1;

vardef output_dijkstra_image :=
beginfig(figidx);
draw DIJKSTRA_IMAGE;
endfig;
figidx := figidx + 1;
enddef;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef EXTRACT_MIN :=
	save i;
	numeric i;
	save ret;
	numeric ret;
	for i := 0 upto (length nodeslist - 1):
		save nodeid;
		numeric nodeid;
		nodeid := ASCII substring (i,i+1) of nodeslist;
		if not node[nodeid]accessed:	% in Q set
			if unknown ret:
				ret := nodeid;
			elseif node[nodeid]dist < node[ret]dist:
				ret := nodeid;
			fi;
		fi;
	endfor;

	ret
enddef;

% output for z
vardef ALGO_DIJKSTRA(expr snode) :=
INITIALIZE_SINGLE_SOURCE(snode);
%output_dijkstra_image;

save accessedcnt;
numeric accessedcnt;
accessedcnt := 0;
forever:
	exitif accessedcnt = length nodeslist;
	save nodeid;
	numeric nodeid;
	nodeid := EXTRACT_MIN;
	if known (node[nodeid]adj):
		save nextid;
		numeric nextid;
		nextid := node[nodeid]adj;
		forever:
			SMP_RELAX((char nodeid) & (char nextid));
			exitif unknown edge[nodeid][nextid]next;
			nextid := edge[nodeid][nextid]next;
		endfor;
	fi;
	node[nodeid]accessed := true;
	accessedcnt := accessedcnt + 1;
	% output_dijkstra_image;
endfor;
output_dijkstra_image;
enddef;

subst_equal_seq := "000000";
ALGO_DIJKSTRA("s");

subst_equal_seq := "100000";
ALGO_DIJKSTRA("s");

end;
