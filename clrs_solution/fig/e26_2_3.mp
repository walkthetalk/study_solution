input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;
input clrs_graph_FLOW;

%% global data
declare_graph(G, true, false, 2cm, fullcircle scaled .5cm);
declare_graph_FLOW(G);

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

vardef COPY_WEIGHT_MATRIX(suffix G)(suffix L) :=
	save min_vid, max_vid; numeric min_vid, max_vid;
	G_vid_minmax(G)(min_vid, max_vid);

	save i,j; numeric i,j;
	for i := min_vid upto max_vid:
		for j := min_vid upto max_vid:
			if i = j:
				L[i][j] := 0;
			elseif known graph_edge_ext.edge_weight(G)(i,j)(weight):
				L[i][j] := graph_edge_ext.edge_weight(G)(i,j)(weight);
			else:
				L[i][j] := 0;
			fi;
		endfor;
	endfor;
enddef;

vardef BFS(suffix G, M)(suffix P)(expr sid, eid) :=
	%message "BFS enter";
	P[sid] := eid;
	save ret; boolean ret; ret := false;
	save remainvertex; numeric remainvertex; remainvertex := G_vid_cnt(G) - 1;
	forever:
		save newv; boolean newv; newv := false;
		graph_for_each_vertex(G)(vid)(
			if (remainvertex > 0) and (not ret):
				if known P[vid]:
					graph_for_each_adj_vertex(G)(vid)(adjid)(
						if (remainvertex > 0) and (not ret):
							if M[vid][adjid] > 0:
								if unknown P[adjid]:
									P[adjid] := vid;
									remainvertex := remainvertex - 1;
									if adjid = eid:
										ret := true;
									fi;
									newv := true;
								fi;
							fi;
						fi;
					);
				fi;
			fi;
		);
		exitif not newv;
		%message "remain is " & decimal(remainvertex);
		exitif remainvertex = 0;
		%message "remain is " & decimal(remainvertex) & "----";
	endfor;
	%message "BFS return";

	ret
enddef;

vardef img_main(suffix G)(suffix flow) :=
image(
	graph_for_each_vertex(G)(sidx)(
		graph_for_each_vertex(G)(eidx)(
			if known flow[sidx][eidx]:
				if flow[sidx][eidx] > 0:
					G_VAR(G, flow)(sidx, eidx)(flow) := flow[sidx][eidx];
				fi;
			fi;
		);
	);

	draw graph_img(G);
)
enddef;

def draw_img_main(suffix G)(suffix flow) :=
	beginfig(glb_img_idx);
	draw img_main(G)(flow);
	endfig;
	glb_img_idx := glb_img_idx + 1;
enddef;


vardef img_flow(suffix G)(suffix M)(suffix P)(expr sidx, eidx) :=
image(
	save Gp;
	declare_graph(Gp, true, false, 2cm, fullcircle scaled .5cm);
	declare_graph_EDGEWEIGHT(Gp);
	Gp.edge_remark_by_edge_dir := true;

	graph_for_each_vertex(G)(vid)(
		G_auto_V(Gp) vid Gposition G.V[vid]pos  if known G.V[vid]id: Gid G.V[vid]id fi;
	);

	graph_for_each_vertex(Gp)(sid)(
		graph_for_each_vertex(Gp)(eid)(
			if M[sid][eid] > 0:
				G_auto_E(Gp) (sid,eid)
					if M[eid][sid] > 0: Gpath (15,-15) fi
					Gdisp(edge_weight) (0.5,  if (xpart G.V[sid]pos) < (xpart G.V[eid]pos):
							90
						else:
							-90
						fi)
					Gdata(edge_weight) (M[sid][eid]);
			fi;
		);
	);

	save tmpid; numeric tmpid; tmpid := eidx;
	forever:
		exitif unknown P[tmpid];
		%if known P[tmpid]:
			%if __graph_has_edge(G)(P[vid], vid):
			draw G_E_link(Gp)(P[tmpid], tmpid) withpen pencircle scaled 5bp withcolor .8white;
			%fi;
		%fi;
		exitif P[tmpid] = sidx;
		tmpid := P[tmpid];
	endfor;
	draw graph_img(Gp);
)
enddef;

numeric glb_img_idx;
glb_img_idx := 2;
def draw_img_flow(suffix G)(suffix M)(suffix P)(expr sid, eid) :=
	beginfig(glb_img_idx);
	draw img_flow(G)(M)(P)(sid, eid);
	endfig;
	glb_img_idx := glb_img_idx + 1;
enddef;

vardef FORD_FULKENSON(suffix G)(expr sid, eid) :=
	save flow; numeric flow[][];
	graph_for_each_edge(G)(sidx, eidx)(
		flow[sidx][eidx] := 0;
	);
	save cap; numeric cap[][];
	COPY_WEIGHT_MATRIX(G)(cap);

	forever:
		%message "main loop";
		save P; numeric P[];
		save founded; boolean founded;
		%message "main loop start BFS";
		founded := BFS(G, cap)(P)(sid, eid);
			draw_img_flow(G)(cap)(P)(sid, eid);
		%message "main loop stop BFS";
		exitif not founded;
		save minc; numeric minc;
		save eidx; numeric eidx;
		eidx := eid;
		%message "path is ++++++++++++++++++++++++++++ for " & decimal(eidx);
		forever:
			exitif eidx = sid;
			save sidx; numeric sidx; sidx := P[eidx];
			%message "        " & decimal(sidx);

			if unknown minc:
				minc := cap[sidx][eidx];
			elseif cap[sidx][eidx] < minc:
				minc := cap[sidx][eidx];
			fi;

			eidx := sidx;
		endfor;
		%message "minc is " & decimal(minc);
		eidx := eid;
		forever:
			exitif eidx = sid;
			save sidx; numeric sidx; sidx := P[eidx];
			%message "loop path -- " & decimal(sidx) & "," & decimal(eidx) & " test";

			if __graph_has_edge(G)(sidx, eidx):
				%message "add------------------";
				flow[sidx][eidx] := flow[sidx][eidx] + minc;
				cap[sidx][eidx] := cap[sidx][eidx] - minc;
				cap[eidx][sidx] := cap[eidx][sidx] + minc;
				%message "+++++++++++++++++++";
				%message "            " & decimal(sidx) & "," & decimal(eidx) & ": --- "
				%	& decimal(flow[sidx][eidx]) & "," & decimal(cap[sidx][eidx]) & "," & decimal(cap[eidx][sidx]);
				%message "********************";
			else:
				%message "remove---------------";
				flow[eidx][sidx] := flow[eidx][sidx] - minc;
				cap[eidx][sidx] := cap[eidx][sidx] + minc;
				cap[sidx][eidx] := cap[sidx][eidx] - minc;
				%message "            " & decimal(eidx) & "," & decimal(sidx) & ": --- "
				%	& decimal(flow[eidx][sidx]) & "," & decimal(cap[eidx][sidx]) & "," & decimal(cap[sidx][eidx]);
			fi;

			%message "next edge";
			eidx := sidx;
		endfor;
				draw_img_main(G)(flow);
	endfor;

	%draw_img_main(G)(flow);
enddef;

beginfig(1);
draw graph_img(G);
endfig;

FORD_FULKENSON(G)(0,5);

end;
