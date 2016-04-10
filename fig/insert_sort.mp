
vardef insert_sort_step(suffix A, Alength)(expr gsize, j, nondecrease, needdraw) :=
image(
	numeric B[];
	color   bg[];
	color   fg[];
	numeric i, key;
	for i := 1 upto Alength:
		B[i] := A[i];
	endfor;

	% start algorithm core
	key := A[j];
	i := j - 1;

	if nondecrease:
		forever:
			exitunless (i > 0);
			exitunless (A[i] > key);	% exitunless can't nested in 'if'
	%		exitunless ((i > 0) and (A[i] > key));	% can't work

			A[i+1] := A[i];
			i := i - 1;
		endfor;
	else:
		forever:
			exitunless (i > 0);
			exitunless (A[i] < key);
	%		exitunless ((i > 0) and (A[i] > key));	% can't work

			A[i+1] := A[i];
			i := i - 1;
		endfor;
	fi;
	A[i+1] := key;
	% stop algorithm core

	if (needdraw):
		% record move range
		numeric start, end;
		start := i;
		end := j;

		for i := 1 upto (start-1):
			bg[i] := white;
			fg[i] := black;
		endfor;
		for i := start upto (end-1):
			bg[i] := darkgray;
			fg[i] := black;
		endfor;
		for i := end upto end:
			bg[i] := black;
			fg[i] := white;
		endfor;
		for i := (end+1) upto Alength:
			bg[i] := white;
			fg[i] := black;
		endfor;

		for k := 1 upto Alength:
			path fr;
			pair center;
			fr := unitsquare shifted(-0.5,-0.5) xyscaled gsize shifted(k * gsize, 0);
			center := (k * gsize, 0);

			fill fr withcolor bg[k];
			label(decimal(k),center shifted(0, gsize));
			label(decimal(B[k]), center) withcolor fg[k];
			draw fr withcolor black;
		endfor;

		pair arrows, arrowe, arrowc;
		for k := (start+1) upto (end - 1):
			arrows := (k*gsize + 0.2 * gsize, -gsize/2);
			arrowe := (k*gsize + 0.8 * gsize, -gsize/2);
			arrowc := (k*gsize + 0.5 * gsize, -gsize);

			drawarrow (arrows{down}..arrowc..{up}arrowe) withcolor darkgray;
		endfor;
		arrows := (end*gsize + 0.3 * gsize, -gsize/2);
		arrowe := ((start+1)*gsize - 0.3 * gsize, -gsize/2);
		arrowc := ((start+1 + end) / 2 *gsize, -gsize * 1.1);

		drawarrow (arrows{dir -100}..arrowc..{dir 100}arrowe) withcolor black;
	fi;
)
enddef;

vardef insert_sort_result(suffix A, Alength)(expr gsize) :=
image(
	color   bg[];
	color   fg[];
	for i := 1 upto Alength:
		bg[i] := white;
		fg[i] := black;
	endfor;

	for k := 1 upto Alength:
		path fr;
		pair center;
		fr := unitsquare shifted(-0.5,-0.5) xyscaled gsize shifted(k * gsize, 0);
		center := (k * gsize, 0);

		fill fr withcolor bg[k];
		label(decimal(k),center shifted(0, gsize));
		label(decimal(A[k]), center) withcolor fg[k];
		draw fr withcolor black;
	endfor;
)
enddef;
