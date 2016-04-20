%% please input clrs_graph first
vardef declare_graph_EDGEWEIGHT(suffix G) :=
declare_graph_edge_ext.edge_weight(G)("numeric position, numeric deg, numeric weight");
enddef;

vardef G_set_EDGEWEIGHT(suffix G)(expr seidx, _pos, _deg, _w)text _remain :=
	graph_set_edge_ext.edge_weight(G)(seidx, _pos, _deg, _w)_remain;
enddef;

vardef __graph_EDGEWEIGHT(suffix G)(expr sidx, eidx) :=
image(
	label(TEX(decimal(graph_edge_ext.edge_weight(G)(sidx, eidx)(weight))), (0,0));
)
enddef;

vardef draw_EDGEWEIGHT(suffix G)(expr sidx, eidx) :=
	if known graph_edge_ext.edge_weight(G)(sidx, eidx)(weight):
		draw __graph_edge_remark(G)(sidx, eidx,
				graph_edge_ext.edge_weight(G)(sidx, eidx)(position),
				graph_edge_ext.edge_weight(G)(sidx, eidx)(deg),
				__graph_EDGEWEIGHT(G)(sidx, eidx));
	fi;
enddef;
