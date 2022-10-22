input clrs

vardef merge(suffix A, Alength)(expr gsize, p, q, r, nondecrease, needdraw) :=
image(
	numeric L[];
	numeric R[];
	% [p, q] and (q, r]
	n1 := q-p+1;
	n2 := r-q;

	for i := 1 upto n1:
		L[i] := A[p+i-1];
	endfor;
	for j := 1 upto n2:
		R[j] := A[q+j];
	endfor;

	if nondecrease:
		L[n1+1] := max(A[q], A[r]) + 1000;
		R[n2+1] := L[n1+1];
	else:
		L[n1+1] := min(A[q], A[r]) - 1000;
		R[n2+1] := L[n1+1];
	fi;

	i := 1;
	j := 1;
	for k := p upto r:
		if nondecrease:
			if L[i] <= R[j]:
				A[k] := L[i];
				i := i + 1;
			else:
				A[k] := R[j];
				j := j + 1;
			fi;
		else:
			if L[i] >= R[j]:
				A[k] := L[i];
				i := i + 1;
			else:
				A[k] := R[j];
				j := j + 1;
			fi;
		fi;
	endfor;

	if needdraw:
		for k := p upto r:
			path fr;
			pair center;
			center := ((k-(r+p)/2) * gsize, 0);
			%fr := unitsquare shifted(-0.5,-0.5) xyscaled gsize shifted(center);
			fr := fullcircle scaled gsize shifted(center);

			fill fr withcolor clrsCfA;
			label(decimal(A[k]), center) withcolor black;
			draw fr withcolor black;
		endfor;
	fi;
)
enddef;

vardef mslvl primary x =
	(if x = 0:
		0
	else:
		mlog(x)/mlog(2)
	fi)
enddef ;

vardef merge_sort(suffix A, Alength)(expr gsize, p, r, nondecrease, needdraw) :=
image(
	if p < r:
		save q, lshift, rshift, aratio;
		numeric q, aratio;
		pair lshift, rshift;
		q = floor((p + r)/ 2);
		lshift = (-(q-p+1)/2 * gsize, -2 * gsize) + (-(q-p+1) * gsize/2, 0);
		rshift = ((r-q)/2 * gsize, -2 * gsize) + ((r-q) * gsize/2, 0);
		draw merge_sort(A, Alength)(gsize, p, q, nondecrease, needdraw)
			shifted lshift;
		draw merge_sort(A, Alength)(gsize, (q + 1), r, nondecrease, needdraw)
			shifted rshift;
		draw merge(A, Alength)(gsize, p, q, r, nondecrease, needdraw);
		aratio = 1.1;
		drawarrow (lshift + (0, gsize/2 * aratio)) .. (-gsize/2,-gsize/2 * aratio) withcolor clrsClA;
		drawarrow (rshift + (0, gsize/2 * aratio)) .. ( gsize/2,-gsize/2 * aratio) withcolor clrsClA;
	elseif p = r:
		if needdraw:
			path fr;
			pair center;
			center = (0, 0);
			%fr := unitsquare shifted(-0.5,-0.5) xyscaled gsize shifted(center);
			fr = fullcircle scaled gsize shifted(center);

			fill fr withcolor clrsCfA;
			label(decimal(p), center) shifted(0, -gsize) withcolor red;
			label(decimal(A[p]), center) withcolor black;
			draw fr withcolor black;
		fi;
	fi;
)
enddef;
