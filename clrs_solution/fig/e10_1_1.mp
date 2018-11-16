input TEX;

vardef texlabel@#(expr strname, pos) text p =
	label@#(TEX(strname), pos) p
enddef;

vardef mathlabel@#(expr strname, pos) text p =
	label@#(TEX("$" & strname & "$"), pos) p
enddef;

% A start at 1
vardef push_stack(suffix A)(expr ele) :=
	save tmp;
	numeric tmp;
	tmp := A.len;
	if tmp < A.max_len:
		tmp := tmp + 1;
		A.len := tmp;
		A[tmp] := ele;
	fi;
enddef;

vardef pop_stack(suffix A) :=
	save tmp;
	numeric tmp;
	tmp := A.len;
	if tmp > 0:
		tmp := tmp - 1;
		A.len := tmp;
	fi;
enddef;

vardef img_stack(suffix A) :=
image(
	numeric gsize;
	gsize := .5cm;

	save len;
	numeric len;
	len := A.len;

	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	mathlabel("S", (0,0));
	mathlabel.rt("S.top = " & decimal(len), (len, -2) scaled gsize);
	drawarrow ((len+0.5, -1.4)--(len+0.5,-0.6)) scaled gsize;
	for i = 1 upto A.max_len:
		pair elepos, idxpos;
		elepos := (i, 0) scaled gsize;
		idxpos := (i, 1) scaled gsize;
		color bkcolor;
		if i > len:
			bkcolor := 0.2 white;
		else:
			bkcolor := 0.8 white;
		fi;
		fill (pelement shifted elepos) withcolor bkcolor;
		draw (pelement shifted elepos) withcolor black withpen (pencircle scaled 0.1 scaled gsize);

		if i <= len:
			mathlabel(decimal(A[i]), elepos);
		fi;

		mathlabel(decimal(i), idxpos);
	endfor;
)
enddef;

vardef imgTenOneOne(expr idx) :=
image(
	numeric A[];
	numeric A.len, A.max_len;
	A.len := 0;	% data length
	A.max_len := 6;	% container length

	numeric cnt;
	cnt := 1;

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;

	push_stack(A)(4);

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;

	push_stack(A)(1);

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;

	push_stack(A)(3);

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;

	pop_stack(A);

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;

	push_stack(A)(8);

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;

	pop_stack(A);

	if idx = cnt:
		draw img_stack(A);
	fi;
	cnt := cnt + 1;
)
enddef;

beginfig(1);
	draw imgTenOneOne(1);
endfig;

beginfig(2);
	draw imgTenOneOne(2);
endfig;

beginfig(3);
	draw imgTenOneOne(3);
endfig;

beginfig(4);
	draw imgTenOneOne(4);
endfig;

beginfig(5);
	draw imgTenOneOne(5);
endfig;

beginfig(6);
	draw imgTenOneOne(6);
endfig;

beginfig(7);
	draw imgTenOneOne(7);
endfig;

end;
