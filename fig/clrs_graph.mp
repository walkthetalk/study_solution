input TEX;

vardef declare_graph(suffix G)(expr is_directed_graph, is_char_id, _gsize, _frame) :=
%save vertexs;
boolean G.is_directed;
boolean G.is_charid;
numeric G.V[]adj;
numeric G.E[][]next;

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

color	G.E[][]clr;
picture	G.E[][]pat;

% for enumeration
numeric G.V.seq[];
numeric G.V.num;
pair G.E.seq[];
numeric G.E.num;

G.is_charid := is_char_id;
G.is_directed := is_directed_graph;
G.V.num := 0;
G.E.num := 0;
enddef;

vardef __GV_id(expr idx) :=
	if G.is_charid:
		(ASCII idx)
	else:
		idx
	fi
enddef;

vardef __GE_sid(expr seidx) :=
	if G.is_charid:
		(ASCII substring(0,1)of seidx)
	else:
		(xpart seidx)
	fi
enddef;

vardef __GE_eid(expr seidx) :=
	if G.is_charid:
		(ASCII substring(1,2)of seidx)
	else:
		(ypart seidx)
	fi
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

vardef __pic_shift(expr _p, _deg, _pos) :=

	if (_deg < 0):
		__pic_shift(_p, _deg + 360, _pos)
	elseif (_deg >= 360):
		__pic_shift(_p, _deg - 360, _pos)
	elseif (_deg <= 22.5):
		(_pos - (ulcorner _p + llcorner _p)/2)
	elseif (_deg <= 67.5):
		(_pos - llcorner _p)
	elseif (_deg <= 112.5):
		(_pos - (llcorner _p + lrcorner _p)/2)
	elseif (_deg <= 157.5):
		(_pos - lrcorner _p)
	elseif (_deg <= 202.5):
		(_pos - (urcorner _p + lrcorner _p)/2)
	elseif (_deg <= 247.5):
		(_pos - urcorner _p)
	elseif (_deg <= 292.5):
		(_pos - (ulcorner _p + urcorner _p)/2)
	elseif (_deg <= 337.5):
		(_pos - ulcorner _p)
	elseif (_deg < 360):
		(_pos - (ulcorner _p + llcorner _p)/2)
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
	graph_loop_vertex(G, __draw_graph_vertex);
)
enddef;

vardef graph_set_edge_color_n(suffix G)(expr colour)(expr sidx, eidx)text _remain :=
	G.E[sidx][eidx]clr := colour;
	if not __emptytext(_remain):
		graph_set_edge_color_n(G)(colour)_remain;
	fi;
enddef;

vardef graph_set_edge_pattern_n(suffix G)(expr pattern)(expr sidx, eidx)text _remain :=
	G.E[sidx][eidx]pat := pattern;
	if not __emptytext(_remain):
		graph_set_edge_pattern_n(G)(pattern)_remain;
	fi;
enddef;

vardef graph_set_vertex_color_n(suffix G)(expr fclr, iclr)(expr idx)text _remain :=
	G.V[idx]fillcolor := fclr;
	G.V[idx]idcolor := iclr;
	if not __emptytext(_remain):
		graph_set_vertex_color_n(G)(fclr, iclr)_remain;
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

vardef graph_add_curve_edge_a(suffix G)(expr seidx, sdegree, edegree)text _remain :=
	graph_add_curve_edge_n(G)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx, sdegree, edegree);
	if not __emptytext(_remain):
		graph_add_curve_edge_a(G)_remain;
	fi;
enddef;

vardef graph_set_edge_color_a(suffix G)(expr colour)(expr seidx)text _remain :=
	graph_set_edge_color_n(G)(colour)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		graph_set_edge_color_a(G)(colour)_remain;
	fi;
enddef;

vardef graph_set_edge_pattern_a(suffix G)(expr pattern)(expr seidx)text _remain :=
	graph_set_edge_pattern_n(G)(pattern)(ASCII substring(0,1)of seidx, ASCII substring(1,2)of seidx);
	if not __emptytext(_remain):
		graph_set_edge_pattern_a(G)(pattern)_remain;
	fi;
enddef;

vardef graph_set_vertex_color_a(suffix G)(expr fclr, iclr)(expr idx) :=
	save i;
	for i := 0 upto (length idx - 1):
		graph_set_vertex_color_n(G)(fclr, iclr)(ASCII substring(i,i+1)of idx);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% short var %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vardef G_add_V(suffix G)text _remain :=
	if G.is_charid:
		graph_add_vertex_a(G)_remain;
	else:
		graph_add_vertex_n(G)_remain;
	fi;
enddef;

vardef G_add_E(suffix G)text _remain :=
	if G.is_charid:
		graph_add_edge_a(G)_remain;
	else:
		graph_add_edge_n(G)_remain;
	fi;
enddef;

vardef G_add_curveE(suffix G)text _remain :=
	if G.is_charid:
		graph_add_curve_edge_a(G)_remain;
	else:
		graph_add_curve_edge_n(G)_remain;
	fi;
enddef;

vardef G_set_E_color(suffix G)text _remain :=
	if G.is_charid:
		graph_set_edge_color_a(G)_remain;
	else:
		graph_set_edge_color_n(G)_remain;
	fi;
enddef;

vardef G_set_E_pattern(suffix G)text _remain :=
	if G.is_charid:
		graph_set_edge_pattern_a(G)_remain;
	else:
		graph_set_edge_pattern_n(G)_remain;
	fi;
enddef;

vardef G_set_V_color(suffix G)text _remain :=
	if G.is_charid:
		graph_set_vertex_color_a(G)_remain;
	else:
		graph_set_vertex_color_n(G)_remain;
	fi;
enddef;

vardef G_V_path(suffix G)(text _remain) :=
	if G.is_charid:
		graph_vertex_path_a(G)(_remain)
	else:
		graph_vertex_path_n(G)(_remain)
	fi
enddef;

vardef G_V_position(suffix G)(text _remain) :=
	if G.is_charid:
		graph_vertex_position_a(G)(_remain)
	else:
		graph_vertex_position_n(G)(_remain)
	fi
enddef;

vardef G_E_link(suffix G)(text _remain) :=
	if G.is_charid:
		graph_edge_link_a(G)(_remain)
	else:
		graph_edge_link_n(G)(_remain)
	fi
enddef;

vardef G_E_path(suffix G)(text _remain) :=
	if G.is_charid:
		graph_edge_path_a(G)(_remain)
	else:
		graph_edge_path_n(G)(_remain)
	fi
enddef;
