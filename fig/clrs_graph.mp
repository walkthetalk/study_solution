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

string	G.V.draw_fn[];
numeric	G.V.draw_fn_num;
string	G.E.draw_fn[];
numeric	G.E.draw_fn_num;

G.V.draw_fn_num := 0;
G.E.draw_fn_num := 0;

% for enumeration
numeric G.V.seq[];
numeric G.V.num;
pair G.E.seq[];
numeric G.E.num;

G.is_charid := is_char_id;
G.is_directed := is_directed_graph;
G.V.num := 0;
G.E.num := 0;

__graph_add_vertex_draw_func(G)("__draw_graph_vertex");
__graph_add_edge_draw_func(G)("__draw_graph_edge");
enddef;

vardef __graph_add_vertex_draw_func(suffix G)(expr _fn) :=
	G.V.draw_fn_num := G.V.draw_fn_num + 1;
	G.V.draw_fn[G.V.draw_fn_num] := _fn;
enddef;

vardef __graph_add_edge_draw_func(suffix G)(expr _fn) :=
	G.E.draw_fn_num := G.E.draw_fn_num + 1;
	G.E.draw_fn[G.E.draw_fn_num] := _fn;
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
		__graph_edge_path(G)(sidx, eidx)
		withcolor	if known G.E[sidx][eidx]clr:	G.E[sidx][eidx]clr else: black	fi
		dashed		if known G.E[sidx][eidx]pat:	evenly	else:	blankpicture	fi;
);
enddef;

vardef __draw_graph_vertex(suffix G)(expr idx) :=
draw image(
	save vpos; pair vpos;
	vpos := __graph_vertex_pos(G)(idx);

	save vpath; path vpath;
	vpath := __graph_vertex_path(G)(idx);

	fill vpath withcolor if known G.V[idx]fillcolor: G.V[idx]fillcolor else: white fi;
	draw vpath;

	% vertex name
	save _idstring; string _idstring;
	if known G.V[idx]id:
		_idstring := G.V[idx]id;
	else:
		if G.is_charid:
			_idstring := "$" & char(idx) & "$";
		else:
			_idstring := "$v_{" & decimal(idx) & "}$";
		fi;
	fi;
	label(TEX(_idstring), vpos) withcolor if known G.V[idx]idcolor: G.V[idx]idcolor else: black fi;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% private functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef ____extract_id_n(suffix sidx, eidx)(expr _sidx, _eidx) :=
	sidx := _sidx;
	eidx := _eidx;
enddef;

vardef ____extract_id_a(suffix sidx, eidx)(expr seidx) :=
	sidx := __GE_sid(seidx);
	eidx := __GE_eid(seidx);
enddef;

vardef __extract_id(suffix sidx, eidx)(text _plist) :=
	if G.is_charid:
		____extract_id_a(sidx, eidx)(_plist);
	else:
		____extract_id_n(sidx, eidx)(_plist);
	fi;
enddef;

vardef __graph_edge_link(suffix G)(expr sidx, eidx) :=
	save ret; path ret;
	ret := G.E[sidx][eidx]way;
	ret
enddef;

vardef __graph_edge_path(suffix G)(expr sidx, eidx) :=
	save ret; path ret;
	ret := __graph_edge_link(G)(sidx, eidx)
		cutbefore __graph_vertex_path(G)(sidx)
		cutafter __graph_vertex_path(G)(eidx);
	ret
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% public functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% graph add vertex
%% (1, (3,4)) | ("a", (3,4))
vardef G_add_V(suffix G)(expr idx, position)text _remain :=
	__graph_add_vertex(G)(__GV_id(idx), position);

	if not __emptytext(_remain):
		G_add_V(G) _remain;
	fi;
enddef;

%% graph add edge
%% (1,2) | ("ab")
vardef G_add_E(suffix G)(text _plist)text _remain :=
	save sidx, eidx; numeric sidx, eidx; __extract_id(sidx, eidx)(_plist);

	__graph_add_curve_edge(G)(sidx, eidx, 0, 0);

	if not __emptytext(_remain):
		G_add_E(G) _remain;
	fi;
enddef;

%% graph add curve edge
%% ((0,1), 30, -30) | ("ab", 30, -30)
vardef G_add_curveE(suffix G)(expr seidx, sdegree, edegree)text _remain :=
	__graph_add_curve_edge(G)(__GE_sid(seidx), __GE_eid(seidx), sdegree, edegree);

	if not __emptytext(_remain):
		G_add_curveE(G) _remain;
	fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef G_set_E_pattern(suffix G)(expr pattern)(text _plist)text _remain :=
	save sidx, eidx; numeric sidx, eidx; __extract_id(sidx, eidx)(_plist);

	G.E[sidx][eidx]pat := pattern;

	if not __emptytext(_remain):
		G_set_E_pattern(G)(pattern)_remain;
	fi;
enddef;

vardef G_set_E_color(suffix G)(expr colour)(text _plist)text _remain :=
	save sidx, eidx; numeric sidx, eidx; __extract_id(sidx, eidx)(_plist);

	G.E[sidx][eidx]clr := colour;

	if not __emptytext(_remain):
		G_set_E_color(G)(colour)_remain;
	fi;
enddef;

vardef G_set_V_color(suffix G)(expr fclr, iclr)(expr idx)text _remain :=
	G.V[__GV_id(idx)]fillcolor := fclr;
	G.V[__GV_id(idx)]idcolor := iclr;

	if not __emptytext(_remain):
		G_set_V_color(G)(fclr, iclr)_remain;
	fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% get %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% graph edge link
vardef G_E_link(suffix G)(text _plist) :=
	save sidx, eidx; numeric sidx, eidx; __extract_id(sidx, eidx)(_plist);
	__graph_edge_link(G)(sidx, eidx)
enddef;

%% graph edge path (cutted by vertex frame)
vardef G_E_path(suffix G)(text _plist) :=
	save sidx, eidx; numeric sidx, eidx; __extract_id(sidx, eidx)(_plist);
	__graph_edge_path(G)(sidx, eidx)
enddef;

%% graph vertex position
vardef G_V_position(suffix G)(expr idx) :=
	__graph_vertex_pos(G)(__GV_id(idx))
enddef;

%% graph vertex path
vardef G_V_path(suffix G)(expr idx) :=
	__graph_vertex_path(G)(__GV_id(idx))
enddef;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ edge_fn: (suffix G)(expr sidx, eidx)
vardef graph_loop_edge(suffix G, edge_fn) :=
	save i;
	for i := 1 upto G.E.num:
		scantokens(edge_fn)(G)(xpart G.E.seq[i], ypart G.E.seq[i]);
	endfor;
enddef;

% @ vertex_fn: (suffix G)(numeric idx)
vardef graph_loop_vertex(suffix G, vertex_fn) :=
	save i;
	for i := 1 upto G.V.num:
		save idx;
		numeric idx;
		idx := G.V.seq[i];

		scantokens(vertex_fn)(G)(idx);
	endfor;
enddef;

vardef graph_img(suffix G) :=
image(
	save i; numeric i;

	for i := 1 upto G.E.draw_fn_num:
		graph_loop_edge(G, G.E.draw_fn[i]);
	endfor;

	for i := 1 upto G.V.draw_fn_num:
		graph_loop_vertex(G, G.V.draw_fn[i]);
	endfor;
)
enddef;
