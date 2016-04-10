vardef rtlabel@#(expr strname, pos) text p =
	label@#(textext(strname), pos) p
enddef;

vardef rlc(suffix A)(expr k, x_coord, y_coord, lvl, cell_h, cell_w, y_offset) :=
	save nextlvl_dist,next_y_coord,next_x_coord, next_lvl;
	rtlabel(A[lvl], (x_coord, y_coord)) withcolor black;
	if lvl > 1:
		next_lvl := lvl - 1;
		nextlvl_dist := k ** (next_lvl - 1) * cell_w;

		next_y_coord := y_coord - cell_h;
		next_x_coord := x_coord - nextlvl_dist * (k - 1) / 2;
		for i := 0 upto (k - 1):
			draw (x_coord, y_coord - y_offset)--(next_x_coord, next_y_coord + y_offset);
			rlc(A)(k, next_x_coord, next_y_coord, next_lvl, cell_h, cell_w, y_offset);
			next_x_coord := next_x_coord + nextlvl_dist;
		endfor;
	else:
		next_y_coord := y_coord - cell_h;
		next_x_coord := x_coord;

		draw (x_coord, y_coord - y_offset)--(next_x_coord, next_y_coord + y_offset) dashed evenly;
		rtlabel(A[0], (next_x_coord, next_y_coord)) withcolor black;
	fi;
enddef;


vardef rectree(suffix A, B)(expr k, lvl, cell_w, cell_h, y_offset) :=
	rlc(A)(k, 0, 0, lvl, cell_h, cell_w, y_offset);

	string lbl;
	bound_pos_x := (k ** (lvl - 1) - 1) * cell_w / 2 + cell_w;
	bound_pos_y := 0;
	for i := lvl downto 0:
		rtlabel(B[i], (bound_pos_x, bound_pos_y));
		bound_pos_y := bound_pos_y - cell_h;
	endfor;
enddef;

vardef width_of_label(expr lbl) :=
	pair sss;
	sss := urcorner thelabel.rt(lbl, (0,0));
	xpart sss
enddef;
vardef rlc_vertical(suffix A)(expr k, x_coord, y_coord, lvl, cell_w, cell_h, x_offset) :=
	save nextlvl_dist,next_y_coord,next_x_coord, next_lvl, lbl_width;
	lbl_width := width_of_label(A[lvl]);
	rtlabel.rt(A[lvl], (x_coord, y_coord)) withcolor black;
	if lvl > 1:
		next_lvl := lvl - 1;
		nextlvl_dist := k ** (next_lvl - 1) * cell_h;

		next_x_coord := x_coord + lbl_width + cell_w;
		next_y_coord := y_coord - nextlvl_dist * (k - 1) / 2;
		for i := 0 upto (k - 1):
			draw (x_coord + lbl_width + x_offset, y_coord)
			   --(next_x_coord - x_offset, next_y_coord);
			rlc_vertical(A)(k, next_x_coord, next_y_coord, next_lvl, cell_w, cell_h, x_offset);
			next_y_coord := next_y_coord + nextlvl_dist;
		endfor;
	else:
		next_x_coord := x_coord + lbl_width + cell_w;
		next_y_coord := y_coord;

		draw (x_coord + lbl_width + x_offset, y_coord)
		   --(next_x_coord - x_offset, next_y_coord) dashed evenly;
		rtlabel.rt(A[0], (next_x_coord, next_y_coord)) withcolor black;
	fi;
enddef;


vardef rectree_vertical(suffix A, B)(expr k, lvl, cell_w, cell_h, x_offset) :=
	rlc_vertical(A)(k, 0, 0, lvl, cell_w, cell_h, x_offset);

	string lbl;
	bound_pos_y := (k ** (lvl - 1) - 1) * cell_h / 2 + cell_h;
	bound_pos_x := 0;
	for i := lvl downto 0:
		bound_pos_x := bound_pos_x + width_of_label(A[i])/2;
		rtlabel(B[i], (bound_pos_x, -bound_pos_y));
		bound_pos_x := bound_pos_x + width_of_label(A[i])/2 + cell_w;
	endfor;
enddef;



vardef rlc_single_side_binary(suffix A, S)(expr k, x_coord, y_coord, lvl, cell_h, cell_w, y_offset) :=
	save nextlvl_dist,next_y_coord,next_x_coord, next_lvl;
	rtlabel(A[lvl], (x_coord, y_coord)) withcolor black;
	if lvl >= 1:
		next_lvl := lvl - 1;
		nextlvl_dist := cell_w;

		next_y_coord := y_coord - cell_h;
		next_x_coord := x_coord - nextlvl_dist * (k - 1) / 2;
		for i := 0 upto (k - 1):
			if lvl > 1:
				draw (x_coord, y_coord - y_offset)--(next_x_coord, next_y_coord + y_offset);
			else:
				draw (x_coord, y_coord - y_offset)--(next_x_coord, next_y_coord + y_offset) dashed evenly;
			fi;
			if i < (k - 1):
				rlc_single_side_binary(A,S)(k, next_x_coord, next_y_coord, next_lvl, cell_h, cell_w, y_offset);
			else:
				rtlabel(S, (next_x_coord, next_y_coord)) withcolor black;
			fi;
			next_x_coord := next_x_coord + nextlvl_dist;
		endfor;
	fi;
enddef;


vardef rectree_single_side_binary(suffix A, B, S)(expr k, lvl, cell_w, cell_h, y_offset) :=
	rlc_single_side_binary(A,S)(k, 0, 0, lvl, cell_h, cell_w, y_offset);

	string lbl;
	bound_pos_x := lvl * cell_w / 2 + cell_w;
	bound_pos_y := 0;
	for i := lvl downto 0:
		rtlabel(B[i], (bound_pos_x, bound_pos_y));
		bound_pos_y := bound_pos_y - cell_h;
	endfor;
enddef;


