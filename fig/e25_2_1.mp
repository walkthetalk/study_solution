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

% @ L : the returned matrix
vardef FLOYD_WARSHALL(suffix G)(suffix L) :=
	save min_vid, max_vid; numeric min_vid, max_vid;
	G_vid_minmax(G)(min_vid, max_vid);

	COPY_WEIGHT_MATRIX(G)(L[0]);

	save i,j,k; numeric i,j,k;
	for k := 1 upto G_vid_cnt(G):
		for i := 1 upto G_vid_cnt(G):
			for j := 1 upto G_vid_cnt(G):
				save tl, tr; numeric tl, tr;
				tl := L[k-1][i][j];
				if (L[k-1][i][k] = infinity) or (L[k-1][k][j] = infinity):
					tr := infinity;
				else:
					tr = L[k-1][i][k] + L[k-1][k][j]
				fi;
				if tl = infinity:
					L[k][i][j] := tr;
				elseif tr = infinity:
					L[k][i][j] := tl;
				else:
					if tl < tr:
						L[k][i][j] = tl;
					else:
						L[k][i][j] = tr;
					fi;
				fi;
			endfor;
		endfor;
	endfor;
enddef;

vardef output_maxtrix(suffix G, L)(expr idx) :=
%image(
	message "the output matrix for " & decimal(idx) & " is:";

	save minvid, maxvid; numeric minvid, maxvid;
	G_vid_minmax(G)(minvid, maxvid);
	save i,j; numeric i,j;
	save texstring; string texstring; texstring := "";

	message "\startformula";
	message "L^{(" & decimal(idx) & ")} = \left(\startmatrix";

	texstring := texstring & "L^{(" & decimal(idx) & ")} = ";
	texstring := texstring & "\left(\startmatrix" & char(10);
	for i := minvid upto maxvid:
		save linestr; string linestr; linestr := "";
		for j := minvid upto maxvid:
			save tmp; string tmp; tmp := "";
			if known L[idx][i][j]:
				if L[idx][i][j] = infinity:
					tmp := "\infty";
				else:
					tmp := decimal(L[idx][i][j]);
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
%)
enddef;

beginfig(1);
%drawoptions(withcolor red);
draw graph_img(G);
%drawoptions();
endfig;

message "FLOYD_WARSHALL all pairs shortest paths:";
save L; numeric L[][][];
FLOYD_WARSHALL(G)(L);

save idx; numeric idx;
for idx := 1 upto G_vid_cnt(G):
	output_maxtrix(G, L)(idx);
endfor;

end;
