

vardef image_dfs_par_struc(suffix treelist)(expr xsize, ysize) :=
image(
% draw background
save lbl;
string lbl[];
save lineidx;
numeric lineidx;
save maxlvl;
numeric maxlvl;
maxlvl := 0;
lineidx := 0;
i := 0;
forever:
	exitif unknown treelist[i];
	save len;
	numeric len;
	len := length treelist[i];
	if len > maxlvl:
		maxlvl := len;
	fi;

	for j := 0 upto (len - 1):
		lbl[lineidx] := "(" & substring (j,j+1) of treelist[i];
		lineidx := lineidx + 1;
	endfor;
	for j := (len) downto 1:
		lbl[lineidx] := substring (j-1, j) of treelist[i] & ")";
		lineidx := lineidx + 1;
	endfor;
	i := i + 1;
endfor;

for i := 0 upto (lineidx - 1):
	save ylen;
	numeric ylen;
	ylen := 2 * maxlvl + 1;
	draw ((i, 0)--(i, -ylen)) xscaled xsize yscaled ysize dashed evenly withcolor (0.35,0.5,0.65);
	label(decimal(i + 1), (i, -ylen - 0.5) xscaled xsize yscaled ysize);
	label(lbl[i], (i, -ylen - 1.5) xscaled xsize yscaled ysize);
endfor;

% draw nodes
save treestart;
numeric treestart;
treestart := 0;
i := 0;
forever:
	exitif unknown treelist[i];
	save len;
	numeric len;
	len := length treelist[i];
	for j := 0 upto (len - 1):
		save pos;
		pair pos;
		pos := ((len*2 - 1)/2 + treestart, -j * 2 - 1.5);

		draw (unitsquare shifted (-0.5,-0.5)
			xscaled (2 * len - 1 - 2 * j)
			shifted pos
			xscaled xsize yscaled ysize);
		label(substring (j,j+1) of treelist[i], pos xscaled xsize yscaled ysize);
		if j < (len - 1):
			drawarrow ((xpart(pos),ypart(pos)-0.5)--(xpart(pos), ypart(pos) -1.5)) xscaled xsize yscaled ysize;
		fi;
	endfor;
	treestart := treestart + 2 * len;
	i := i + 1;
endfor;
)
enddef;

beginfig(1);
save treelist;
string treelist[];
treelist[0] := "uvyx";
treelist[1] := "wz";
draw image_dfs_par_struc(treelist)(.75cm,.5cm);
endfig;

end;
