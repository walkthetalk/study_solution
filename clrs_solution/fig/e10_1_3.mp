input TEX;

vardef texlabel@#(expr strname, pos) text p =
	label@#(TEX(strname), pos) p
enddef;

vardef mathlabel@#(expr strname, pos) text p =
	label@#(TEX("$" & strname & "$"), pos) p
enddef;

% A start at 1
vardef enqueue(suffix Q)(expr x) :=
	save tail,head;
	numeric oldtail, tail, head;
	oldtail := Q.tail;
	tail := Q.tail;
	head := Q.head;

	if tail = Q.max_len:
		tail := 1;
	else:
		tail := tail + 1;
	fi;

	exitif tail = head;


	Q[oldtail] := x;
	Q.tail := tail;
enddef;

vardef dequeue(suffix Q) :=
	save tail,head;
	numeric tail, head;
	tail := Q.tail;
	head := Q.head;

	exitif tail = head;

	if head = Q.max_len:
		Q.head := 1;
	else:
		head := head + 1;
		Q.head := head;
	fi;
enddef;

vardef img_queue(suffix Q) :=
image(
	numeric gsize;
	gsize := .5cm;

	path pelement;
	pelement := unitsquare shifted(-0.5,-0.5) scaled gsize;
	mathlabel("Q", (0,0));
	mathlabel.rt("Q.head = " & decimal(Q.head), (Q.head-0.5, -2) scaled gsize);
	drawarrow ((Q.head, -1.4)--(Q.head,-0.6)) scaled gsize;
	mathlabel.rt("Q.tail = " & decimal(Q.tail), (Q.tail-0.5,  2) scaled gsize);
	drawarrow ((Q.tail,  1.4)--(Q.tail, 0.6)) scaled gsize;
	for i = 1 upto Q.max_len:
		boolean has_ele;
		if Q.head < Q.tail:
			if (Q.head <= i) and (i < Q.tail):
				has_ele := true;
			else:
				has_ele := false;
			fi;
		elseif Q.tail < Q.head:
			if (Q.tail <= i) and (i < Q.head):
				has_ele := false;
			else:
				has_ele := true;
			fi;
		else:	% Q.tail = Q.head
			has_ele := false;
		fi;

		pair elepos, idxpos;
		elepos := (i, 0) scaled gsize;
		idxpos := (i, 1) scaled gsize;

		color bkcolor;
		if has_ele:
			bkcolor := 0.8 white;
		else:
			bkcolor := 0.2 white;
		fi;
		fill (pelement shifted elepos) withcolor bkcolor;
		draw (pelement shifted elepos) withcolor black withpen (pencircle scaled 0.1 scaled gsize);

		if has_ele:
			mathlabel(decimal(Q[i]), elepos);
		fi;

		%mathlabel(decimal(i), idxpos); %container idx
	endfor;
)
enddef;

vardef imgTenOneThree(expr idx) :=
image(
	numeric Q[];
	numeric Q.head, Q.tail, Q.max_len;
	Q.head := 1;	% data length
	Q.tail := 1;
	Q.max_len := 6;	% container length

	numeric cnt;
	cnt := 1;

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;

	enqueue(Q)(4);

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;

	enqueue(Q)(1);

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;

	enqueue(Q)(3);

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;

	dequeue(Q);

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;

	enqueue(Q)(8);

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;

	dequeue(Q);

	if idx = cnt:
		draw img_queue(Q);
	fi;
	cnt := cnt + 1;
)
enddef;

beginfig(1);
	draw imgTenOneThree(1);
endfig;

beginfig(2);
	draw imgTenOneThree(2);
endfig;

beginfig(3);
	draw imgTenOneThree(3);
endfig;

beginfig(4);
	draw imgTenOneThree(4);
endfig;

beginfig(5);
	draw imgTenOneThree(5);
endfig;

beginfig(6);
	draw imgTenOneThree(6);
endfig;

beginfig(7);
	draw imgTenOneThree(7);
endfig;

end;
