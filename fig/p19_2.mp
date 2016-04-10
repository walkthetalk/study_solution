input TEX;

%rec_bin_tree;
vardef rec_bin_tree_frame(expr csize) :=
save frame;
path frame;
frame := fullcircle scaled csize;
frame
enddef;

vardef rec_bin_tree_node(expr csize) :=
image(
	draw rec_bin_tree_frame(csize) withcolor black;
	fill rec_bin_tree_frame(csize) withcolor 0.5 white;
)
enddef;

vardef rec_bin_tree_line(expr startcenter, stopcenter, csize) :=
image(
save line;
path line;
line := startcenter -- stopcenter;

save ret;
path ret;
ret := ((rec_bin_tree_frame(csize) shifted startcenter) intersectionpoint line)--
	((rec_bin_tree_frame(csize) shifted stopcenter) intersectionpoint line);
draw ret withcolor black;
)
enddef;

vardef rec_bin_tree(expr k, csize, gsize) :=
image(
	save pics;
	picture pics[];
	pics[0] := rec_bin_tree_node(csize);
	pics[1] := image(
		draw pics[0];
		draw pics[0] shifted (0, -gsize);
		draw rec_bin_tree_line((0,0), (0, -gsize), csize);
	);
	save i;
	numeric i;
	for i := 2 upto k:
		pics[i] := image(
			draw pics[i-1];
			save movepos;
			pair movepos;
			movepos := (xpart(llcorner(pics[i-1])) - gsize/3 - csize/2, -gsize);
			draw pics[i-1] shifted movepos;
			draw rec_bin_tree_line((0,0),movepos, csize);
		);
	endfor;
	
	draw pics[k];
	label.bot(TEX("$B_{" & decimal(k) & "}$"), (llcorner(pics[k]) + lrcorner(pics[k]))/2 + (0, -csize/2));
)
enddef;

vardef rec_bin_tree_sub(expr k, lbl, csize, gsize) :=
image(
if k = 0:
	draw rec_bin_tree(0, CSIZE, GSIZE);
else:
	save p;
	pair p[];
	p[0] := (0,0);
	p[1] := (-k * csize, -k * gsize);
	p[2] := (k * csize, -k * gsize);
	
	save basepic;
	picture basepic;
	basepic := image(
		draw rec_bin_tree_node(csize);
		draw ((p[0]--p[1]) intersectionpoint rec_bin_tree_frame(csize))
			--p[1]--p[2]--
			((p[2]--p[0]) intersectionpoint rec_bin_tree_frame(csize));
	);
	draw basepic;
	label.bot(TEX("$B_{" & lbl & "}$"), (llcorner(basepic) + lrcorner(basepic))/2);
fi;
)
enddef;

vardef rec_bin_tree_underbrace(expr ulcord, urcord, lbl) :=
image(
label.bot(TEX("$\underbrace{\kern " & decimal(xpart(urcord - ulcord)) & "pt}_{\textstyle " & lbl & "}$"),
	(ulcord + urcord)/2);
)
enddef;

numeric CSIZE, GSIZE;
CSIZE := .5cm;
GSIZE := 1.0cm;

beginfig(1);
save bk;
picture bk[];
bk[1] := image(
	save movepos;
	pair movepos;
	save basepic;
	picture basepic;
	basepic := rec_bin_tree_sub(1, "k-1", CSIZE, GSIZE);
	movepos := (xpart(llcorner(basepic) - lrcorner(basepic)), -GSIZE);

	save upperpic;
	picture upperpic;
	upperpic := image(
		draw basepic;
		draw basepic shifted movepos;
		draw rec_bin_tree_line((0,0), movepos, CSIZE);
	);
	draw upperpic;
	draw rec_bin_tree_underbrace(llcorner(upperpic), lrcorner(upperpic), "B_{k}");	
);
bk[0] := rec_bin_tree_sub(0, "0", CSIZE, GSIZE);
draw bk[0] shifted (-lrcorner(bk[0]) + (0, GSIZE/2));
draw bk[1] shifted (-llcorner(bk[1]) + (GSIZE, 0));
endfig;

beginfig(2);
save pics;
picture pics[];
pics[0] := rec_bin_tree(0, CSIZE, GSIZE);
pics[1] := rec_bin_tree(1, CSIZE, GSIZE);
pics[2] := rec_bin_tree(2, CSIZE, GSIZE);
pics[3] := rec_bin_tree(3, CSIZE, GSIZE);
pics[4] := rec_bin_tree(4, CSIZE, GSIZE);

save xoff, yoff;
numeric xoff, yoff;
xoff := -CSIZE;
yoff := 0;
for i := 4 downto 0:
	label(decimal(4-i), (GSIZE/2, yoff));
	draw pics[i] shifted (xoff, yoff);
	xoff := xoff + xpart(llcorner(pics[i])) - GSIZE;
	yoff := yoff - GSIZE;
endfor;
label.top("depth", (GSIZE/2, CSIZE));
endfig;

beginfig(3);
save pics;
picture pics[];
pics[0] := rec_bin_tree_sub(0, "0", CSIZE, GSIZE);
pics[1] := rec_bin_tree_sub(1, "1", CSIZE, GSIZE);
pics[2] := rec_bin_tree_sub(1.25, "2", CSIZE, GSIZE);
pics[4] := rec_bin_tree_sub(1.5, "k-2", CSIZE, GSIZE);
pics[5] := rec_bin_tree_sub(1.75, "k-1", CSIZE, GSIZE);
pics[3] := image(
	save basepic;
	picture basepic;
	basepic := image(fill fullcircle scaled 1/4 CSIZE;);

	draw basepic shifted (-1/2 CSIZE, 0);
	draw basepic;
	draw basepic shifted ( 1/2 CSIZE, 0);
);

save basepic;
picture basepic;
basepic := image(
	save len, num;
	numeric len, num;
	num := 6;
	len := CSIZE/2 * (num - 1);
	for i := 0 upto (num - 1):
		len := len + xpart(lrcorner(pics[i]) - llcorner(pics[i]));
	endfor;
	len := len - xpart(lrcorner(pics[0])) + xpart(lrcorner(pics[num - 1]));

	draw rec_bin_tree_node(CSIZE);
	save movepos;
	pair movepos;
	movepos := (len / 2, -1.5 * GSIZE);
	for i := 0 upto (num - 1):
		draw pics[i] shifted movepos;
		save line, postline;
		path line, postline;
		line := (0,0)--movepos;
		postline := (line intersectionpoint rec_bin_tree_frame(CSIZE))--
				(line intersectionpoint (rec_bin_tree_frame(CSIZE) shifted movepos));
		if i = 3:
			draw postline dashed evenly;
		else:
			draw postline;
		fi;
		if i < (num - 1):
			movepos := movepos + (xpart(llcorner(pics[i])) - CSIZE/2 - xpart(lrcorner(pics[i+1])), 0);
		fi;
	endfor;
);

draw basepic;
draw rec_bin_tree_underbrace(llcorner(basepic), lrcorner(basepic), "B_k");
endfig;

end;
