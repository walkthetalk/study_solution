input TEX;

vardef texlabel@#(expr strname, pos) text p =
	label@#(TEX(strname), pos) p
enddef;

vardef mathlabel@#(expr strname, pos) text p =
	label@#(TEX("$" & strname & "$"), pos) p
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

vardef img_bintree(suffix A)(expr i, p, n, xunit, yunit, gsize) :=
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
	label(decimal(A.key[i]), p) withcolor black;

	if known(A.left[i]):
		save cp;
		pair cp;
		cp := (xpart p - nn * xunit, ypart p - yunit);

		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp)) withcolor black;
		draw img_bintree(A)(A.left[i], cp, nn, xunit, yunit, gsize);
	fi;

	if known(A.right[i]):
		save cp;
		pair cp;
		cp := (xpart p + nn * xunit, ypart p - yunit);
		drawarrow ((fr shifted p) intersectionpoint (p -- cp))
			..((fr shifted cp) intersectionpoint (p -- cp)) withcolor black;
		draw img_bintree(A)(A.right[i], cp, nn, xunit, yunit, gsize);
	fi;
)
enddef;

vardef imgTenFourOne :=
image(
	numeric A.key[], A.left[], A.right[];
	numeric A.len;
	A.len := 10;	% data length

	A.key[ 1] := 12; A.left[ 1] := 7; A.right[ 1] := 3;
	A.key[ 2] := 15; A.left[ 2] := 8; %A.right[ 2] := 3;
	A.key[ 3] :=  4; A.left[ 3] :=10; %A.right[ 3] := 3;
	A.key[ 4] := 10; A.left[ 4] := 5; A.right[ 4] := 9;
	A.key[ 5] :=  2; %A.left[ 5] := 7; A.right[ 5] := 3;
	A.key[ 6] := 18; A.left[ 6] := 1; A.right[ 6] := 4;
	A.key[ 7] :=  7; %A.left[ 7] := 7; A.right[ 7] := 3;
	A.key[ 8] := 14; A.left[ 8] := 6; A.right[ 8] := 2;
	A.key[ 9] := 21; %A.left[ 9] := 7; A.right[ 9] := 3;
	A.key[10] :=  5; %A.left[10] := 7; A.right[10] := 3;

	draw img_bintree(A)(6, (0,0), heap_interval(A.len), .5cm, .7cm, .5cm);
)
enddef;

beginfig(1);
	draw imgTenFourOne;
endfig;

end;
