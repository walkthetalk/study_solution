input TEX;
input format;

bboxmargin := 0;

vardef img_bitnoic_tours(suffix DATA)(expr gsize) :=
image(
	numeric maxx, maxy;
	numeric i;
	i := 0; maxx := 0; maxy := 0;
	forever:
		exitif unknown(DATA[i]);
		if xpart(DATA[i]) > maxx:
			maxx := xpart(DATA[i]);
		fi;

		if ypart(DATA[i]) > maxy:
			maxy := ypart(DATA[i]);
		fi;
		i := i + 1;
	endfor;

	for i := 0 upto maxx:
		draw ((i, -0.5)--(i, (maxy + 0.5))) scaled gsize
			dashed evenly;
	endfor;
	for i := 0 upto maxy:
		draw ((-0.5, i)--((maxx + 0.5), i)) scaled gsize
			dashed evenly;
	endfor;

	i := 0;
	forever:
		exitif unknown(DATA[i]);
		fill fullcircle scaled .4gsize shifted (DATA[i] scaled gsize);
		i := i + 1;
	endfor;

	path tour;
	tour := DATA[0];
	i := 1;
	forever:
		exitif unknown(DATA[i]);
		tour := tour -- DATA[i];
		i := i + 1;
	endfor;
	tour := tour -- cycle;

	draw tour scaled gsize withpen pencircle scaled .1gsize;
)
enddef;

beginfig(1);
	pair DATA[];
	DATA[0] := (0, 6);
	DATA[1] := (5, 4);
	DATA[2] := (7, 5);
	DATA[3] := (8, 2);
	DATA[4] := (6, 1);
	DATA[5] := (1, 0);
	DATA[6] := (2, 3);
	draw img_bitnoic_tours(DATA)(0.6cm);
endfig;
beginfig(2);
	pair DATA[];
	DATA[0] := (0, 6);
	DATA[1] := (2, 3);
	DATA[2] := (5, 4);
	DATA[3] := (7, 5);
	DATA[4] := (8, 2);
	DATA[5] := (6, 1);
	DATA[6] := (1, 0);
	draw img_bitnoic_tours(DATA)(0.6cm);
endfig;

end;
