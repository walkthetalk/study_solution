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

vardef declare_graph_vertex_ext_with_disp@#(suffix G)(expr _paralist):=
	declare_graph_vertex_ext@#(G)("numeric deg, " & _paralist);
	numeric G@#.data_offset; G@#.data_offset := 1;
enddef;

vardef __graph_vertex_remark(suffix G)(expr idx, vdegree, p) :=
	save position; pair position;
	position := __intersectionpoint(G)(idx, vdegree);
	p shifted __pic_shift(p, vdegree, position, 0)
enddef;

vardef ____graph_set_vertex_ext@#(suffix G)(expr idx, _idx, _a) :=
	G.V[__get_id(idx)]@#.scantokens(G@#.paraname[_idx]) := _a;
enddef;

vardef __graph_set_vertex_ext_a@#(suffix G)(expr pid_off, idx, _a) :=
	____graph_set_vertex_ext@#(G)(idx, pid_off + 0, _a);
enddef;

vardef __graph_set_vertex_ext_b@#(suffix G)(expr pid_off, idx, _a, _b) :=
	____graph_set_vertex_ext@#(G)(idx, pid_off + 0, _a);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 1, _b);
enddef;

vardef __graph_set_vertex_ext_c@#(suffix G)(expr pid_off, idx, _a, _b, _c) :=
	____graph_set_vertex_ext@#(G)(idx, pid_off + 0, _a);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 1, _b);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 2, _c);
enddef;

vardef __graph_set_vertex_ext_d@#(suffix G)(expr pid_off, idx, _a, _b, _c, _d) :=
	____graph_set_vertex_ext@#(G)(idx, pid_off + 0, _a);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 1, _b);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 2, _c);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 3, _d);
enddef;

vardef __graph_set_vertex_ext_e@#(suffix G)(expr pid_off, idx, _a, _b, _c, _d, _e) :=
	____graph_set_vertex_ext@#(G)(idx, pid_off + 0, _a);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 1, _b);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 2, _c);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 3, _d);
	____graph_set_vertex_ext@#(G)(idx, pid_off + 4, _e);
enddef;

vardef __G_set_V@#(suffix G)(expr pid_off, pid_num)(text abc)text _remain :=
	if pid_num = 1:
		__graph_set_vertex_ext_a@#(G)(pid_off, abc);
	elseif pid_num = 2:
		__graph_set_vertex_ext_b@#(G)(pid_off, abc);
	elseif pid_num = 3:
		__graph_set_vertex_ext_c@#(G)(pid_off, abc);
	elseif pid_num = 4:
		__graph_set_vertex_ext_d@#(G)(pid_off, abc);
	elseif pid_num = 5:
		__graph_set_vertex_ext_e@#(G)(pid_off, abc);
	else:
		message "graph extension: parameter number reached limit."
	fi;

	if not __emptytext(_remain) :
		__G_set_V@#(G)(pid_off, pid_num)_remain;
	fi;
enddef;

vardef G_set_V@#(suffix G)(text abc)text _remain :=
	__G_set_V@#(G)(0, G@#.paranum)(abc)_remain;
enddef;

vardef G_set_Vdisp@#(suffix G)(text abc)text _remain :=
	if known G@#.data_offset:
		__G_set_V@#(G)(0, G@#.data_offset)(abc)_remain;
	else:
		errmessage "graph extension: no default disp info, please use G_set_V@#";
	fi;
enddef;

vardef G_set_Vdata@#(suffix G)(text abc)text _remain :=
	if known G@#.data_offset:
		__G_set_V@#(G)(G@#.data_offset, G@#.paranum - G@#.data_offset)(abc)_remain;
	else:
		__G_set_V@#(G)(0, G@#.paranum)(abc)_remain;
	fi;
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

vardef declare_graph_edge_ext_with_disp@#(suffix G)(expr _paralist):=
	declare_graph_edge_ext@#(G)("numeric position, numeric deg, " & _paralist);
	numeric G@#.data_offset; G@#.data_offset := 2;
enddef;

vardef __graph_edge_remark(suffix G)(expr sidx, eidx, _pos, _deg, p) :=
	save _road; path _road;
	_road := __graph_edge_path(G)(sidx, eidx);
	save position; pair position;
	position := point (arctime ((arclength _road) * _pos) of _road) of _road;
	if G.edge_remark_by_edge_dir:
		save tmp; numeric tmp;
		tmp := angle (direction (arctime ((arclength _road) * _pos) of _road) of _road);
		if tmp < 0: tmp := tmp + 360; fi;
		if (tmp > 90) and (tmp < 270):
			tmp := tmp - 180;
		fi;
		if tmp < 0: tmp := tmp + 360; fi;
		%message decimal(sidx) & "," & decimal(eidx) & ": " & decimal(_pos) & "-" & decimal(_deg) & "-" & decimal(tmp);
		(p rotated tmp) shifted __pic_shift(p, _deg, position, tmp)
	else:
		%message decimal(sidx) & "," & decimal(eidx) & ": " & decimal(_pos) & "-" & decimal(_deg) & "-" & decimal(0);
		p shifted __pic_shift(p, _deg, position, 0)
	fi
enddef;


vardef ____graph_set_edge_ext@#(suffix G)(expr seidx, _idx, _a) :=
	G.E[__get_sid(seidx)][__get_eid(seidx)]@#.scantokens(G@#.paraname[_idx]) := _a;
enddef;

vardef __graph_set_edge_ext_a@#(suffix G)(expr pid_off, seidx, _a) :=
	____graph_set_edge_ext@#(G)(seidx, pid_off + 0, _a);
enddef;

vardef __graph_set_edge_ext_b@#(suffix G)(expr pid_off, seidx, _a, _b) :=
	____graph_set_edge_ext@#(G)(seidx, pid_off + 0, _a);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 1, _b);
enddef;

vardef __graph_set_edge_ext_c@#(suffix G)(expr pid_off, seidx, _a, _b, _c) :=
	____graph_set_edge_ext@#(G)(seidx, pid_off + 0, _a);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 1, _b);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 2, _c);
enddef;

vardef __graph_set_edge_ext_d@#(suffix G)(expr pid_off, seidx, _a, _b, _c, _d) :=
	____graph_set_edge_ext@#(G)(seidx, pid_off + 0, _a);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 1, _b);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 2, _c);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 3, _d);
enddef;

vardef __graph_set_edge_ext_e@#(suffix G)(expr pid_off, seidx, _a, _b, _c, _d, _e) :=
	____graph_set_edge_ext@#(G)(seidx, pid_off + 0, _a);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 1, _b);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 2, _c);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 3, _d);
	____graph_set_edge_ext@#(G)(seidx, pid_off + 4, _e);
enddef;

vardef __G_set_E@#(suffix G)(expr pid_off, pid_num)(text abc)text _remain :=
	if pid_num = 1:
		__graph_set_edge_ext_a@#(G)(pid_off, abc);
	elseif pid_num = 2:
		__graph_set_edge_ext_b@#(G)(pid_off, abc);
	elseif pid_num = 3:
		__graph_set_edge_ext_c@#(G)(pid_off, abc);
	elseif pid_num = 4:
		__graph_set_edge_ext_d@#(G)(pid_off, abc);
	elseif pid_num = 5:
		__graph_set_edge_ext_e@#(G)(pid_off, abc);
	else:
		message "graph extension: parameter number reached limit."
	fi;

	if not __emptytext(_remain) :
		__G_set_E@#(G)(pid_off, pid_num)_remain;
	fi;
enddef;

vardef G_set_E@#(suffix G)(text abc)text _remain :=
	__G_set_E@#(G)(0, G@#.paranum)(abc)_remain;
enddef;

vardef G_set_Edisp@#(suffix G)(text abc)text _remain :=
	if known G@#.data_offset:
		__G_set_E@#(G)(0, G@#.data_offset)(abc)_remain;
	else:
		errmessage "graph extension: no default disp info, please use G_set_E@#";
	fi;
enddef;

vardef G_set_Edata@#(suffix G)(text abc)text _remain :=
	if known G@#.data_offset:
		__G_set_E@#(G)(G@#.data_offset, G@#.paranum - G@#.data_offset)(abc)_remain;
	else:
		__G_set_E@#(G)(0, G@#.paranum)(abc)_remain;
	fi;
enddef;

vardef graph_edge_ext@#(suffix G)(expr sidx, eidx)(suffix _var) :=
	G.E[sidx][eidx]@#._var
enddef;

def G_VAR(suffix G, ext)(expr sidx, eidx)(suffix _var) :=
	G.E[sidx][eidx]ext._var
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef G_set_ext@#(suffix G)(text abc) text _remain :=
	if known G@#.is_edge:
		G_set_E@#(G)(abc) _remain;
	else:
		G_set_V@#(G)(abc) _remain;
	fi;
enddef;

def Gext(suffix ext)(text _list) :=
	if known G.ext.is_edge:
		G_set_E.ext(____G)(____EID, _list);
	else:
		G_set_V.ext(____G)(____VID, _list);
	fi
enddef;

def Gdisp(suffix ext)(text _list) :=
	if known G.ext.is_edge:
		G_set_Edisp.ext(____G)(____EID, _list);
	else:
		G_set_Vdisp.ext(____G)(____VID, _list);
	fi
enddef;

def Gdata(suffix ext)(text _list) :=
	if known G.ext.is_edge:
		G_set_Edata.ext(____G)(____EID, _list);
	else:
		G_set_Vdata.ext(____G)(____VID, _list);
	fi
enddef;
