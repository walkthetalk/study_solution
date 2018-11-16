
vardef img_grid(expr vinfo, einfo) :=
image(
save gsize; numeric gsize; gsize := .5cm;
save vesize; numeric vesize; vesize := .15cm;
save vfsize; numeric vfsize; vfsize := .2cm;

save i,j;
numeric i,j;

% draw edge
i := 0; j := 0;
save elen; numeric elen;
for elen := 0 upto (length(einfo) - 1):
	save tmp; string tmp;
	tmp := substring(elen, elen+1) of einfo;
	if tmp = " ":
		i := i + 1;
		j := 0;
	else:
		save spos; pair spos; spos := (j,i div 2)scaled gsize;
		save epos; pair epos;
		if (i mod 2) = 0:
			epos := (j+1, i div 2) scaled gsize;
		else:
			epos := (j, (i div 2) + 1) scaled gsize;
		fi;

		if tmp = "1":
			draw spos -- epos withpen pencircle scaled 3 withcolor .6white;
		fi;
		draw spos -- epos withpen pencircle;
		j := j + 1;
	fi;
endfor;
% draw vertex
i := 0; j := 0;
save vlen; numeric vlen;
for vlen := 0 upto (length(vinfo) - 1):
	save tmp; string tmp;
	tmp := substring(vlen, vlen+1) of vinfo;
	if tmp = " ":
		i := i + 1;
		j := 0;
	else:
		save pos; pair pos; pos := (j,i)scaled gsize;
		save pp; path pp; pp := fullcircle scaled vesize shifted pos;
		if tmp = "0":
			fill pp withcolor white;
			draw pp;
		else:
			fill fullcircle scaled vfsize shifted pos;
		fi;
		j := j + 1;
	fi;
endfor;
)
enddef;

beginfig(1);
string Vinfo;
Vinfo := "000000 010101 110101 010101 000000 000000";
string Einfo;
Einfo := "00000 011110 00000 001010 01010 000000 01000 001100 00000 001100 00000";
draw img_grid(Vinfo, Einfo);
endfig;

beginfig(2);
string Vinfo;
Vinfo := "000000 010101 110101 010101 000000 000000";
string Einfo;
Einfo := "00000 000000 00000 000000 00000 000000 00000 000000 00000 000000 00000";
draw img_grid(Vinfo, Einfo);
endfig;

end;
