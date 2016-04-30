%% please input clrs_graph first
vardef declare_graph_FLOW(suffix G) :=
declare_graph_edge_ext_with_disp.edge_weight(G)("numeric weight");
declare_graph_edge_ext.flow(G)("numeric flow");
__graph_add_edge_draw_func(G)("__graph_draw.flow");
enddef;

vardef __graph_FLOW(suffix G)(expr sidx, eidx) :=
image(
	save tmp; string tmp;
	if known graph_edge_ext.flow(G)(sidx, eidx)(flow):
		tmp := decimal(graph_edge_ext.flow(G)(sidx, eidx)(flow)) & "/";
	else:
		tmp := "";
	fi;
	tmp := tmp & decimal(graph_edge_ext.edge_weight(G)(sidx, eidx)(weight));
	label(TEX(tmp), (0,0));
)
enddef;

vardef __graph_draw.flow(suffix G)(expr sidx, eidx) :=
	if known graph_edge_ext.edge_weight(G)(sidx, eidx)(weight):
		draw __graph_edge_remark(G)(sidx, eidx,
				graph_edge_ext.edge_weight(G)(sidx, eidx)(position),
				graph_edge_ext.edge_weight(G)(sidx, eidx)(deg),
				__graph_FLOW(G)(sidx, eidx));
	fi;
enddef;
