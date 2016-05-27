
numeric gsize;
gsize := 1cm;

path nodepath;
nodepath := fullcircle scaled .5gsize;

vardef img_p_fib_node(expr frame, clr) :=
image(
	fill frame withcolor clr;
	draw frame;
)
enddef;

vardef img_arrow(expr sp, ep) :=
image(
	drawarrow ((sp--ep) cutbefore (nodepath shifted sp) cutafter (nodepath shifted ep));
)
enddef;

vardef rounded_path(expr l, r, t, b) :=
save ret; path ret;
save rc; numeric rc; rc := 0.1;
ret := (r-rc, t){dir 0}..{dir 270}(r,t-rc)--(r,b+rc){dir 270}..{dir 180}(r-rc,b)--(l+rc,b){dir 180}..{dir 90}(l,b+rc)--(l,t-rc){dir 90}..{dir 0}(l+rc,t)--cycle;
ret
enddef;

vardef img_p_fib_step(expr n, is_spawn) :=
image(
	save back_clr; color back_clr;
	if (is_spawn):
		back_clr := .9white;
	else:
		back_clr := .6white;
	fi;

	save ff; path ff;
	if (n > 1):
		ff := rounded_path(-1.5, 1.5, 0.5, -1) scaled gsize;
		draw img_p_fib_node(ff, back_clr);
		draw img_p_fib_node(nodepath, black) shifted (-gsize, 0);
		draw img_p_fib_node(nodepath, .5 white);
		draw img_p_fib_node(nodepath, white) shifted (gsize, 0);
		draw img_arrow((-gsize, 0), (0, 0));
		label("P-FIB(" & decimal(n) & ")", (-.5gsize, -.625gsize));
	else:
		ff := rounded_path(-0.8, 0.8, 0.5, -1) scaled gsize;
		draw img_p_fib_node(ff, back_clr);
		draw img_p_fib_node(nodepath, black);
		label("P-FIB(" & decimal(n) & ")", (0, -.625gsize));
	fi;
)
enddef;

vardef img_p_fib(expr n, is_spawn) :=
image(
	draw img_p_fib_step(n, is_spawn);
	if (n > 1):
		save l,r;
		picture l, r;
		l := img_p_fib(n-1, true);
		r := img_p_fib(n-2, false);
		save xshift, yshift;
		numeric xshift, yshift;
		xshift := (xpart(lrcorner(l)) - xpart(llcorner(r)) + .5gsize) / 2;
		yshift := -2gsize;
		draw l shifted (-xshift, yshift);
		draw r shifted (xshift, yshift);

		if ((n-1) > 1):
			draw img_arrow((-gsize, 0), (-xshift-gsize, yshift));
			draw img_arrow((-xshift+gsize, yshift), (gsize, 0));
		else:
			draw img_arrow((-gsize, 0), (-xshift, yshift));
			draw img_arrow((-xshift, yshift), (gsize, 0));
		fi;

		if ((n-2) > 1):
			draw img_arrow((0, 0), (xshift-gsize, yshift));
			draw img_arrow((xshift+gsize, yshift), (gsize, 0));
		else:
			draw img_arrow((0, 0), (xshift, yshift));
			draw img_arrow((xshift, yshift), (gsize, 0));
		fi;
	fi;
)
enddef;

beginfig(1);
draw img_p_fib(5, true);
endfig;

end;
