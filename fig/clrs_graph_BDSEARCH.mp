%% please input clrs_graph first
vardef declare_graph_DF(suffix G) :=
declare_graph_vertex_ext.df(G)("numeric deg, numeric dv, numeric fv");
enddef;

vardef G_set_DF(suffix G)(expr idx, _deg, _d, _f)text _remain :=
	G_set_V_ext.df(G)(idx, _deg, _d, _f)_remain;
enddef;

vardef __graph_DF(suffix G)(expr idx) :=
image(
	label(TEX(decimal(graph_vertex_ext.df(G)(idx)(dv))
		& ","
		& decimal(graph_vertex_ext.df(G)(idx)(fv))),
		(0,0));
)
enddef;

vardef draw_DF(suffix G)(expr idx) :=
	if known G.V[idx]df.dv and known G.V[idx]df.fv:
		draw __graph_vertex_remark(G)(idx, graph_vertex_ext.df(G)(idx)(deg), __graph_DF(G)(idx));
	fi;
enddef;
