input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;
input clrs_graph_FLOW;

%% global data
declare_graph(G, true, false, 2cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) 0 Gposition (0,0)   Gid "s";
G_auto_V(G) 1 Gposition (1,0.5);
G_auto_V(G) 2 Gposition (1,-0.5);
G_auto_V(G) 3 Gposition (2,0.5);
G_auto_V(G) 4 Gposition (2,-0.5);
G_auto_V(G) 5 Gposition (3,0)   Gid "t";

G_auto_E(G) (0,1) Gdisp(edge_weight) (0.5,  135) Gdata(edge_weight) (16);
G_auto_E(G) (1,3) Gdisp(edge_weight) (0.5,   90) Gdata(edge_weight) (12);
G_auto_E(G) (3,5) Gdisp(edge_weight) (0.5,   45) Gdata(edge_weight) (20);
G_auto_E(G) (0,2) Gdisp(edge_weight) (0.5, -135) Gdata(edge_weight) (13);
G_auto_E(G) (2,1) Gdisp(edge_weight) (0.5,  180) Gdata(edge_weight) ( 4);
G_auto_E(G) (3,2) Gdisp(edge_weight) (0.5,  -45) Gdata(edge_weight) ( 9);
G_auto_E(G) (2,4) Gdisp(edge_weight) (0.5,  -90) Gdata(edge_weight) (14);
G_auto_E(G) (4,3) Gdisp(edge_weight) (0.5,    0) Gdata(edge_weight) ( 7);
G_auto_E(G) (4,5) Gdisp(edge_weight) (0.5,  -45) Gdata(edge_weight) ( 4);

numeric G.V[]height;
numeric G.V[]extra;
numeric G.E[][]flow;
numeric G.V[]current;

numeric NIL; NIL := -1;

vardef INITIALIZE_PREFLOW(suffix G)(expr s) :=
	graph_for_each_vertex(G)(vid)(
		G.V[vid]height := 0;
		G.V[vid]extra := 0;
		G.V[vid]current := NIL;
	);
	graph_for_each_edge(G)(sidx, eidx)(
		G.E[sidx][eidx]flow := 0;
	);
	G.V[s]height := G.V.num;
	graph_for_each_adj_vertex(G)(s)(adjid)(
		save cap; numeric cap; cap := graph_edge_ext.edge_weight(G)(s,adjid)(weight);
		G.E[s][adjid]flow := cap;
		G.V[adjid]extra := cap;
		G.V[s]extra := G.V[s]extra - cap;
	);
enddef;

vardef CF(suffix G)(expr uidx, vidx) :=
	if __graph_has_edge(G)(uidx, vidx):
		(graph_edge_ext.edge_weight(G)(uidx,vidx)(weight) - G.E[uidx][vidx]flow)
	elseif __graph_has_edge(G)(vidx, uidx):
		G.E[vidx][uidx]flow
	else:
		0
	fi
enddef;

vardef PUSH(suffix G)(expr uidx, vidx) :=
	%message "PUSH " & decimal(uidx) & ", " & decimal(vidx);
	save delta; numeric delta; delta := min(G.V[uidx]extra, CF(G)(uidx,vidx));
	%message "PUSH " & decimal(uidx) & ", " & decimal(vidx) & ": " & decimal(delta);
	if __graph_has_edge(G)(uidx, vidx):
		G.E[uidx][vidx]flow := G.E[uidx][vidx]flow + delta;
	else:
		G.E[vidx][uidx]flow := G.E[vidx][uidx]flow - delta;
	fi;
	G.V[uidx]extra := G.V[uidx]extra - delta;
	G.V[vidx]extra := G.V[vidx]extra + delta;
	%message "exit PUSH";
enddef;

vardef RELABEL(suffix G)(expr uidx) :=
	save tmp; numeric tmp;
	graph_for_each_vertex(G)(vidx)(
		%message "relabel test " & decimal(uidx) & ", " & decimal(vidx);
		if __graph_has_edge(G)(uidx, vidx):
			save __w; numeric __w; __w := graph_edge_ext.edge_weight(G)(uidx, vidx)(weight);
			save __f; numeric __f; __f := G.E[uidx][vidx]flow;
			if __w > __f:
				if unknown tmp:
					tmp := G.V[vidx]height;
				elseif G.V[vidx]height < tmp:
					tmp := G.V[vidx]height;
				fi;
			fi;
		elseif __graph_has_edge(G)(vidx, uidx):
			save __f; numeric __f; __f := G.E[vidx][uidx]flow;
			if __f > 0:
				if unknown tmp:
					tmp := G.V[vidx]height;
				elseif G.V[vidx]height < tmp:
					tmp := G.V[vidx]height;
				fi;
			fi;
		fi;
	);
	%message "relabel " & decimal(uidx) & ", min is " & decimal(tmp);
	G.V[uidx]height := tmp + 1;
enddef;

numeric G.V[]uadj;
numeric G.E[][]unext;
vardef INIT_N(suffix G) :=
	save minvid, maxvid; numeric maxvid, minvid;
	G_vid_minmax(G)(minvid, maxvid);
	save i;
	for i := minvid upto maxvid:
		G.V[i]uadj := NIL;
	endfor;
	if false:
		graph_for_each_edge(G)(sid, eid)(
			G.E[sid][eid]unext := G.V[sid]uadj;
			G.V[sid]uadj := eid;

			G.E[eid][sid]unext := G.V[eid]uadj;
			G.V[eid]uadj := sid;
		);
	else:
		save i,j;
		for i := maxvid downto minvid:
			for j := maxvid downto minvid:
				if __graph_has_edge(G)(i, j) or __graph_has_edge(G)(j,i):
					G.E[i][j]unext := G.V[i]uadj;
					G.V[i]uadj := j;
				fi;
			endfor;
		endfor;
	fi;
enddef;

vardef DISCHARGE(suffix G)(expr uidx) :=
	forever:
		%message "for DISCHARGE " & decimal(G.V[uidx]extra);
		%message "for DISCHARGE2";
		exitif (G.V[uidx]extra = 0);
		%message "for DISCHARGE3";
		save vidx; numeric vidx; vidx := G.V[uidx]current;
		%message "DISCHARGE " & decimal(uidx) & ", " & decimal(vidx);
		if vidx = NIL:
			%message "      DISCHARGE case 1";
			RELABEL(G)(uidx);
			G.V[uidx]current := G.V[uidx]uadj;
		elseif (CF(G)(uidx, vidx) > 0) and (G.V[uidx]height = (G.V[vidx]height + 1)):
			%message "      DISCHARGE case 2";
			PUSH(G)(uidx, vidx);
			%message "      DISCHARGE case 2 end";
		else:
			%message "      DISCHARGE case 3";
			G.V[uidx]current := G.E[uidx][vidx]unext;
			%message "      DISCHARGE case 3 end";
		fi;
	endfor;
	%message "exit of DISCHARGE";
enddef;

vardef RELABE_TO_FRONT(suffix G)(expr s, t) :=
	INIT_N(G);
	INITIALIZE_PREFLOW(G)(s);
	save L;
	numeric L[]; numeric L.head, L.current; L.head := NIL; L.current := NIL;
	graph_for_each_vertex(G)(vidx)(
		if (vidx <> s) and (vidx <> t):
			if L.current = NIL:
				L.head := vidx;
			else:
				L[L.current] := vidx;
			fi;
			L.current := vidx;
			L[vidx] := NIL;
			G.V[vidx]current := G.V[vidx]uadj;
		fi;
	);
	L.current := NIL;
	DRAW_HEIGHT(G)(L);
	save uidx; numeric uidx; uidx := L.head;
	forever:
		exitif uidx = NIL;
		save old_height; numeric old_height; old_height := G.V[uidx]height;
		%message "processing vertex " & decimal(uidx);
		DISCHARGE(G)(uidx);
		%message "processing vertex " & decimal(uidx) & " end";
		%message "processing vertex " & decimal(uidx) & " end  fdadfadfad";
		if (G.V[uidx]height > old_height):
			L.current := uidx;	% only for draw
			DRAW_HEIGHT(G)(L);
			if  (uidx <> L.head):
				% move u to the front of list L
				save tmp; numeric tmp; tmp := L.head;
				forever:
					exitif L[tmp] = uidx;
					tmp := L[tmp];
				endfor;
				L[tmp] := L[uidx];
				L[uidx] := L.head;
				L.head := uidx;
			fi;
		fi;
		% loop next
		uidx := L[uidx];
	endfor;
	DRAW_HEIGHT(G)(L);
enddef;

vardef img_HEIGHT(suffix G)(suffix L) :=
image(
	save minvid, maxvid; numeric minvid, maxvid;
	G_vid_minmax(G)(minvid, maxvid);
	save _hsize; numeric _hsize; _hsize := .8G.gsize;
	save _hxsize, _hysize; numeric _hxsize, _hysize;
	_hxsize := _hsize; _hysize := .5_hsize;
	save i;
	for i := 0 upto (G.V.num + 1):
		draw ((minvid, i) -- (maxvid, i)) xscaled _hxsize yscaled _hysize withcolor .8white;
	endfor;

	save VPOS; pair VPOS[];
	save VCORD; pair VCORD[];
	save VGRID; numeric VGRID[][];

	save _frame; path _frame; _frame := G.frame scaled 1.5;
	graph_for_each_vertex(G)(vid)(
		VCORD[vid] := (vid, G.V[vid]height);
		VGRID[vid][G.V[vid]height] := vid;
		VPOS[vid] := VCORD[vid] xscaled _hxsize yscaled _hysize;
		draw _frame shifted VPOS[vid];
		fill _frame shifted VPOS[vid] withcolor white;
		label.top(TEX(__vertex_idstr(G)(vid)), VPOS[vid] - (0,2bp));
		label.bot(TEX(decimal(G.V[vid]extra)), VPOS[vid] + (0,2bp));
	);

	save basedeg; numeric basedeg; basedeg := 20;
	save incdeg; numeric incdeg; incdeg := 10;
	save EPATH; path EPATH[][];
	graph_for_each_edge(G)(sid, eid)(
		save spos, epos; pair spos, epos; spos := VPOS[sid]; epos := VPOS[eid];
		save oridir; pair oridir; oridir := epos - spos;
		save deg; numeric deg; deg := angle(epos - spos);
		if deg >= 360:
			deg := deg - 360;
		elseif deg < 0:
			deg := deg + 360;
		fi;

		save sdeg, edeg; numeric sdeg, edeg;
		if G.V[sid]height = G.V[eid]height:
			if abs(sid - eid) <> 1:
				sdeg := -(basedeg + (eid - sid) * incdeg);
				edeg := -sdeg;
			elseif sid < eid:
				sdeg := 0;
				edeg := 0;
			elseif not __graph_has_edge(G)(eid, sid):
				sdeg := 0;
				edeg := 0;
			else:
				sdeg := (basedeg + (eid - sid) * incdeg);
				edeg := -sdeg;
			fi;
		else:
			save lid, rid; numeric lid,rid;
			save lheight,rheight; numeric lheight,rheight;
			lid := min(sid,eid); rid := max(sid,eid);
			lheight := G.V[lid]height; rheight := G.V[rid]height;
			save _topn, _botn, _cn; numeric _topn, _botn, _cn; _topn := 0; _botn := 0; _cn := 0;
			save k; numeric k;
			for k := (lid + 1) upto (rid - 1):
				save _tmph; numeric _tmph;
				_tmph := (k - lid) / (rid - lid) * (rheight - lheight) + lheight;
				save _floor, _ceiling; numeric _floor, _ceiling;
				_floor := floor(_tmph); _ceiling := ceiling(_tmph);
				if _floor = _tmph:
					_floor := _floor - 1;
				fi;
				if _ceiling = _tmph:
					_ceiling := _ceiling + 1;
				fi;
				if known VGRID[k][_floor]:
					if _floor = _tmph:
						_cn := _cn + 1;
					else:
						_botn := _botn + 1;
					fi;
				elseif known VGRID[k][_ceiling]:
					if _ceiling = _tmph:
						_cn := _cn + 1;
					else:
						_topn := _topn + 1;
					fi;
				fi;
			endfor;
			if (_cn = 0) and (_botn = 0) and (_topn = 0):
				sdeg := 0;
				edeg := 0;
			elseif _botn <> 0:
				if (deg < 90) or (deg > 270):
					sdeg = 30;
				else:
					sdeg := -30;
				fi;
				if _topn <> 0:
					sdeg := sdeg + 20;
				elseif _cn <> 0:
					sdeg := sdeg + 10;
				fi;
				edeg := -sdeg;
			elseif _topn <> 0:
				if (deg < 90) or (deg > 270):
					sdeg = -30;
				else:
					sdeg := 30;
				fi;
				if _botn <> 0:
					sdeg := sdeg - 20;
				elseif _cn <> 0:
					sdeg := sdeg - 10;
				fi;
				edeg := -sdeg;
			else: % _cn <> 0 and _botn = 0 and _topn = 0
				if (deg < 90) or (deg > 270):
					sdeg = -30;
				else:
					sdeg := 30;
				fi;
				edeg := -sdeg;
			fi;

			if (sid = 1) and (eid = 3):
				message "cn = " & decimal(_cn) & ", topn = " & decimal(_topn) & ", botn = " & decimal(_botn);
			fi;
		fi;
		%message "sdeg = " & decimal(sdeg) & ", edeg = " & decimal(edeg);
		EPATH[sid][eid] := (spos{oridir rotated sdeg}..{oridir rotated edeg}epos)
				cutbefore (_frame shifted spos) cutafter (_frame shifted epos);

		save _ecolor; color _ecolor;
		if G.E[sid][eid]flow > 0:
			_ecolor := black;
		else:
			_ecolor := .5white;
		fi;
		drawarrow EPATH[sid][eid] withcolor _ecolor;

		save _estr; string _estr;
		if G.E[sid][eid]flow > 0:
			_estr := "$ " & decimal(G.E[sid][eid]flow) & "\over " & decimal(graph_edge_ext.edge_weight(G)(sid, eid)(weight)) & "$";
		else:
			_estr := "$" & decimal(graph_edge_ext.edge_weight(G)(sid, eid)(weight)) & "$";
		fi;

		save position; pair position;
		position := point (arctime ((arclength EPATH[sid][eid]) * 0.5) of EPATH[sid][eid]) of EPATH[sid][eid];
		save _edir; string _edir;
		if (G.V[sid]height = G.V[eid]height):
			if sid < eid:
				_edir := "bot";
			else:
				_edir := "top";
			fi;
		else:
			if (deg > 0) and (deg < 90):
				if sdeg > 0: _edir := "ulft"; else: _edir := "lrt"; fi;
			elseif (deg > 90) and (deg < 180):
				if sdeg > 0: _edir := "llft"; else: _edir := "urt"; fi;
			elseif (deg > 180) and (deg < 270):
				if sdeg < 0: _edir := "ulft"; else: _edir := "lrt"; fi;
			else:
				if sdeg < 0: _edir := "llft"; else: _edir := "urt"; fi;
			fi;
		fi;
		label.scantokens(_edir)(TEX(_estr), position) withcolor _ecolor;
	);

	save listsize; numeric listsize; listsize := G.gsize / 3;
	save xip, yip; numeric xip, yip;
	xip := (maxvid + 1) * _hsize;
	yip := G.V.num * _hsize / 2;
	label(TEX("L:"), (xip - listsize, yip + listsize));
	label(TEX("N:"), (xip - listsize, yip));
	draw (xip - 1.5 listsize, yip + .5 listsize)--(xip + listsize * (G.V.num - 2.5), yip + .5 listsize);
	save xpos; numeric xpos; xpos := xip;
	save vid; numeric vid; vid := L.head;
	forever:
		exitif vid = NIL;
		save ypos; numeric ypos;
		ypos := yip;
		if L.current = vid:
			fill fullcircle scaled .75listsize shifted (xpos, ypos + listsize) withcolor .8white;
		fi;
		label(TEX(__vertex_idstr(G)(vid)), (xpos, ypos + listsize));
		save tmp; numeric tmp; tmp := G.V[vid]uadj;
		forever:
			%message "i = " & decimal(vid) & ", next = " & decimal(tmp);
			exitif tmp = NIL;
			if G.V[vid]current = tmp:
				fill fullcircle scaled .75listsize shifted (xpos, ypos) withcolor .8white;
			fi;
			label(TEX(__vertex_idstr(G)(tmp)), (xpos, ypos));
			ypos := ypos - listsize;
			tmp := G.E[vid][tmp]unext;
		endfor;
		xpos := xpos + listsize;
		vid := L[vid];
	endfor;;
)
enddef;

save figidx; numeric figidx; figidx := 2;
vardef DRAW_HEIGHT(suffix G)(suffix L) :=
	beginfig(figidx);
	draw img_HEIGHT(G)(L);
	endfig;
	figidx := figidx + 1;
enddef;

beginfig(1);
draw graph_img(G);
endfig;

RELABE_TO_FRONT(G)(0, 5);

end;
