%% please input clrs_graph first
vardef declare_graph_DF(suffix G) :=
declare_graph_vertex_ext.df(G)("numeric deg, numeric dv, numeric fv");
__graph_add_vertex_draw_func(G)("__graph_draw.df");
enddef;

vardef __graph_DF(suffix G)(expr idx) :=
image(
	label(TEX(decimal(graph_vertex_ext.df(G)(idx)(dv))
		& ","
		& decimal(graph_vertex_ext.df(G)(idx)(fv))),
		(0,0));
)
enddef;

vardef __graph_draw.df(suffix G)(expr idx) :=
	if known G.V[idx]df.dv and known G.V[idx]df.fv:
		draw __graph_vertex_remark(G)(idx, graph_vertex_ext.df(G)(idx)(deg), __graph_DF(G)(idx));
	fi;
enddef;
