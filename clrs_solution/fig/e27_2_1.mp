
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

vardef to_str(expr imin, imax) :=
	save ret; string ret;
	if (imin < imax):
		ret := "(" & decimal(imin) & "," & decimal(imax) & ")";
	else:
		ret := decimal(imin);
	fi;
	ret
enddef;

vardef is_final(expr imin, imax, jmin, jmax) :=
	if (imax > imin) or (jmax > jmin):
		false
	else:
		true
	fi
enddef;

vardef img_p_fib_step(expr imin, imax, jmin, jmax, is_spawn) :=
image(
	save back_clr; color back_clr;
	if (is_spawn):
		back_clr := .9white;
	else:
		back_clr := .6white;
	fi;

	save lbl; string lbl; lbl := to_str(imin, imax) & " " & to_str(jmin, jmax);

	save ff; path ff;
	if not is_final(imin, imax, jmin, jmax):
		ff := rounded_path(-1.5, 1.5, 0.5, -1) scaled gsize;
		draw img_p_fib_node(ff, back_clr);
		draw img_p_fib_node(nodepath, black) shifted (-gsize, 0);
		draw img_p_fib_node(nodepath, .5 white);
		draw img_p_fib_node(nodepath, white) shifted (gsize, 0);
		draw img_arrow((-gsize, 0), (0, 0));
		label(lbl, (-.5gsize, -.625gsize));
	else:
		ff := rounded_path(-0.8, 0.8, 0.5, -1) scaled gsize;
		draw img_p_fib_node(ff, back_clr);
		draw img_p_fib_node(nodepath, black);
		label(lbl, (0, -.625gsize));
	fi;
)
enddef;

vardef img_p_fib(expr imin, imax, jmin, jmax, is_spawn) :=
image(
	draw img_p_fib_step(imin, imax, jmin, jmax, is_spawn);
	if not is_final(imin, imax, jmin, jmax):
		save l,r;
		picture l, r;
		save l_imin, l_imax, l_jmin, l_jmax;
		save r_imin, r_imax, r_jmin, r_jmax;
		numeric l_imin, l_imax, l_jmin, l_jmax;
		numeric r_imin, r_imax, r_jmin, r_jmax;
		if (imax > imin):
			save mid; numeric mid; mid := floor((imin + imax)/2);
			l_imin := imin; l_imax := mid;
			r_imin := mid+1; r_imax := imax;
			l_jmin := jmin; l_jmax := jmax;
			r_jmin := jmin; r_jmax := jmax;
		else:
			save mid; numeric mid; mid := floor((jmin + jmax)/2);
			l_imin := imin;	l_imax := imax;
			r_imin := imin;	r_imax := imax;
			l_jmin := jmin;	l_jmax := mid;
			r_jmin := mid+1; r_jmax := jmax;
		fi;
		l := img_p_fib(l_imin, l_imax, l_jmin, l_jmax, true);
		r := img_p_fib(r_imin, r_imax, r_jmin, r_jmax, false);
		save xshift, yshift;
		numeric xshift, yshift;
		xshift := (xpart(lrcorner(l)) - xpart(llcorner(r)) + .5gsize) / 2;
		yshift := -2gsize;
		draw l shifted (-xshift, yshift);
		draw r shifted (xshift, yshift);

		if not is_final(l_imin, l_imax, l_jmin, l_jmax):
			draw img_arrow((-gsize, 0), (-xshift-gsize, yshift));
			draw img_arrow((-xshift+gsize, yshift), (gsize, 0));
		else:
			draw img_arrow((-gsize, 0), (-xshift, yshift));
			draw img_arrow((-xshift, yshift), (gsize, 0));
		fi;

		if not is_final(r_imin, r_imax, r_jmin, r_jmax):
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
draw img_p_fib(1,2,1,2, true);
endfig;

end;
