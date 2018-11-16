
vardef oil_well :=
image(
	path lp, rp, lw, rw;
	numeric ubs, segs, splity;
	ubs := 0.9;
	segs := 5;
	lp := (-10, -30)--(-5, 0);
	splity := ypart(point ubs of lp);

	rp := (lp) xscaled -1;
	lw := point 0 of lp;
	for i := 1 upto segs:
		numeric t;
		t := (40 - (8 - i) * (5 - i)) / 40 * ubs;
		if odd(i):
			lw := lw -- (point t of rp);
		else:
			lw := lw -- (point t of lp);
		fi;
	endfor;
	rw := lw xscaled -1;

	draw lp -- reverse(rp);
	draw lw;
	draw rw;

	draw (-10, splity) -- (10, splity);
)
enddef;

vardef imgNineThreeNine :=
image(
	pair A[];
	A[0] := (20,-30);
	A[1] := (25, 35);
	A[2] := (45, 25);
	A[3] := (60,-40);
	A[4] := (80, 50);
	A[5] := (120, 20);
	A[6] := (135,-25);
	A[7] := (170, 30);
	A[8] := (190,-50);

	draw (0,0)--(200,0) withpen pencircle scaled 3;
	for i := 0 upto 8:
		pair tmp;
		tmp := A[i];
		draw A[i] -- (xpart(tmp),0) withpen pencircle scaled 3;
		%draw oil_well shifted tmp;
		label.ulft(oil_well xscaled 0.5 yscaled 0.6, tmp);
	endfor;
)
enddef;

beginfig(1);
	draw imgNineThreeNine;
endfig;

end;
