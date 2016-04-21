vardef __save_para_list@#(suffix G)(expr _paralist) :=
	string G@#.paratype[];
	string G@#.paraname[];
	numeric G@#.paranum;
	save token; string token; token := "";
	save plist; string plist; plist := _paralist & " ";
	save pidx; numeric pidx; pidx := -1;
	save i; numeric i;
	for i := 0 upto (length(plist) - 1):
		save singlechar; string singlechar;
		singlechar := substring(i,i+1)of plist;
		if (singlechar = " ") or (singlechar = ",") or (singlechar = "\t") or (singlechar = "\n"):
			if length(token) > 0:
				if (pidx mod 2) = 0:
					%message "parsing type " & decimal(pidx div 2) & ": " & token;
					G@#.paratype[pidx div 2] := token;
				elseif (pidx mod 2) = 1:
					%message "parsing name " & decimal(pidx div 2) & ": " & token;
					G@#.paraname[pidx div 2] := token;
				fi;
				token := "";
			fi;
		else:
			if token = "" : pidx := pidx + 1; fi;
			token := token & singlechar;
		fi;
	endfor;

	G@#.paranum := pidx div 2 + 1;
	%for i := 0 upto (pidx div 2):
	%	message "parse result: " & G@#.paratype[i] & " " & G@#.paraname[i];
	%endfor;
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% vertex extension %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef declare_graph_vertex_ext@#(suffix G)(expr _paralist):=
	boolean G@#.is_vertex; G@#.is_vertex := true;
	__save_para_list@#(G)(_paralist);
	save i; numeric i; i := 0;
	forever:
		exitif unknown G@#.paratype[i];
		exitif unknown G@#.paraname[i];
		scantokens(G@#.paratype[i]) G.V[]@#.scantokens(G@#.paraname[i]);
		i := i + 1;
	endfor;
enddef;

vardef __graph_vertex_remark(suffix G)(expr idx, vdegree, p) :=
	save position; pair position;
	position := __intersectionpoint(G)(idx, vdegree);
	p shifted __pic_shift(p, vdegree, position)
enddef;

vardef ____graph_set_vertex_ext@#(suffix G)(expr idx, _idx, _a) :=
	G.V[__get_id(idx)]@#.scantokens(G@#.paraname[_idx]) := _a;
enddef;

vardef __graph_set_vertex_ext_a@#(suffix G)(expr idx, _a) :=
	____graph_set_vertex_ext@#(G)(idx, 0, _a);
enddef;

vardef __graph_set_vertex_ext_b@#(suffix G)(expr idx, _a, _b) :=
	____graph_set_vertex_ext@#(G)(idx, 0, _a);
	____graph_set_vertex_ext@#(G)(idx, 1, _b);
enddef;

vardef __graph_set_vertex_ext_c@#(suffix G)(expr idx, _a, _b, _c) :=
	____graph_set_vertex_ext@#(G)(idx, 0, _a);
	____graph_set_vertex_ext@#(G)(idx, 1, _b);
	____graph_set_vertex_ext@#(G)(idx, 2, _c);
enddef;

vardef __graph_set_vertex_ext_d@#(suffix G)(expr idx, _a, _b, _c, _d) :=
	____graph_set_vertex_ext@#(G)(idx, 0, _a);
	____graph_set_vertex_ext@#(G)(idx, 1, _b);
	____graph_set_vertex_ext@#(G)(idx, 2, _c);
	____graph_set_vertex_ext@#(G)(idx, 3, _d);
enddef;

vardef __graph_set_vertex_ext_e@#(suffix G)(expr idx, _a, _b, _c, _d, _e) :=
	____graph_set_vertex_ext@#(G)(idx, 0, _a);
	____graph_set_vertex_ext@#(G)(idx, 1, _b);
	____graph_set_vertex_ext@#(G)(idx, 2, _c);
	____graph_set_vertex_ext@#(G)(idx, 3, _d);
	____graph_set_vertex_ext@#(G)(idx, 4, _e);
enddef;

vardef G_set_V@#(suffix G)(text abc)text _remain :=
	save pn; numeric pn; pn := G@#.paranum;
	if pn = 1:
		__graph_set_vertex_ext_a@#(G)(abc);
	elseif pn = 2:
		__graph_set_vertex_ext_b@#(G)(abc);
	elseif pn = 3:
		__graph_set_vertex_ext_c@#(G)(abc);
	elseif pn = 4:
		__graph_set_vertex_ext_d@#(G)(abc);
	elseif pn = 5:
		__graph_set_vertex_ext_e@#(G)(abc);
	else:
		message "graph extension: parameter number reached limit."
	fi;

	if not __emptytext(_remain) :
		G_set_V@#(G)_remain;
	fi;
enddef;

vardef GVext@#(text _list) :=
	; G_set_V@#(____G)(____VID, _list);
enddef;

vardef graph_vertex_ext@#(suffix G)(expr idx)(suffix _var) :=
	G.V[idx]@#._var
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% edge extension %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef declare_graph_edge_ext@#(suffix G)(expr _paralist):=
	boolean G@#.is_edge; G@#.is_edge := true;
	__save_para_list@#(G)(_paralist);
	save i; numeric i; i := 0;
	forever:
		exitif unknown G@#.paratype[i];
		exitif unknown G@#.paraname[i];
		scantokens(G@#.paratype[i]) G.E[][]@#.scantokens(G@#.paraname[i]);
		i := i + 1;
	endfor;
enddef;

vardef __graph_edge_remark(suffix G)(expr sidx, eidx, _pos, _deg, p) :=
	save _road; path _road;
	_road := __graph_edge_path(G)(sidx, eidx);
	save position; pair position;
	position := point (arctime ((arclength _road) * _pos) of _road) of _road;
	p shifted __pic_shift(p, _deg, position)
enddef;

vardef ____graph_set_edge_ext@#(suffix G)(expr seidx, _idx, _a) :=
	G.E[__get_sid(seidx)][__get_eid(seidx)]@#.scantokens(G@#.paraname[_idx]) := _a;
enddef;

vardef __graph_set_edge_ext_a@#(suffix G)(expr seidx, _a) :=
	____graph_set_edge_ext@#(G)(seidx, 0, _a);
enddef;

vardef __graph_set_edge_ext_b@#(suffix G)(expr seidx, _a, _b) :=
	____graph_set_edge_ext@#(G)(seidx, 0, _a);
	____graph_set_edge_ext@#(G)(seidx, 1, _b);
enddef;

vardef __graph_set_edge_ext_c@#(suffix G)(expr seidx, _a, _b, _c) :=
	____graph_set_edge_ext@#(G)(seidx, 0, _a);
	____graph_set_edge_ext@#(G)(seidx, 1, _b);
	____graph_set_edge_ext@#(G)(seidx, 2, _c);
enddef;

vardef __graph_set_edge_ext_d@#(suffix G)(expr seidx, _a, _b, _c, _d) :=
	____graph_set_edge_ext@#(G)(seidx, 0, _a);
	____graph_set_edge_ext@#(G)(seidx, 1, _b);
	____graph_set_edge_ext@#(G)(seidx, 2, _c);
	____graph_set_edge_ext@#(G)(seidx, 3, _d);
enddef;

vardef __graph_set_edge_ext_e@#(suffix G)(expr seidx, _a, _b, _c, _d, _e) :=
	____graph_set_edge_ext@#(G)(seidx, 0, _a);
	____graph_set_edge_ext@#(G)(seidx, 1, _b);
	____graph_set_edge_ext@#(G)(seidx, 2, _c);
	____graph_set_edge_ext@#(G)(seidx, 3, _d);
	____graph_set_edge_ext@#(G)(seidx, 4, _e);
enddef;

vardef G_set_E@#(suffix G)(text abc)text _remain :=
	save pn; numeric pn; pn := G@#.paranum;
	if pn = 1:
		__graph_set_edge_ext_a@#(G)(abc);
	elseif pn = 2:
		__graph_set_edge_ext_b@#(G)(abc);
	elseif pn = 3:
		__graph_set_edge_ext_c@#(G)(abc);
	elseif pn = 4:
		__graph_set_edge_ext_d@#(G)(abc);
	elseif pn = 5:
		__graph_set_edge_ext_e@#(G)(abc);
	else:
		message "graph extension: parameter number reached limit."
	fi;

	if not __emptytext(_remain) :
		G_set_E@#(G)_remain;
	fi;
enddef;

vardef GEext@#(text _list) :=
	; G_set_E@#(____G)(____EID, _list);
enddef;

vardef graph_edge_ext@#(suffix G)(expr sidx, eidx)(suffix _var) :=
	G.E[sidx][eidx]@#._var
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef G_set_ext@#(suffix G)(text abc) text _remain :=
	if known G@#.is_edge:
		G_set_E@#(G)(abc);
	else:
		G_set_V@#(G)(abc);
	fi;
	if not __emptytext(_remain) :=
		G_set_ext@#(G)(abc);
	fi;
enddef;

vardef Gext@#(text _list) :=
	if known G@#.is_edge:
		GEext@#(_list);
	else:
		GVext@#(_list);
	fi
enddef;
