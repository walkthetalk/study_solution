% for any def, use expr/primary, don't use suffix
vardef lchild primary $ =
	($ * 2)
enddef;

vardef rchild primary $ =
	($ * 2 + 1)
enddef;

vardef max_min(suffix A)(expr Alength, i, maxheap) =
	save largest;
	numeric largest;
	largest := i;
	if maxheap:
		if lchild(i) <= Alength:
			if A[largest] < A[lchild(i)]:
				largest := lchild(i);
			fi;
		fi;
		if rchild(i) <= Alength:
			if A[largest] < A[rchild(i)]:
				largest := rchild(i);
			fi;
		fi;
	else:
		if lchild(i) <= Alength:
			if A[largest] > A[lchild(i)]:
				largest := lchild(i);
			fi;
		fi;
		if rchild(i) <= Alength:
			if A[largest] > A[rchild(i)]:
				largest := rchild(i);
			fi;
		fi;
	fi;

	largest
enddef;

vardef img_subheap(suffix A)(expr Alength, i, p, n, xunit, yunit, gsize, maxheap) :=
image(
	save fr;
	path fr;
	fr := fullcircle scaled gsize;

	%message "img subheap " & decimal(n);

	save nn;
	numeric nn;
	nn := n / 2;
	if nn < 0.5:
		nn := 0.5;
	fi;

	fill fr shifted p withcolor .8white;
	label(decimal(A[i]), p) withcolor black;

	if lchild(i) <= Alength:
		save cp;
		pair cp;
		cp := (xpart p - nn * xunit, ypart p - yunit);
		color arrowcolor;
		if maxheap:
			if A[i] < A[lchild(i)]:
				arrowcolor := red;
			else:
				arrowcolor := black;
			fi;
		else:
			if A[lchild(i)] < A[i]:
				arrowcolor := red;
			else:
				arrowcolor := black;
			fi;
		fi;
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp)) withcolor arrowcolor;
		draw img_subheap(A)(Alength, lchild(i), cp, nn, xunit, yunit, gsize, maxheap);
	fi;

	if rchild(i) <= Alength:
		save cp;
		pair cp;
		cp := (xpart p + nn * xunit, ypart p - yunit);
		color arrowcolor;
		if maxheap:
			if A[i] < A[rchild(i)]:
				arrowcolor := red;
			else:
				arrowcolor := black;
			fi;
		else:
			if A[rchild(i)] < A[i]:
				arrowcolor := red;
			else:
				arrowcolor := black;
			fi;
		fi;
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp)) withcolor arrowcolor;
		draw img_subheap(A)(Alength, rchild(i), cp, nn, xunit, yunit, gsize, maxheap);
	fi;
)
enddef;

vardef heap_interval primary $ =
	save n;
	numeric n;

	%message "heap_interval " & decimal($);
	% find highest bit
	n := 1;
	forever:
		exitif (n*2) > $;
		n := n * 2;
	endfor

	% n = 2^{\lfloor \log_2^$ \rfloor}

	if (n <= $) and ($ <= (n + 1)):
		n := n / 4;
	else:
		n := n / 2;
	fi;

	if n < 1:
		n := 1;
	fi;

	n
enddef;

% the A is array whose first element is A[1]
vardef img_heap(suffix A)(expr Alength, gsize, xunit, yunit, maxheap) :=
image(
	draw img_subheap(A)(Alength, 1, (0,0), heap_interval(Alength), xunit, yunit, gsize, maxheap);
)
enddef;

vardef img_subheapify(suffix A)(expr Alength, focus, i, p, n, xunit, yunit, gsize, maxheap) :=
image(
	save fr;
	path fr;
	fr := fullcircle scaled gsize;

%	message "hello " & decimal(i) & " " & decimal(xpart p) & " " & decimal(ypart p);

	fill fr shifted p withcolor .8white;
	if i = focus:
		%message decimal(xpart p) & "  +++   " & decimal(ypart p);
		draw fr shifted p withcolor red;
	fi;
	label(decimal(A[i]), p) withcolor black;

	save nn;
	numeric nn;
	nn := n / 2;
	if nn < 0.5:
		nn := 0.5;
	fi;

	% draw
	if lchild(i) <= Alength:
		save cp;
		pair cp;
		cp := (xpart p - nn * xunit, ypart p - yunit);
		color arrowcolor;
		if max_min(A)(Alength, i, maxheap) = lchild(i):
			arrowcolor := red;
		else:
			arrowcolor := black;
		fi;
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp)) withcolor arrowcolor;
		draw img_subheapify(A)(Alength, focus, lchild(i), cp, nn, xunit, yunit, gsize, maxheap);
	fi;
	if rchild(i) <= Alength:
		save cp;
		pair cp;
		cp := (xpart p + nn * xunit, ypart p - yunit);
		color arrowcolor;
		if max_min(A)(Alength, i, maxheap) = rchild(i):
			arrowcolor := red;
		else:
			arrowcolor := black;
		fi;
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp)) withcolor arrowcolor;
		draw img_subheapify(A)(Alength, focus, rchild(i), cp, nn, xunit, yunit, gsize, maxheap);
	fi;
)
enddef;

vardef img_heapify(suffix A)(expr Alength, focus, gsize, xunit, yunit, maxheap) :=
image(
	draw img_subheapify(A)(Alength, focus, 1, (0,0), heap_interval(Alength), xunit, yunit, gsize, maxheap);
)
enddef;

vardef img_heap_focus(suffix A)(expr Alength, focus, gsize, xunit, yunit, maxheap) :=
image(
	draw img_subheapify(A)(Alength, focus, 1, (0,0), heap_interval(Alength), xunit, yunit, gsize, maxheap);
)
enddef;

vardef next_heapify(suffix A)(expr Alength, i, maxheap) :=
	save largest, tmp;
	numeric largest, tmp;

	largest := max_min(A)(Alength, i, maxheap);

	if largest <> i:
		tmp := A[largest];
		A[largest] := A[i];
		A[i] := tmp;
	fi;

	largest
enddef;

vardef max_heapify_ret(suffix A)(expr Alength, i, maxheap) :=
	save ii;
	numeric ii;
	ii = i;
	%message "max_heapify " & decimal(Alength) & "  " & decimal(i);
	forever:
		exitif lchild(ii) > Alength;
		save tmp;
		numeric tmp;
		tmp := next_heapify(A)(Alength, ii, maxheap);
		exitif tmp = ii;
		ii := tmp;
	endfor;
	ii
enddef;

vardef max_heapify(suffix A)(expr Alength, i, maxheap) :=
	save ret;
	numeric ret;
	ret := max_heapify_ret(A)(Alength, i, maxheap);
enddef;

vardef build_max_heap(suffix A)(expr Alength, maxheap) :=
	for i := floor(Alength/2) downto 1:
		max_heapify(A)(Alength, i, maxheap);
	endfor
enddef;

vardef build_max_heap_alt(suffix A)(expr Alength, maxheap) :=
	for i := 2 upto ALength:
		numeric focus_index;
		focus_index := i;
		forever:
			exitif focus_index <= 1;

			numeric parent_index;
			parent_index := floor(focus_index / 2);
			if maxheap:
				exitif data[focus_index] <= data[parent_index];
			else:
				exitif data[focus_index] >= data[parent_index];
			fi;
			numeric tmp;
			% exchange
			tmp := data[parent_index];
			data[parent_index] := data[focus_index];
			data[focus_index] := tmp;

			% next loop
			focus_index := parent_index;
		endfor;
	endfor
enddef;

vardef sub_heapsort(suffix A)(expr Alength, maxheap) :=
	save tmp;
	numeric tmp;
	tmp := A[Alength];
	A[Alength] := A[1];
	A[1] := tmp;

	max_heapify(A)((Alength - 1), 1, maxheap);
enddef;

vardef img_subheapsort(suffix A)(expr Alength, realLength, i, p, n, xunit, yunit, gsize, maxheap) :=
image(
	%message "img_subheapsort " & decimal(realLength) & "  " & decimal(i) & " " & decimal(xpart p) & " " & decimal(ypart p);
	save fr;
	path fr;
	fr := fullcircle scaled gsize;


	if i <= realLength:
		fill fr shifted p withcolor .8white;
	else:
		fill fr shifted p withcolor .7white;
	fi;
	label(decimal(A[i]), p) withcolor black;

	save nn;
	numeric nn;
	nn := n / 2;
	if nn < 0.5:
		nn := 0.5;
	fi;

	% draw
	if lchild(i) <= Alength:
		save cp;
		pair cp;
		cp := (xpart p - nn * xunit, ypart p - yunit);
		if lchild(i) <= realLength:
			color arrowcolor;
			if max_min(A, Alength)(i, maxheap) = lchild(i):
				arrowcolor := red;
			else:
				arrowcolor := black;
			fi;
			drawarrow ((fr shifted p) intersectionpoint (p -- cp))
				..((fr shifted cp) intersectionpoint (p -- cp)) withcolor arrowcolor;
		fi;
		draw img_subheapsort(A)(Alength, realLength, lchild(i), cp, nn, xunit, yunit, gsize, maxheap);
	fi;
	if rchild(i) <= Alength:
		save cp;
		pair cp;
		cp := (xpart p + nn * xunit, ypart p - yunit);
		if rchild(i) <= realLength:
			color arrowcolor;
			if max_min(A, Alength)(i, maxheap) = rchild(i):
				arrowcolor := red;
			else:
				arrowcolor := black;
			fi;
			drawarrow ((fr shifted p) intersectionpoint (p -- cp))
				..((fr shifted cp) intersectionpoint (p -- cp)) withcolor arrowcolor;
		fi;
		draw img_subheapsort(A)(Alength, realLength, rchild(i), cp, nn, xunit, yunit, gsize, maxheap);
	fi;
)
enddef;

vardef img_heapsort(suffix A)(expr ALength, i, gsize, xunit, yunit, maxheap) :=
image(
	%message "img_heapsort";
	draw img_subheapsort(A)(ALength, i, 1, (0,0), heap_interval(ALength), xunit, yunit, gsize, maxheap);
)
enddef;
