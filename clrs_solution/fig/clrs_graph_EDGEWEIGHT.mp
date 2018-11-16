%% please input clrs_graph first
vardef declare_graph_EDGEWEIGHT(suffix G) :=
declare_graph_edge_ext_with_disp.edge_weight(G)("numeric weight");
__graph_add_edge_draw_func(G)("__graph_draw.edge_weight");
enddef;

vardef __graph_EDGEWEIGHT(suffix G)(expr sidx, eidx) :=
image(
	label(TEX(decimal(graph_edge_ext.edge_weight(G)(sidx, eidx)(weight))), (0,0));
)
enddef;

vardef __graph_draw.edge_weight(suffix G)(expr sidx, eidx) :=
	if known graph_edge_ext.edge_weight(G)(sidx, eidx)(weight):
		draw __graph_edge_remark(G)(sidx, eidx,
				graph_edge_ext.edge_weight(G)(sidx, eidx)(position),
				graph_edge_ext.edge_weight(G)(sidx, eidx)(deg),
				__graph_EDGEWEIGHT(G)(sidx, eidx));
	fi;
enddef;
