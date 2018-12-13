
% text label
vardef tlabel@#(expr strname, pos) text p =
	label@#(textext(strname), pos) p
enddef;

% math label
vardef mlabel@#(expr strname, pos) text p =
	label@#(textext("$" & strname & "$"), pos) p
enddef;

% math label
vardef coordmlabel@#(expr strname, pos) text p =
	mlabel@#(strname, (pos xscaled ux yscaled uy)) p
enddef;

vardef defcoord(expr _ux, _uy, _ox, _oy, _ah) =
	numeric ux, uy, ox, oy, ah;
	ux := _ux;	% scale x
	uy := _uy;	% scale y
	ah := _ah;	% mark
	ox := _ox;	% offset x
	oy := _oy;	% offset y

	string defloc.x;
	defloc.x := "bot";
	string defloc.y;
	defloc.y := "lft";
enddef;

vardef defdim@#(expr name)(text pl) =
	string dname@#;
	numeric plist@#[];
	numeric pmid@#;
	string ploc@#[];
	string pmlabel@#[];

	dname@# := name;
	pmid@# := -1;
	for _p = pl:
		pmid@# := pmid@# + 1;
		plist@#[pmid@#] := _p;
		ploc@#[pmid@#] := defloc@#;
		pmlabel@#[pmid@#] := decimal(_p);
	endfor;
enddef;

vardef setloc@#(expr loc)(text pl) =
	for _p = pl:
		for i := 0 step 1 until pmid@#:
			if (plist@#[i] = _p):
				ploc@#[i] := loc;
			fi;
		endfor;
	endfor;
enddef;
vardef setlabel@#(expr _mark)(text pl) =
	for _p = pl:
		for i := 0 step 1 until pmid@#:
			if (plist@#[i] = _p):
				pmlabel@#[i] := _mark;
			fi;
		endfor;
	endfor;
enddef;

vardef coordsys =
image(
	% draw x
	numeric lftx, rtx;
	if plist.x[0] < 0:
		lftx := plist.x[0] * ux - ox;
	else:
		lftx := 0;
	fi;
	if plist.x[pmid.x] > 0:
		rtx := plist.x[pmid.x] * ux + ox;
	else:
		rtx := 0;
	fi;
	drawarrow (lftx,0)--(rtx,0);
	for i := 0 step 1 until pmid.x:
		draw (plist.x[i]*ux, 0)--(plist.x[i]*ux, ah);
		mlabel. scantokens(ploc.x[i]) (pmlabel.x[i], (plist.x[i]*ux, 0));
	endfor;
	mlabel.lrt(dname.x, (rtx, 0));

	% draw y
	numeric lowy, upy;
	if plist.y[0] < 0:
		lowy := plist.y[0] * uy - oy;
	else:
		lowy := 0;
	fi;
	if plist.y[pmid.y] > 0:
		upy := plist.y[pmid.y] * uy + oy;
	else:
		upy := 0;
	fi;
	drawarrow (0,lowy)--(0,upy);
	for i := 0 step 1 until pmid.y:
		draw (0,plist.y[i]*uy)--(ah,plist.y[i]*uy);
		mlabel. scantokens(ploc.y[i]) (pmlabel.y[i], (0,plist.y[i]*uy));
	endfor;
	mlabel.lft(dname.y, (0, upy));
)
enddef;

vardef polyval(expr x)(text _cl) =
	numeric _r, _p, _xp;
	_r := 0;	% ret
	_p := 0;	% power
	_xp:= 1;
	for _c = _cl:
		_r  := _r + _xp * _c;

		_xp := _xp * x;
		_p  := _p + 1;
	endfor;
	%message "(" & decimal(x) & ", " & decimal(_r) & ")";
	_r
enddef;

vardef polytan(expr x)(text _cl) =
	save _r, _p, _xp;
	numeric _r, _p, _xp;
	_r := 0;	% ret
	_p := 0;	% power
	_xp:= 1;
	for _c = _cl:
		if _p <> 0:
			_r  := _r + _p * _xp * _c;
			_xp := _xp * x;
		fi;
		_p  := _p + 1;
	endfor;
	_r
enddef;

vardef polydef@#(expr l,r,mx,ma)(text _pl) =
	save dist,j;
	numeric dist,j;
	numeric n@#;
	numeric x@#[];
	numeric y@#[];
	numeric t@#[];	% tan
	numeric a@#[];	% angle degree

	j := 0;
	x@#[j] := l;
	y@#[j] := polyval(x@#[j])(_pl);
	t@#[j] := polytan(x@#[j])(_pl);
	a@#[j] := angle(1, t@#[j]);

	forever:
		j := j + 1;
		dist := 2 * mx;
		forever:
			dist := dist / 2;
			x@#[j] := x@#[j-1] + dist;
			y@#[j] := polyval(x@#[j])(_pl);
			t@#[j] := polytan(x@#[j])(_pl);
			a@#[j] := angle(1,t@#[j]);
			adiff := abs(a@#[j-1] - a@#[j]);
			exitif (adiff < ma);
		endfor;

		exitif (x@#[j] >= r);
	endfor;

	x@#[j] := r;
	y@#[j] := polyval(r)(_pl);
	t@#[j] := polytan(r)(_pl);
	a@#[j] := angle(1, t@#[j]);

	n@# := j;
enddef;

vardef polyaux@# =
image(
	for i := 0 step 1 until n@#:
		pair ppos;
		ppos := ((x@#[i], y@#[i]) xscaled ux yscaled uy);
		draw fullcircle scaled 2 shifted ppos;
		message "####### " & decimal(i) & ": " & decimal(t@#[i]) & "       at " & decimal(x@#[i]);
		pair pdir;
		pdir := (1, t@#[i]) xscaled ux yscaled uy;
		pair pchui;
		pchui := (xpart(ppos) + xpart(pdir), ypart(ppos));
		draw ppos--pchui;
		draw pchui--(xpart(pchui), ypart(ppos)+ypart(pdir));
	endfor;
)
enddef;

vardef polycurve@# =
	for i := 0 step 1 until n@#:
		if (i = n@#):
			{(1, t@#[i])}
		fi
		(x@#[i], y@#[i])
		if (i < n@#):
			{(1, t@#[i])}..
		fi
	endfor
enddef;

vardef drawemp(expr pa) =
	draw pa xscaled ux yscaled uy withcolor DarkRed withpen pencircle scaled 1.2
enddef;
vardef drawref(expr pa) =
	draw pa xscaled ux yscaled uy withcolor blue withpen pencircle scaled 1.2
enddef;
vardef drawaux(expr pa) =
	draw pa xscaled ux yscaled uy dashed evenly
enddef;
vardef drawauxp.v(text _pl) =
	for _p = _pl:
		drawaux(_p--(xpart(_p), 0));
	endfor;
enddef;
vardef drawauxp.h(text _pl) =
	for _p = _pl:
		drawaux(_p--(0, ypart(_p)));
	endfor;
enddef;
vardef drawauxp.vh(text pl) =
	drawauxp.v(pl);
	drawauxp.h(pl);
enddef;
vardef drawauxp.p(text _pl) =
	for _p = _pl:
		draw fullcircle scaled 2 shifted (_p xyscaled(ux,uy))
			withcolor blue withpen pencircle scaled 1.2;
	endfor;
enddef;
