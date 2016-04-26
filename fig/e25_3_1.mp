input clrs_graph;
input clrs_graph_extension;
input clrs_graph_EDGEWEIGHT;

%% global data
declare_graph(G, true, false, 2cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(G);

G_auto_V(G) 1 Gposition (0,0);
G_auto_V(G) 2 Gposition (1,0);
G_auto_V(G) 3 Gposition (2,0);
G_auto_V(G) 4 Gposition (0,-1);
G_auto_V(G) 5 Gposition (1,-1);
G_auto_V(G) 6 Gposition (2,-1);

G_auto_E(G) (2,1) Gdisp(edge_weight) (0.5,  90) Gdata(edge_weight) (1);
G_auto_E(G) (3,2) Gdisp(edge_weight) (0.5,  90) Gdata(edge_weight) (2);
G_auto_E(G) (4,1) Gdisp(edge_weight) (0.5, 180) Gdata(edge_weight) (-4);
G_auto_E(G) (1,5) Gdisp(edge_weight) (0.8,  45) Gdata(edge_weight) (-1);
G_auto_E(G) (2,4) Gdisp(edge_weight) (0.8, 135) Gdata(edge_weight) (2);
G_auto_E(G) (4,5) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (3);
G_auto_E(G) (5,2) Gdisp(edge_weight) (0.5,   0) Gdata(edge_weight) (7);
G_auto_E(G) (6,2) Gdisp(edge_weight) (0.5,-135) Gdata(edge_weight) (5);
G_auto_E(G) (6,3) Gpath (30,-30) Gdisp(edge_weight) (0.8, 180) Gdata(edge_weight) (10);
G_auto_E(G) (3,6) Gpath (30,-30) Gdisp(edge_weight) (0.5,   0) Gdata(edge_weight) (-8);


declare_graph(Gp, true, false, 2cm, fullcircle scaled .5cm);
declare_graph_EDGEWEIGHT(Gp);

G_auto_V(Gp) 0 Gposition (-1, -0.5);

G_auto_V(Gp) 1 Gposition (0,0);
G_auto_V(Gp) 2 Gposition (1,0);
G_auto_V(Gp) 3 Gposition (2,0);
G_auto_V(Gp) 4 Gposition (0,-1);
G_auto_V(Gp) 5 Gposition (1,-1);
G_auto_V(Gp) 6 Gposition (2,-1);

G_auto_E(Gp) (0,1) Gpath (10, -10) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (0);
G_auto_E(Gp) (0,2) Gpath (20, -30) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (0);
G_auto_E(Gp) (0,3) Gpath (30, -60) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (0);
G_auto_E(Gp) (0,4) Gpath (10, -10) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (0);
G_auto_E(Gp) (0,5) Gpath (20, -30) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (0);
G_auto_E(Gp) (0,6) Gpath (30, -60) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (0);

G_auto_E(Gp) (2,1) Gdisp(edge_weight) (0.5,  90) Gdata(edge_weight) (1);
G_auto_E(Gp) (3,2) Gdisp(edge_weight) (0.5,  90) Gdata(edge_weight) (2);
G_auto_E(Gp) (4,1) Gdisp(edge_weight) (0.5, 180) Gdata(edge_weight) (-4);
G_auto_E(Gp) (1,5) Gdisp(edge_weight) (0.8,  45) Gdata(edge_weight) (-1);
G_auto_E(Gp) (2,4) Gdisp(edge_weight) (0.8, 135) Gdata(edge_weight) (2);
G_auto_E(Gp) (4,5) Gdisp(edge_weight) (0.5, -90) Gdata(edge_weight) (3);
G_auto_E(Gp) (5,2) Gdisp(edge_weight) (0.5,   0) Gdata(edge_weight) (7);
G_auto_E(Gp) (6,2) Gdisp(edge_weight) (0.5,-135) Gdata(edge_weight) (5);
G_auto_E(Gp) (6,3) Gpath (30,-30) Gdisp(edge_weight) (0.8, 180) Gdata(edge_weight) (10);
G_auto_E(Gp) (3,6) Gpath (30,-30) Gdisp(edge_weight) (0.5,   0) Gdata(edge_weight) (-8);

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
				L[i][j] := infinity;
			fi;
		endfor;
	endfor;
enddef;

vardef INITIALIZE_SINGLE_SOURCE(suffix G)(suffix delta, pi)(expr s) :=
	graph_for_each_vertex(G)(vid)(
		delta[vid] := infinity;
		pi[vid] := -1;
	);
	delta[s] := 0;
enddef;

vardef GRELAX(suffix G, Omega)(suffix delta, pi)(expr uid, vid) :=
	%message "GRELAX uid: " & decimal(uid) & "," & decimal(vid);
	save newdelta; numeric newdelta;
	if (delta[uid] = infinity):
		newdelta := infinity;
	else:
		newdelta := delta[uid] + Omega[uid][vid];
	fi;
	if delta[vid] > newdelta:
		delta[vid] := newdelta;
		pi[vid] := uid;
	fi;
enddef;

vardef BELLMAN_FORD(suffix G, Omega)(suffix delta, pi)(expr s) :=
	save ret; boolean ret; ret := true;
	INITIALIZE_SINGLE_SOURCE(G)(delta, pi)(s);
	save n; numeric n;
	for n := 1 upto (G_vid_cnt(G) - 1):
		graph_for_each_edge(G)(sid, eid)(
			GRELAX(G, Omega)(delta, pi)(sid, eid);
		);
	endfor;
	graph_for_each_edge(G)(sidx, eidx)(
		if (delta[eidx] > (delta[sidx] + Omega[sidx][eidx])):
			ret := false;
			exitif true;
		fi;
	);
	ret
enddef;

vardef DIJKSTRA(suffix G, Omega)(suffix delta,pi)(expr s) :=
	%message "DIJKSTRA for " & decimal(s);
	INITIALIZE_SINGLE_SOURCE(G)(delta, pi)(s);
	save S; boolean S[];
	save vcnt; numeric vcnt; vcnt := G_vid_cnt(G);
	forever:
		exitif vcnt <= 0;

		save uid; numeric uid;
		graph_for_each_vertex(G)(vid)(
			if unknown S[vid]:
				if unknown uid:
					uid := vid;
				elseif delta[vid] < delta[uid]:
					%message "compare: " & decimal(delta[vid]) & " " & decimal(delta[uid]);
					uid := vid;
				fi;
			fi;
		);
		S[uid] := true;
		%message "cnt " & decimal(vcnt) & ", uid " & decimal(uid);
		graph_for_each_adj_vertex(G)(uid)(vid)(
			%message "--------------" & decimal(uid) & "," & decimal(vid);
			GRELAX(G, Omega)(delta, pi)(uid, vid);
		);

		vcnt := vcnt - 1;
	endfor;
	%output_vector(G)(delta)("dijkstra delta:");
enddef;

vardef JOHNSON(suffix G, Gp)(suffix Dret) :=
	save omega; numeric omega[][];
	COPY_WEIGHT_MATRIX(Gp)(omega);
	%output_maxtrix(Gp)(omega)("copy omega is:");
	numeric delta[]; numeric pi[];
	if ((BELLMAN_FORD(Gp, omega)(delta, pi)(0)) = false):
		message "the input graph contains a negative-weight cycle"
	else:
		save eich; numeric eich[];
		graph_for_each_vertex(Gp)(vid)(
			eich[vid] := delta[vid];
		);
		%output_vector(Gp)(pi)("\pi");
		output_vector(Gp)(eich)("h");
		numeric hat_omega[][];
		graph_for_each_edge(Gp)(sidx, eidx)(
			%message "omega[" & decimal(sidx) & "][" & decimal(eidx) & "] is " & decimal(omega[sidx][eidx]);
			if eich[sidx] = infinity:
				hat_omega[sidx][eidx] := omega[sidx][eidx];
			else:
				hat_omega[sidx][eidx] := omega[sidx][eidx] + eich[sidx] - eich[eidx];
			fi;
			%message decimal(sidx) & "," & decimal(eidx) & ": " & decimal(hat_omega[sidx][eidx]);
		);
		output_maxtrix(G)(hat_omega)("\hat{\omega}");
		graph_for_each_vertex(G)(uid)(
			save hat_delta; numeric hat_delta[];
			DIJKSTRA(G, hat_omega)(hat_delta, pi)(uid);
			%message "hat_delta for " & decimal(uid);
			%output_vector(G)(hat_delta)("\hat{\delta}");
			graph_for_each_vertex(G)(vid)(
				if hat_delta[vid] = infinity:
					Dret[uid][vid] := infinity;
				else:
					Dret[uid][vid] := hat_delta[vid] + eich[vid] - eich[uid];
				fi;
			);
		);
		%output_maxtrix(G)(Dret)("D");

	fi;
enddef;

vardef output_vector(suffix G)(suffix V)(expr header) :=
	message "the output matrix for " & header & " is:";

	save minvid, maxvid; numeric minvid, maxvid;
	G_vid_minmax(G)(minvid, maxvid);
	save i,j; numeric i,j;
	save texstring; string texstring; texstring := "";

	message "\startformula";
	message header & " = \left(\startmatrix";

	texstring := texstring & header & " = ";
	texstring := texstring & "\left(\startmatrix" & char(10);
	for i := minvid upto maxvid:
		save linestr; string linestr; linestr := "";
		%for j := minvid upto maxvid:
			save tmp; string tmp; tmp := "";
			if known V[i]:
				if V[i] = infinity:
					tmp := "\infty";
				else:
					tmp := decimal(V[i]);
				fi;
			else:
				tmp := "\infty";
			fi;
			linestr := linestr & "\NC " & tmp;
		%endfor;
		linestr := linestr & " \NR";
		message linestr;
		texstring := texstring & linestr & char(10);
	endfor;

	message "\stopmatrix\right)";
	texstring := texstring & "\stopmatrix\right)";
	%label(TEX("$ " & texstring & " $"), (0,0));

	message "\stopformula";
enddef;

vardef output_maxtrix(suffix G)(suffix M)(expr header) :=
	message "the output matrix for " & header & " is:";

	save minvid, maxvid; numeric minvid, maxvid;
	G_vid_minmax(G)(minvid, maxvid);
	save i,j; numeric i,j;
	save texstring; string texstring; texstring := "";

	message "\startformula";
	message header & " = \left(\startmatrix";

	texstring := texstring & header & " = ";
	texstring := texstring & "\left(\startmatrix" & char(10);
	for i := minvid upto maxvid:
		save linestr; string linestr; linestr := "";
		for j := minvid upto maxvid:
			save tmp; string tmp; tmp := "";
			if known M[i][j]:
				if M[i][j] = infinity:
					tmp := "\infty";
				else:
					tmp := decimal(M[i][j]);
				fi;
			else:
				tmp := "\infty";
			fi;
			linestr := linestr & "\NC " & tmp;
		endfor;
		linestr := linestr & " \NR";
		message linestr;
		texstring := texstring & linestr & char(10);
	endfor;

	message "\stopmatrix\right)";
	texstring := texstring & "\stopmatrix\right)";
	%label(TEX("$ " & texstring & " $"), (0,0));

	message "\stopformula";
enddef;

beginfig(1);
%drawoptions(withcolor red);
draw graph_img(G);
%drawoptions();
endfig;

message "JOHNSON all pairs shortest paths:";
save L; numeric L[][];
JOHNSON(G,Gp)(L);

%save idx; numeric idx;
%for idx := 1 upto G_vid_cnt(G):
%	output_maxtrix(G, L)(idx);
%endfor;

end;
