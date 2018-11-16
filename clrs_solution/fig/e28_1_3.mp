vardef ele_pos(expr x, y, gsize) :=
	save pos; pair pos;
	pos := (x+0.5, y+0.5) xscaled gsize yscaled -gsize;
	pos
enddef;

vardef ND_DECIMAL(expr l) :=
	save ret; string ret;
	if (xpart l) = 0:
		ret := "0";
	elseif (ypart l) = 1:
		ret := decimal(xpart l);
	else:
		ret := decimal(xpart l) & "/" & decimal(ypart l);
	fi;
	ret
enddef;

vardef IMG_P(suffix M, pi)(expr pec, idx, exchange, gsize) :=
image(
	save n; numeric n; n := M.rows - 1;
	save i,j; numeric i,j;
	save pos; pair pos;

	% matrix outer frame
	draw unitsquare xscaled ((n+1) * gsize) yscaled -((n+1) * gsize) withcolor white;

	save xscale, yscale; numeric xscale,yscale; xscale := gsize; yscale := -gsize;

	% back
	if (pec = "e") or (pec = "c"):
		save left_back; path left_back;
		left_back := (idx, idx+1) -- (idx+1,idx+1) -- (idx+1,n+1) -- (idx, n+1) -- cycle;

		save top_back; path top_back;
		top_back := (idx+1, idx) -- (n+1, idx) -- (n+1, idx+1) -- (idx+1, idx+1) -- cycle;

		fill left_back xscaled xscale yscaled yscale withcolor .8white;
		fill top_back xscaled xscale yscaled yscale withcolor .8white;
	fi;

	% ladder
	save ladderidx; numeric ladderidx;
	if (pec = "p"):
		ladderidx := idx - 1;
	elseif (pec = "e"):
		ladderidx := idx - 1;
	elseif (pec = "c"):
		ladderidx := idx;
	fi;
	if (ladderidx >= 0):
		save ladder; path ladder;
		ladder := (0,1);
		for i := 1 upto ladderidx:
			ladder := ladder -- (i,i) -- (i, i+1);
		endfor;
		ladder := ladder -- (ladderidx+1,ladderidx+1);

		save rangle; path rangle;
		rangle := (ladderidx+1,n+1) -- (ladderidx+1,ladderidx+1) -- (n+1,ladderidx+1);

		draw ladder xscaled xscale yscaled yscale;
		draw rangle xscaled xscale yscaled yscale;
	fi;

	save privot; pair privot;
	if (pec = "p"):
		privot := (idx, exchange);
	elseif (pec = "e"):
		privot := (idx, idx);
	elseif (pec = "c"):
		privot := (idx, idx);
	fi;
	for i := 0 upto n:
		for j := 0 upto n:
			pos := ele_pos(j, i, gsize);
			if (j = xpart(privot)) and (i = ypart(privot)):
				fill fullcircle scaled .8gsize shifted pos;
				label(ND_DECIMAL(M[i][j]), pos) withcolor white;
			else:
				label(ND_DECIMAL(M[i][j]), pos);
			fi;
		endfor;
	endfor;

	% left frame
	draw unitsquare xscaled -.8gsize yscaled -((n+1) * gsize) shifted (-0.2gsize, 0);
	for i := 0 upto n:
		label(decimal(pi[i] + 1), ele_pos(-1.1, i, gsize));
	endfor;
	if (pec = "p"):
		drawarrow ((0, -idx)..(-0.5, -(exchange+idx)/2)..(0, -exchange))
			shifted(-1,-0.5) scaled gsize;
	fi;
)
enddef;

save picidx; numeric picidx;
picidx := 1;
vardef DRAW_IMG(expr img) :=
beginfig(picidx);
	draw img;
	picidx := picidx + 1;
endfig;
enddef;

vardef REG(suffix ele) :=
	save Tnum, Tdenom;
	numeric Tnum, Tdenom;
	Tnum := abs(xpart ele);
	Tdenom := abs(ypart ele);
	message "REG: " & decimal(Tnum) & "," & decimal(Tdenom);

	if Tnum = 0:
		ele := (0, 1);
	else:
		save mul; numeric mul; mul := 1;
		forever:
			exitif (odd Tnum) or (odd Tdenom);
			mul := mul * 2;
			Tnum := Tnum / 2;
			Tdenom := Tdenom / 2;
		endfor;
		forever:
			exitif Tnum = Tdenom;
			if Tnum > Tdenom:
				Tnum := Tnum - Tdenom;
			else:
				Tdenom := Tdenom - Tnum;
			fi;
		endfor;
		mul := mul * Tnum;
		ele := ele / mul;
		if (ypart ele) < 0:
			ele := -ele;
		fi;
	fi;
enddef;

vardef ND_DIV(expr l, r) :=
	save ret; pair ret;
	ret := ((xpart l) * (ypart r), (ypart l) * (xpart r));
	REG(ret);
	ret
enddef;

vardef ND_MUL(expr l, r) :=
	save ret; pair ret;
	ret := ((xpart l) * (xpart r), (ypart l) * (ypart r));
	REG(ret);
	ret
enddef;

vardef ND_SUB(expr l, r) :=
	message "ND_SUB: " & decimal(xpart l) & "," & decimal(ypart l)
		& "  " & decimal(xpart r) & "," & decimal(ypart r);
	save ret; pair ret;
	ret := ((xpart l) * (ypart r) - (xpart r) * (ypart l), (ypart l) * (ypart r));
	REG(ret);
	ret
enddef;

vardef ND_ADD(expr l, r) :=
	save ret; pair ret;
	ret := ((xpart l) * (ypart r) + (xpart r) * (ypart l), (ypart l) * (ypart r));
	REG(ret);
	ret
enddef;

vardef ND_ABS(expr l) :=
	save ret; pair ret;
	ret := (abs(xpart l), abs(ypart l));
	ret
enddef;

vardef ND_CMP(expr l, r) :=
	save ret; pair ret;
	ret := ND_SUB(l, r);
	save v; numeric v;
	if (xpart ret) < 0:
		v := -1;
	elseif (xpart ret) > 0:
		v := 1;
	else:
		v := 0;
	fi;
	v
enddef;

vardef LUP_DECOMPOSITION(suffix A)(expr gsize) :=
	save n; numeric n;
	n := A.rows - 1;
	save pi; numeric pi[];
	save i,j,k; numeric i,j,k;
	for i := 0 upto n:
		pi[i] := i;
	endfor;
	save B; pair B[][]; numeric B.rows;
	for i := 0 upto n:
		for j := 0 upto n:
			B[i][j] := A[i][j];
		endfor;
	endfor;
	B.rows := A.rows;

	for k := 0 upto (n - 1):
		save kpie; numeric kpie;
		save p; pair p; p := (0,1);
		for i := k upto n:
			%message "A[" & decimal(i) & "][" & decimal(k) & "] = " & decimal(A[i][k]);
			if ND_CMP(ND_ABS(B[i][k]), p) = 1:
				p := ND_ABS(B[i][k]);
				kpie := i;
			fi;
		endfor;
		if (xpart p) = 0:
			errmessage "singular matrix";
		fi;

		DRAW_IMG(IMG_P(B, pi)("p", k, kpie, gsize));

		if not (kpie = k):
			% exchange pi[k] and pi[kpie];
			save tmp; numeric tmp;
			tmp := pi[k];
			pi[k] := pi[kpie];
			pi[kpie] := tmp;

			for i := 0 upto n:
				save T; pair T;
				T := B[k][i];
				B[k][i] := B[kpie][i];
				B[kpie][i] := T;
			endfor;
		fi;

		DRAW_IMG(IMG_P(B, pi)("e", k, kpie, gsize));

		for i := (k+1) upto n:
			B[i][k] := ND_DIV(B[i][k], B[k][k]);
			for j := (k+1) upto n:
				B[i][j] := ND_SUB(B[i][j], ND_MUL(B[i][k],B[k][j]));
			endfor;
		endfor;

		DRAW_IMG(IMG_P(B, pi)("c", k, kpie, gsize));
	endfor;

	% print PA = LU;
	message "\left[\startmatrix";
	for i := 0 upto n:
		save S; string S; S := "";
		for j := 0 upto n:
			if j = pi[i]:
				S := S & "\NC 1 ";
			else:
				S := S & "\NC 0 ";
			fi;
		endfor;
		S := S & "\NR";
		message S;
	endfor;
	message "\stopmatrix\right]";
	message "\left[\startmatrix";
	for i := 0 upto n:
		save S; string S; S := "";
		for j := 0 upto n:
			S := S & "\NC " & ND_DECIMAL(A[i][j]) & " ";
		endfor;
		S := S & "\NR";
		message S;
	endfor;
	message "\stopmatrix\right]";
	message "=";
	message "\left[\startmatrix";
	for i := 0 upto n:
		save S; string S; S := "";
		for j := 0 upto n:
			if j > i:
				S := S & "\NC 0 ";
			elseif j = i:
				S := S & "\NC 1 ";
			else:
				S := S & "\NC " & ND_DECIMAL(B[i][j]) & " ";
			fi;
		endfor;
		S := S & "\NR";
		message S;
	endfor;
	message "\stopmatrix\right]";
	message "\left[\startmatrix";
	for i := 0 upto n:
		save S; string S; S := "";
		for j := 0 upto n:
			if j >= i:
				S := S & "\NC " & ND_DECIMAL(B[i][j]) & " ";
			else:
				S := S & "\NC 0 ";
			fi;
		endfor;
		S := S & "\NR";
		message S;
	endfor;
	message "\stopmatrix\right]";
enddef;

pair A[][]; numeric A.rows;
A.rows := 3;
A[0][0] := (1,1);	A[0][1] := (5,1);	A[0][2] := (4,1);
A[1][0] := (2,1);	A[1][1] := (0,1);	A[1][2] := (3,1);
A[2][0] := (5,1);	A[2][1] := (8,1);	A[2][2] := (2,1);
LUP_DECOMPOSITION(A)(.5in);

end;
