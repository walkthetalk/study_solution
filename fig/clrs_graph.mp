input TEX;

vardef GEP_default := 0 enddef;
vardef GEP_dashedvenly := 1 enddef;

vardef declare_graph(suffix G)(expr is_directed_graph, is_char_id, _gsize, _frame) :=
%save vertexs;
boolean G.is_directed;
boolean G.is_charid;

numeric G.V[]adj;
boolean G.V[]is_in;
numeric G.E[][]next;
boolean G.E[][]is_in;

% for enumeration
numeric G.V.seq[];
numeric G.V.num;
pair G.E.seq[];
numeric G.E.num;

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
string	G.E.pattern_func[];
numeric	G.E[][]pat[];
numeric G.E[][]pat_num;

string	G.V.draw_fn[];
numeric	G.V.draw_fn_num;
string	G.E.draw_fn[];
numeric	G.E.draw_fn_num;

G.V.draw_fn_num := 0;
G.E.draw_fn_num := 0;

G.is_charid := is_char_id;
G.is_directed := is_directed_graph;
G.V.num := 0;
G.E.num := 0;

__graph_add_vertex_draw_func(G)("__draw_graph_vertex");
__graph_add_edge_draw_func(G)("__draw_graph_edge");
G_set_E_pattern_func(G)(GEP_default, "____edge_pattern");
G_set_E_pattern_func(G)(GEP_dashedvenly, "____edge_pattern");
enddef;

vardef __graph_add_vertex_draw_func(suffix G)(expr _fn) :=
	G.V.draw_fn_num := G.V.draw_fn_num + 1;
	G.V.draw_fn[G.V.draw_fn_num] := _fn;
enddef;

vardef __graph_add_edge_draw_func(suffix G)(expr _fn) :=
	G.E.draw_fn_num := G.E.draw_fn_num + 1;
	G.E.draw_fn[G.E.draw_fn_num] := _fn;
enddef;

vardef __graph_new_vertex(suffix G)(expr idx) :=
	% update vertex set
	G.V.num := G.V.num + 1;
	G.V.seq[G.V.num] := idx;
	G.V[idx]is_in := true;
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

vardef __graph_edge_init_pat(suffix G)(expr sidx, eidx) :=
	G.E[sidx][eidx]pat_num := 0;
	if not G.is_directed:
		G.E[eidx][sidx]pat_num := 0;
	fi;
enddef;

vardef __graph_edge_add_pat(suffix G)(expr sidx, eidx, _pn) :=
	save oripn; numeric oripn; oripn := G.E[sidx][eidx]pat_num;
	G.E[sidx][eidx]pat_num := oripn + 1;
	G.E[sidx][eidx]pat[oripn + 1] := _pn;
	if not G.is_directed:
		G.E[eidx][sidx]pat_num := oripn + 1;
		G.E[eidx][sidx]pat[oripn + 1] := _pn;
	fi;
enddef;

vardef __graph_new_edge(suffix G)(expr sidx, eidx) :=
	% update edge set
	G.E.num := G.E.num + 1;
	G.E.seq[G.E.num] := (sidx, eidx);
	G.E[sidx][eidx]is_in := true;
	if not G.is_directed:
		G.E[eidx][sidx]is_in := G.E[sidx][eidx]is_in;
	fi;
	__graph_edge_init_pat(G)(sidx, eidx);
	__graph_edge_add_pat(G)(sidx, eidx, GEP_default);
enddef;

vardef __graph_add_curve_edge(suffix G)(expr sidx, eidx, sdegree, edegree) :=
	__graph_add_adj(G)(sidx, eidx);
	if not G.is_directed:
		__graph_add_adj(G)(eidx, sidx);
	fi;

	G.E[sidx][eidx]way := __graph_curve(G)(sidx, eidx, sdegree, edegree);
	if not G.is_directed:
		G.E[eidx][sidx]way := G.E[sidx][eidx]way;
	fi;
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
	save ret; pair ret;
	if (_deg < 0):
		ret := __pic_shift(_p, _deg + 360, _pos);
	elseif (_deg >= 360):
		ret := __pic_shift(_p, _deg - 360, _pos);
	elseif (_deg <= 22.5):
		ret := (_pos - (ulcorner _p + llcorner _p)/2);
	elseif (_deg <= 67.5):
		ret := (_pos - llcorner _p);
	elseif (_deg <= 112.5):
		ret := (_pos - (llcorner _p + lrcorner _p)/2);
	elseif (_deg <= 157.5):
		ret := (_pos - lrcorner _p);
	elseif (_deg <= 202.5):
		ret := (_pos - (urcorner _p + lrcorner _p)/2);
	elseif (_deg <= 247.5):
		ret := (_pos - urcorner _p);
	elseif (_deg <= 292.5):
		ret := (_pos - (ulcorner _p + urcorner _p)/2);
	elseif (_deg <= 337.5):
		ret := (_pos - ulcorner _p)
	elseif (_deg < 360):
		ret := (_pos - (ulcorner _p + llcorner _p)/2);
	fi;
	%message "::::::::: " & decimal(_deg) & " - " & decimal(xpart ((0,.2cm) rotated _deg)) & ", " & decimal(ypart ((0,.2cm) rotated _deg));
	ret := ret + ((3bp, 0) rotated _deg);
	ret
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

def ____edge_pattern(expr _pn) :=
	if _pn = GEP_dashedvenly:
		dashed evenly
	else:	% GEP_default
	fi
enddef;

vardef __draw_graph_edge(suffix G)(expr sidx, eidx) :=
draw image(
	save i; numeric i;
	for i := 1 upto G.E[sidx][eidx]pat_num:
		save _pn; numeric _pn; _pn := G.E[sidx][eidx]pat[i];

		if G.is_directed: drawarrow else: draw	fi
			__graph_edge_path(G)(sidx, eidx)
			withcolor	if known G.E[sidx][eidx]clr:	G.E[sidx][eidx]clr else: black	fi
			if known G.E.pattern_func[_pn]: scantokens(G.E.pattern_func[_pn])(_pn) fi
			;
	endfor;
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
	sidx := ASCII substring(0,1)of seidx;
	eidx := ASCII substring(1,2)of seidx;
enddef;

%% (1, 2) | ("ab")
vardef ____extract_id(suffix sidx, eidx)(text _plist) :=
	if G.is_charid:
		____extract_id_a(sidx, eidx)(_plist);
	else:
		____extract_id_n(sidx, eidx)(_plist);
	fi;
enddef;

%% (1, 2) | ("ab")
vardef __extract_sid(text _plist) :=
	save sidx, eidx; numeric sidx, eidx; ____extract_id(sidx, eidx)(_plist); sidx
enddef;
%% (1, 2) | ("ab")
vardef __extract_eid(text _plist) :=
	save sidx, eidx; numeric sidx, eidx; ____extract_id(sidx, eidx)(_plist); eidx
enddef;

vardef __get_id(expr idx) :=
	if G.is_charid:
		(ASCII idx)
	else:
		idx
	fi
enddef;

%% ((1,2)) | ("ab")
vardef __get_sid(expr seidx) :=
	if G.is_charid:
		(ASCII substring(0,1)of seidx)
	else:
		(xpart seidx)
	fi
enddef;

%% ((1,2)) | ("ab")
vardef __get_eid(expr seidx) :=
	if G.is_charid:
		(ASCII substring(1,2)of seidx)
	else:
		(ypart seidx)
	fi
enddef;

vardef __graph_edge_link(suffix G)(expr sidx, eidx) :=
	save ret; path ret;
	if known G.E[sidx][eidx]way:
		ret := G.E[sidx][eidx]way;
	else:
		ret := __graph_curve(G)(sidx, eidx, 0, 0);
	fi;
	ret
enddef;

vardef __graph_edge_path(suffix G)(expr sidx, eidx) :=
	save ret; path ret;
	ret := __graph_edge_link(G)(sidx, eidx)
		cutbefore __graph_vertex_path(G)(sidx)
		cutafter __graph_vertex_path(G)(eidx);
	ret
enddef;

vardef __graph_has_vertex(suffix G)(expr idx) :=
	if unknown G.V[idx]is_in:
		false
	elseif not G.V[idx]is_in:
		false
	else:
		true
	fi
enddef;

vardef __graph_has_edge(suffix G)(expr sidx, eidx) :=
	if unknown G.E[sidx][eidx]is_in:
		false
	elseif not G.E[sidx][eidx]is_in:
		false
	else:
		true
	fi
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% public functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% add %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% graph add vertex
%% (1, (3,4)) | ("a", (3,4))
vardef G_add_V(suffix G)(expr idx, position)text _remain :=
	__graph_new_vertex(G)(__get_id(idx));

	G.V[__get_id(idx)]pos := position;

	if not __emptytext(_remain):
		G_add_V(G) _remain;
	fi;
enddef;

%% graph add edge
%% (1,2) | ("ab")
vardef G_add_E(suffix G)(text _plist)text _remain :=
	__graph_new_edge(G)(__extract_sid(_plist), __extract_eid(_plist));
	__graph_add_curve_edge(G)(__extract_sid(_plist), __extract_eid(_plist), 0, 0);

	if not __emptytext(_remain):
		G_add_E(G) _remain;
	fi;
enddef;

%% graph add curve edge
%% ((0,1), 30, -30) | ("ab", 30, -30)
vardef G_add_curveE(suffix G)(expr seidx, sdegree, edegree)text _remain :=
	__graph_new_edge(G)(__get_sid(seidx), __get_eid(seidx));
	__graph_add_curve_edge(G)(__get_sid(seidx), __get_eid(seidx), sdegree, edegree);

	if not __emptytext(_remain):
		G_add_curveE(G) _remain;
	fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% new grammar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef G_set_E_pattern_func(suffix G)(expr _pn, _fn) :=
	G.E.pattern_func[_pn] := _fn;
enddef;

def G_auto_V(suffix G) expr v :=
	def ____G = G enddef;
	def ____VID := v enddef;
	def ____vid := __get_id(v) enddef;
	def ____V := ____G.V[____vid] enddef;
	if not __graph_has_vertex(____G)(____vid):
		__graph_new_vertex(____G)(____vid);
	fi;
enddef;
def G_auto_E(suffix G) expr e :=
	def ____G = G enddef;
	def ____EID := e enddef;
	def ____sid := __get_sid(e) enddef;
	def ____eid := __get_eid(e) enddef;
	def ____E := ____G.E[____sid][____eid] enddef;
	if not __graph_has_edge(____G)(____sid, ____eid):
		__graph_new_edge(____G)(____sid, ____eid);
	fi;
enddef;

%% vertex ext property
def Gposition expr p :=
	; ____V.pos := p;
enddef;

%% edge ext property
def Gpath expr p :=
	; __graph_add_curve_edge(____G)(____sid, ____eid, xpart p, ypart p);
enddef;

def Gpattern expr p :=
	;
	__graph_edge_init_pat(____G)(____sid, ____eid);
	__graph_edge_add_pat(____G)(____sid, ____eid, p);
enddef;

def Gpatternlist (text _t) :=
	;
	__graph_edge_init_pat(____G)(____sid, ____eid);
	forsuffixes $=_t:
		__graph_edge_add_pat(____G)(____sid, ____eid, $);
	endfor;
enddef;

def Gcolor expr _c :=
	; ____E.clr := _c;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef G_set_E_pattern(suffix G)(text _pat_list)(text _plist)text _remain :=
	__graph_edge_init_pat(G)(__extract_sid(_plist), __extract_eid(_plist));
	forsuffixes $=_pat_list:
		__graph_edge_add_pat(G)(__extract_sid(_plist), __extract_eid(_plist), $);
	endfor;
	if not __emptytext(_remain):
		G_set_E_pattern(G)(_pat_list)_remain;
	fi;
enddef;

vardef G_set_E_color(suffix G)(expr colour)(text _plist)text _remain :=
	G.E[__extract_sid(_plist)][__extract_eid(_plist)]clr := colour;

	if not __emptytext(_remain):
		G_set_E_color(G)(colour)_remain;
	fi;
enddef;

vardef G_set_V_color(suffix G)(expr fclr, iclr)(expr idx)text _remain :=
	G.V[__get_id(idx)]fillcolor := fclr;
	G.V[__get_id(idx)]idcolor := iclr;

	if not __emptytext(_remain):
		G_set_V_color(G)(fclr, iclr)_remain;
	fi;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% get %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% graph edge link
vardef G_E_link(suffix G)(text _plist) :=
	__graph_edge_link(G)(__extract_sid(_plist), __extract_eid(_plist))
enddef;

%% graph edge path (cutted by vertex frame)
vardef G_E_path(suffix G)(text _plist) :=
	__graph_edge_path(G)(__extract_sid(_plist), __extract_eid(_plist))
enddef;

%% graph vertex position
vardef G_V_position(suffix G)(expr idx) :=
	__graph_vertex_pos(G)(__get_id(idx))
enddef;

%% graph vertex path
vardef G_V_path(suffix G)(expr idx) :=
	__graph_vertex_path(G)(__get_id(idx))
enddef;

vardef G_vid_minmax(suffix G)(suffix min_vid, max_vid) :=
	min_vid := G.V.seq[1];
	max_vid := G.V.seq[1];

	save i; numeric i;
	for i := 2 upto G.V.num:
		save tmp; numeric tmp;
		tmp := G.V.seq[i];
		if tmp < min_vid:
			min_vid := tmp;
		fi;
		if tmp > max_vid:
			max_vid := tmp;
		fi;
	endfor;
enddef;

vardef G_vid_cnt(suffix G) :=
	G.V.num
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @ edge_fn: (suffix G)(expr sidx, eidx)
vardef graph_loop_edge(suffix G, edge_fn) :=
	save i;
	for i := 1 upto G.E.num:
		scantokens(edge_fn)(G)(xpart G.E.seq[i], ypart G.E.seq[i]);
	endfor;
enddef;

def graph_for_each_edge(suffix G)(suffix sid, eid) :=
	begingroup;
	save ____lv, sid, eid;
	numeric ____lv, sid, eid;
	for ____lv := 1 upto G.E.num:
		sid := xpart G.E.seq[____lv];
		eid := ypart G.E.seq[____lv]
enddef;

def graph_for_each_vertex(suffix G)(suffix vid) :=
	begingroup;
	save ____lv, vid;
	numeric ____lv, vid;
	for ____lv := 1 upto G.V.num:
		vid := G.V.seq[____lv];
enddef;

def graph_for_each_adj_vertex(suffix G)(expr uid)(suffix vid) :=
	begingroup;
	save vid; numeric vid;
	forever:
		exitif unknown G.V[uid]adj;
		if unknown vid:
			vid := G.V[uid]adj;
		else:
			vid := G.E[uid][vid]next;
		fi;
enddef;

def graph_endfor :=
	endfor;
	endgroup
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
