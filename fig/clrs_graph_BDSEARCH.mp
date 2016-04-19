%% please input clrs_graph first
vardef declare_graph_vertex_remark(suffix G) :=
pair G.V[]df;
numeric G.V[]remark_dir;
enddef;

vardef graph_add_vertex_remark_n(suffix G)(expr idx, usrdir, info) :=
	G.V[idx]remark_dir := usrdir;
	G.V[idx]df := info;
enddef;

vardef graph_add_vertex_remark_a(suffix G)(expr idx, usrdir, info)text _remain :=
	graph_add_vertex_remark_n(G)(ASCII idx, usrdir, info);
	if not __emptytext(_remain):
		graph_add_vertex_remark_a(G)_remain;
	fi;
enddef;

vardef graph_vertex_remark(suffix G)(expr idx) :=
image(
	label(TEX(decimal(xpart G.V[idx]df) & "," & decimal(ypart G.V[idx]df)),
		(0,0));
)
enddef;

vardef draw_vertex_remark(suffix G)(expr idx) :=
	if known G.V[idx]df:
		draw __vertex_remark(G, graph_vertex_remark)(idx, G.V[idx]remark_dir);
	fi;
enddef;
