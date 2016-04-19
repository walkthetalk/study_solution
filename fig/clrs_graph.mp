input TEX;

vardef declare_graph(suffix G)(expr is_directed_graph, _gsize, _frame) :=
%save vertexs;
boolean G.is_directed;
numeric G.V[]adj;
numeric G.E[][]next;
numeric G.E[][]weight;

% for display
path G.frame;
G.frame := _frame;
numeric G.gsize;
G.gsize := _gsize;

pair	G.V[]pos;
color	G.V[]fillcolor;

string	G.V[]id;
color	G.V[]idcolor;

path	G.E[][]way;

numeric G.E[][]weight_pos;
numeric G.E[][]weight_dir;

color	G.E[][]clr;
picture	G.E[][]pat;

% for enumeration
numeric G.V.seq[];
numeric G.V.num;
pair G.E.seq[];
numeric G.E.num;

G.is_directed := is_directed_graph;
G.V.num := 0;
G.E.num := 0;
enddef;

vardef __graph_add_vertex(suffix G)(expr idx, position) :=
	G.V[idx]pos := position;
	% update vertex set
	G.V.num := G.V.num + 1;
	G.V.seq[G.V.num] := idx;
enddef;

vardef __graph_add_adj(suffix G)(expr sidx, eidx) :=
	if unknown G.V[sidx]adj:
		G.V[sidx]adj := eidx;
	else:
		save tmp;
		tmp := G.V[sidx]adj;
		G.V[sidx]adj := eidx;
		G.V[sidx][eidx]next := tmp;
	fi;
enddef;

vardef __graph_set_edge_way(suffix G)(expr sidx, eidx, newpath) :=
	G.E[sidx][eidx]way := newpath;
	if not G.is_directed:
		G.E[eidx][sidx]way := newpath;
	fi;
enddef;

vardef __graph_add_edge_data(suffix G)(expr sidx, eidx) :=
	__graph_add_adj(G)(sidx, eidx);
	if not G.is_directed:
		__graph_add_adj(G)(eidx, sidx);
	fi;
	% update edge set
	G.E.num := G.E.num + 1;
	G.E.seq[G.E.num] := (sidx, eidx);
enddef;

vardef __graph_curve(suffix G)(expr sidx, eidx, sdegree, edegree) :=
	save startpoint, endpoint;
	pair startpoint, endpoint;
	startpoint := G.V[sidx]pos;
	endpoint := G.V[eidx]pos;
	save oridir;
	pair oridir;
	oridir := endpoint - startpoint;
	save ret;
	path ret;
	ret := (startpoint{oridir rotated sdegree}..{oridir rotated edegree}endpoint) scaled G.gsize;

	ret
enddef;

vardef __graph_add_curve_edge(suffix G)(expr sidx, eidx, sdegree, edegree) :=
	__graph_add_edge_data(G)(sidx, eidx);

	save newway; path newway;
	newway := __graph_curve(G)(sidx, eidx, sdegree, edegree);
	__graph_set_edge_way(G)(sidx, eidx, newway);
enddef;

vardef __graph_vertex_pos(suffix G)(expr idx) :=
	save vpos; pair vpos;
	vpos := G.V[idx]pos * G.gsize;

	vpos
enddef;

vardef __graph_vertex_path(suffix G)(expr idx) :=
	save vertexPath; path vertexPath;
	vertexPath := G.frame shifted __graph_vertex_pos(G)(idx);
	vertexPath
enddef;

def __label(expr vdegree) :=
	if (vdegree < 0):
		__label(vdegree + 360)
	elseif (vdegree >= 360):
		__label(vdegree - 360)
	elseif (vdegree <= 22.5):
		label.rt
	elseif (vdegree <= 67.5):
		label.urt
	elseif (vdegree <= 112.5):
		label.top
	elseif (vdegree <= 157.5):
		label.ulft
	elseif (vdegree <= 202.5):
		label.lft
	elseif (vdegree <= 247.5):
		label.llft
	elseif (vdegree <= 292.5):
		label.bot
	elseif (vdegree <= 337.5):
		label.lrt
	elseif (vdegree < 360):
		label.rt
	fi
enddef;

vardef __vertex_remark(suffix G, remark_fn)(expr idx, vdegree) :=
	save position; pair position;
	position := __intersectionpoint(G)(idx, vdegree);
	save p; picture p;
	p := remark_fn(G)(idx);
	if (vdegree < 0):
		__pic(G, remark_fn)(vdegree + 360)
	elseif (vdegree >= 360):
		__pic(G, remark_fn)(vdegree - 360)
	elseif (vdegree <= 22.5):
		p shifted (position - (ulcorner p + llcorner p)/2)
	elseif (vdegree <= 67.5):
		p shifted (position - llcorner p)
	elseif (vdegree <= 112.5):
		p shifted (position - (llcorner p + lrcorner p)/2)
	elseif (vdegree <= 157.5):
		p shifted (position - lrcorner p)
	elseif (vdegree <= 202.5):
		p shifted (position - (urcorner p + lrcorner p)/2)
	elseif (vdegree <= 247.5):
		p shifted (position - urcorner p)
	elseif (vdegree <= 292.5):
		p shifted (position - (ulcorner p + urcorner p)/2)
	elseif (vdegree <= 337.5):
		p shifted (position - ulcorner p)
	elseif (vdegree < 360):
		p shifted (position - (ulcorner p + llcorner p)/2)
	fi
enddef;

vardef __intersectionpoint(suffix G)(expr idx, degree) :=
	save ret; pair ret;
	ret := (((0,0)--(dir degree)) scaled G.gsize shifted __graph_vertex_pos(G)(idx)) intersectionpoint __graph_vertex_path(G)(idx);
	ret
enddef;

vardef __num_to_str(expr num) :=
	save ret; string ret;
	if num = infinity:
		ret := "$\infty$";
	elseif num = -infinity:
		ret := "$-\infty$";
	else:
		ret := "$" & decimal(num) & "$";
	fi;
	ret
enddef;

vardef __draw_graph_edge(suffix G)(expr sidx, eidx) :=
draw image(
	if G.is_directed: drawarrow else: draw	fi
		graph_edge_path_n(G)(sidx, eidx)
		withcolor	if known G.E[sidx][eidx]clr:	G.E[sidx][eidx]clr else: black	fi
		dashed		if known G.E[sidx][eidx]pat:	evenly	else:	blankpicture	fi;
);
enddef;

vardef __draw_graph_edge_weight(suffix G)(expr sidx, eidx) :=
if known G.E[sidx][eidx]weight:
	draw image(
		save _road; path _road;
		_road := graph_edge_path_n(G)(sidx, eidx);
		save _pos; pair _pos;
		_pos := point (arctime ((arclength _road) * G.E[sidx][eidx]weight_pos) of _road) of _road;
		graph_label(G.E[sidx][eidx]weight_dir)(TEX(__num_to_str(G.E[sidx][eidx]weight)), _pos);
	);
fi;
enddef;

vardef __draw_graph_vertex(suffix G)(expr idx) :=
draw image(
	save vpos; pair vpos;
	vpos := __graph_vertex_pos(G)(vidx);

	save vpath; path vpath;
	vpath := __graph_vertex_path(G)(vidx);

	fill vpath withcolor if known G.V[vidx]fillcolor: G.V[vidx]fillcolor else: white fi;
	draw vpath;

	% vertex name
	label(TEX(G.V[vidx]id), vpos) withcolor if known G.V[vidx]idcolor: G.V[vidx]idcolor else: black fi;
);
enddef;

% Auxiliary macro
vardef __mtpl_emptytext@# text t =
	%message "text is: " & str @#;
	(str @# = "mtpl_aceedabfadfcada1fdb4mtpl_aabobfcbadbde759")
enddef;
% Vardef: emptytext?
% Returns:
% True if the given text argument consists of no tokens, false otherwise.
vardef __emptytext(text t) =
	__mtpl_emptytext mtpl_aceedabfadfcada1fdb4 t mtpl_aabobfcbadbde759
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% public functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def graph_label(expr degree) :=
	__label(degree)
enddef;

vardef graph_add_vertex_n(suffix G)(expr idx, position)text _remain :=
	__graph_add_vertex(G)(idx, position);
	G.V[idx]id := "$v_{" & decimal(idx) & "}$";

	if not __emptytext(_remain):
		graph_add_vertex_n(G) _remain;
	fi;
enddef;

vardef graph_add_edge_n(suffix G)(expr sidx, eidx)text _remain :=
	graph_add_curve_edge_n(G)(sidx, eidx, 0, 0);

	if not __emptytext(_remain):
		graph_add_edge_n(G) _remain;
	fi;
enddef;

vardef graph_add_edge_with_weight_n(suffix G)(expr sidx, eidx, pos, deg, _weight)text _remain :=
	graph_add_edge_n(G)(sidx,eidx);
	G.E[sidx][eidx]weight := _weight;
	G.E[sidx][eidx]weight_pos := pos;
	G.E[sidx][eidx]weight_dir := deg;
	if not __emptytext(_remain):
		graph_add_edge_with_weight_n(G)_remain;
	fi;
enddef;

vardef graph_add_curve_edge_n(suffix G)(expr sidx, eidx, sdegree, edegree)text _remain :=
	__graph_add_curve_edge(G)(sidx, eidx, sdegree, edegree);

	if not __emptytext(_remain):
		graph_add_curve_edge_n(G) _remain;
	fi;
enddef;

vardef graph_edge_link_n(suffix G)(expr sidx, eidx) :=
	save ret; path ret;
	ret := G.E[sidx][eidx]way;
	ret
enddef;

vardef graph_edge_path_n(suffix G)(expr sidx, eidx) :=
	save ret; path ret;
	ret := graph_edge_link_n(G)(sidx, eidx)
		cutbefore __graph_vertex_path(G)(sidx)
		cutafter __graph_vertex_path(G)(eidx);
	ret
enddef;

vardef graph_vertex_path_n(suffix G)(expr idx) :=
	save ret; path ret;
	ret := __graph_vertex_path(G)(idx);
	ret
enddef;

vardef graph_vertex_position_n(suffix G)(expr idx) :=
	save ret; path ret;
	ret := __graph_vertex_pos(G)(idx);
	ret
enddef;

% @ edge_fn: (suffix G)(expr sidx, eidx)
vardef graph_loop_edge(suffix G, edge_fn) :=
	save i;
	for i := 1 upto G.E.num:
		edge_fn(G)(xpart G.E.seq[i], ypart G.E.seq[i]);
	endfor;
enddef;

% @ vertex_fn: (suffix G)(numeric idx)
vardef graph_loop_vertex(suffix G, vertex_fn) :=
	save i;
	for i := 1 upto G.V.num:
		save vidx;
		numeric vidx;
		vidx := G.V.seq[i];

		vertex_fn(G)(vidx);
	endfor;
enddef;

vardef graph_img(suffix G) :=
image(
	graph_loop_edge(G, __draw_graph_edge);
	graph_loop_edge(G, __draw_graph_edge_weight);
	graph_loop_vertex(G, __draw_graph_vertex);
)
enddef;

vardef graph_assign_edge_color_n(suffix G)(expr colour)(expr sidx, eidx)text _remain :=
	G.E[sidx][eidx]clr := colour;
	if not __emptytext(_remain):
		graph_assign_edge_color_n(G)(colour)_remain;
	fi;
enddef;

vardef graph_assign_edge_pattern_n(suffix G)(expr pattern)(expr sidx, eidx)text _remain :=
	G.E[sidx][eidx]pat := pattern;
	if not __emptytext(_remain):
		graph_assign_edge_pattern_n(G)(pattern)_remain;
	fi;
enddef;

vardef graph_assign_vertex_color_n(suffix G)(expr fclr, iclr)(expr idx)text _remain :=
	G.V[idx]fillcolor := fclr;
	G.V[idx]idcolor := iclr;
	if not __emptytext(_remain):
		graph_assign_vertex_color_n(G)(fclr, iclr)_remain;
	fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% a var %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef graph_add_vertex_a(suffix G)(expr idx, position)text _remain :=
	__graph_add_vertex(G)(ASCII idx, position);
	G.V[ASCII idx]id := "$" & idx & "$";
	if not __emptytext(_remain):
		graph_add_vertex_a(G)_remain;
	fi;
enddef;

vardef graph_add_edge_a(suffix G)(expr seidx)text _remain :=
	graph_add_edge_n(G)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		graph_add_edge_a(G)_remain;
	fi;
enddef;

vardef graph_add_edge_with_weight_a(suffix G)(expr seidx, pos, deg, _weight)text _remain :=
	graph_add_edge_with_weight_n(G)(ASCII substring(0,1)of seidx,
					ASCII substring(1,2)of seidx,
					pos, deg, _weight);
	if not __emptytext(_remain):
		graph_add_edge_with_weight_a(G)_remain;
	fi;
enddef;

vardef graph_add_curve_edge_a(suffix G)(expr seidx, sdegree, edegree)text _remain :=
	graph_add_curve_edge_n(G)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx, sdegree, edegree);
	if not __emptytext(_remain):
		graph_add_curve_edge_a(G)_remain;
	fi;
enddef;

vardef graph_assign_edge_color_a(suffix G)(expr colour)(expr seidx)text _remain :=
	graph_assign_edge_color_n(G)(colour)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		graph_assign_edge_color_a(G)(colour)_remain;
	fi;
enddef;

vardef graph_assign_edge_pattern_a(suffix G)(expr pattern)(expr seidx)text _remain :=
	graph_assign_edge_pattern_n(G)(pattern)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		graph_assign_edge_pattern_a(G)(pattern)_remain;
	fi;
enddef;

vardef graph_assign_vertex_color_a(suffix G)(expr fclr, iclr)(expr idx) :=
	save i;
	for i := 0 upto (length idx - 1):
		graph_assign_vertex_color_n(G)(fclr, iclr)(ASCII substring(i,i+1)of idx);
	endfor;
enddef;

vardef graph_vertex_path_a(suffix G)(expr idx) :=
	graph_vertex_path_n(G)(ASCII idx)
enddef;

vardef graph_vertex_position_a(suffix G)(expr idx) :=
	graph_vertex_position_n(G)(ASCII idx)
enddef;

vardef graph_edge_link_a(suffix G)(expr seidx) :=
	graph_edge_link_n(G)(ASCII substring(0,1)of seidx,ASCII substring(1,2)of seidx)
enddef;

vardef graph_edge_path_a(suffix G)(expr seidx) :=
	graph_edge_path_n(G)(ASCII substring(0,1)of seidx,ASCII substring(1,2)of seidx)
enddef;
