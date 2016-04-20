input clrs_graph;

vardef outer_frame(suffix G)(expr lbls) :=
image(
	save p; path p;
	p := G_V_position(G)(substring(0,1) of lbls);
	for i := 1 upto (length(lbls) - 1):
		p := p -- G_V_position(G)(substring(i,i+1) of lbls);
	endfor;
	p := p -- cycle;

	fill p
		withpen (pencircle scaled .25cm)
		withcolor .7white;
)
enddef;

%% global data
declare_graph(G, false, true, 1cm, fullcircle scaled .5cm);

G_add_V(G)
	("a", (0,0))
	("b", (1,1))
	("c", (1,-1))
	("d", (2,0))
	("e", (4,0))
	("f", (3,1))
	("g", (4,1))
	("h", (3,-1))
	("i", (4,-1))
	("j", (3,-2))
	("k", (5,0))
	("l", (6,1))
	("m", (6,-1))
	("n", (7,0))
	("o", (9,0))
	("p", (10,1))
	("q", (10,-1))
	("r", (11,0))
	("s", (12,0))
	("t", (9,-2))
	("u", (8,-1))
	("v", (8,-2))
	("w", (11,-2));

G_add_E(G)
	("ab")
	("ac")
	("ad")
	("bc")
	("bd")
	("cd")
	("fg")
	("fe")
	("ge")
	("eh")
	("hi")
	("ie")
	("kl")
	("km")
	("ln")
	("mn")
	("or")
	("oq")
	("qp")
	("qr")
	("ps")
	("rs")
	("uv")
	("ut")
	("vt")
	("de")("hj")("ek")("no")("qt")("qw");

beginfig(1);


% outer frame
draw outer_frame(G)("acdb");
draw outer_frame(G)("efg");
draw outer_frame(G)("ehi");
draw outer_frame(G)("klnm");
draw outer_frame(G)("opsq");
draw outer_frame(G)("uvt");

save bridges, artpoints, commonpoints;
string bridges, artpoints, commonpoints;
% bridges
bridges := "dehjeknoqtqw";
for i := 0 step 2 until (length bridges - 1):
	draw G_E_path(G)(substring(i,i+2)of bridges) withpen (pencircle scaled .25cm) withcolor .3 white;
endfor;

% commonpoints
commonpoints := "abcfgijlmprswuv";
for i := 0 upto (length commonpoints - 1):
	G_set_V_color(G)(white,white)(substring(i,i+1)of commonpoints);
endfor;

% artpoints
artpoints := "deknoqtwh";
for i := 0 upto (length artpoints - 1):
	G_set_V_color(G)(black,black)(substring(i,i+1)of artpoints);
endfor;

draw graph_img(G);

%lbl
label.urt("1", (1,0) * 1cm);
label.urt("2", (3.5,0.5) * 1cm);
label.lrt("3", (3.5,-0.5) * 1cm);
label("4", (6,0) * 1cm);
label.llft("5", (8.5,-1.5) * 1cm);
label.ulft("6", (10,0) * 1cm);

endfig;

end;
