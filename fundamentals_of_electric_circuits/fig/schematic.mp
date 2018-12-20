input smetaobj;
input colordef;

numeric elesize_ratio;
elesize_ratio := 3;

vardef stringify_color(expr _c) =
	"(" & decimal(redpart(_c)) & ", "
	    & decimal(greenpart(_c)) & ", "
	    & decimal(bluepart(_c)) & ")"
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% schematic aux %%%%%%%%%%%%%%%%%%%%%%%%%%%
% WARNING: if no underbar, the name will be conflict with context internal
vardef stringifyFrame@#(expr _p)=
	message "   :"
	forsuffixes $=nw,n,ne:
		& "    "
		& "("
		& decimal(xpart (@# sc_(_p & str $)))
		& ","
		& decimal(ypart (@# sc_(_p & str $)))
		& ")"
	endfor;
	message "   :"
	forsuffixes $=w,e:
		& "    "
		& "("
		& decimal(xpart (@# sc_(_p & str $)))
		& ","
		& decimal(ypart (@# sc_(_p & str $)))
		& ")"
	endfor;
	message "   :"
	forsuffixes $=sw,s,se:
		& "    "
		& "("
		& decimal(xpart (@# sc_(_p & str $)))
		& ","
		& decimal(ypart (@# sc_(_p & str $)))
		& ")"
	endfor;
enddef;

vardef ShowOctAng(suffix n)=
	draw n.nnw--n.wnw--n.wsw--n.ssw--n.sse--n.ese--n.ene--n.nne--cycle;
enddef;
vardef ShowFrame(suffix n)=
	draw n.nw--n.sw--n.se--n.ne--cycle;
enddef;
vardef ShowIFrame(suffix n)=
	draw n.inw--n.isw--n.ise--n.ine--cycle;
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%% schematic equation #######################
vardef EqBPoints@#(expr _p)(expr _dx, _dy)=
	save tmp;
	def tmp(expr _a)=
		sc_(str @# & "." & _p & _a)
	enddef;
	%tmp("se")-tmp("sw")=tmp("ne")-tmp("nw");
	%tmp("n")=.5[tmp("ne"),tmp("nw")];
	%tmp("s")=.5[tmp("se"),tmp("sw")];
	%tmp("e")=.5[tmp("ne"),tmp("se")];
	%tmp("w")=.5[tmp("nw"),tmp("sw")];
	%tmp("c")=.5[tmp("n"), tmp("s")];
	%tmp("e")-tmp("w")=(tmp("dx"), 0);
	%tmp("n")-tmp("s")=(0, tmp("dy"));
	tmp("w") =(-_dx/2,      0) rotated @#ang shifted @#c;
	tmp("e") =( _dx/2,      0) rotated @#ang shifted @#c;
	tmp("n") =(     0,  _dy/2) rotated @#ang shifted @#c;
	tmp("s") =(     0, -_dy/2) rotated @#ang shifted @#c;
	tmp("nw")=(-_dx/2,  _dy/2) rotated @#ang shifted @#c;
	tmp("ne")=( _dx/2,  _dy/2) rotated @#ang shifted @#c;
	tmp("sw")=(-_dx/2, -_dy/2) rotated @#ang shifted @#c;
	tmp("se")=( _dx/2, -_dy/2) rotated @#ang shifted @#c;
enddef;

vardef EqFPoints@#(expr _f)(expr _b)=
	save _d, _s;
	def _d(suffix $)=
		sc_(str @# & "." & _f & str $)
	enddef;
	def _s(suffix $)=
		sc_(str @# & "." & _b & str $)
	enddef;
	save lx,rx,uy,ly;
	numeric lx,rx,uy,ly;
	lx = min(xpart _s(nw), xpart _s(ne), xpart _s(sw), xpart _s(se));
	rx = max(xpart _s(nw), xpart _s(ne), xpart _s(sw), xpart _s(se));
	ly = min(ypart _s(nw), ypart _s(ne), ypart _s(sw), ypart _s(se));
	uy = max(ypart _s(nw), ypart _s(ne), ypart _s(sw), ypart _s(se));
	_d(nw) = (lx, uy);
	_d(ne) = (rx, uy);
	_d(sw) = (lx, ly);
	_d(se) = (rx, ly);
	_d(n)  = (_d(nw) + _d(ne))/2;
	_d(s)  = (_d(sw) + _d(se))/2;
	_d(w)  = (_d(nw) + _d(sw))/2;
	_d(e)  = (_d(ne) + _d(se))/2;
enddef;

vardef SchematicEq@#=
	@#ang:= OptionValue@#("angle");
	@#dx = OptionValue@#("dx") * elesize_ratio;
	@#dy = OptionValue@#("dy") * elesize_ratio;

	save DX,DY; numeric DX,DY;
	DX = @#dx + 5;
	DY = @#dy + 5;

	EqBPoints@#("i")(@#dx, @#dy);
	EqBPoints@#("")(DX, DY);

	@#ic = @#c;

	@#nnw = (-@#dx/2, DY/2) rotated @#ang shifted @#c;
	@#nne = ( @#dx/2, DY/2) rotated @#ang shifted @#c;
	@#ssw = (-@#dx/2,-DY/2) rotated @#ang shifted @#c;
	@#sse = ( @#dx/2,-DY/2) rotated @#ang shifted @#c;
	@#wnw = (-DX/2, @#dy/2) rotated @#ang shifted @#c;
	@#wsw = (-DX/2,-@#dy/2) rotated @#ang shifted @#c;
	@#ene = ( DX/2, @#dy/2) rotated @#ang shifted @#c;
	@#ese = ( DX/2,-@#dy/2) rotated @#ang shifted @#c;

	EqFPoints@#("f")("i");
enddef;

%%%%%%%%%%%%%%%%%%%%%%%% schematic path ###########################
def SchematicBpath(suffix n)=
	(n.inw--n.isw--n.ise--n.ine--cycle);
enddef;

%%%%%%%%%%%%%%%%%%%%%%%% schematic interface #######################
vardef FramePoints(expr _p)=
	ObjPoint sc_(_p & "ne");
	ObjPoint sc_(_p & "nw");
	ObjPoint sc_(_p & "se");
	ObjPoint sc_(_p & "sw");
	ObjPoint sc_(_p & "n");
	ObjPoint sc_(_p & "s");
	ObjPoint sc_(_p & "e");
	ObjPoint sc_(_p & "w");
enddef;
def SchematicInterface(expr _pin_num) =
	ObjNumeric dx,dy,ang;
	% NOTE: the ic is only for default label position.
	%       the ic is always same as c.
	ObjPoint c, ic;
	ObjPoint nnw,nne,wnw,wsw,ssw,sse,ese,ene;
	FramePoints("i");
	FramePoints("");
	FramePoints("f");
	if (_pin_num > 0):
		ObjPointArray(pin)(_pin_num); % the pin array
		ObjNumericArray(pin_angle)(_pin_num); % the pin angle array;
	fi;
enddef;

% |_edge| w,e,n,s
vardef StdPos@#(suffix _edge)(expr _offset)=
	save _edgestr; string _edgestr; _edgestr:=str _edge;
	save _pu; numeric _pu; _pu:=5;
(
	if _edgestr = "n":
		(0, -@#dy/2) shifted (_offset * _pu, 0)
	elseif _edgestr = "s":
		(0, @#dy/2) shifted (_offset * _pu, 0)
	elseif _edgestr = "w":
		(-@#dx/2, 0) shifted (0, _offset * _pu)
	elseif _edgestr = "e":
		(@#dx/2, 0) shifted (0, _offset * _pu)
	fi
)
enddef;
vardef CirclePos@#(expr _angle)=
(
	(1,0) rotated _angle xscaled (@#dx/2) yscaled (@#dy/2)
)
enddef;
% NOTE: |_pos| must use i or b_ serias points
%       |_angle|: the angle for output direction
vardef defPin@#(expr _pinid, _pos, _angle) =
	@#pin[_pinid]=_pos rotated @#ang shifted @#c;
	@#pin_angle[_pinid]=_angle + @#ang;
enddef;

%%%%%%%%%%%%%%%%%%%%%% workaround for twice run problem %%%%%%%%%%%%%%%%
% WARNING: workaround for tex twice run problem, use it before every startMPcode
def clearObjsForTwiceRun =
	for i:= 0 upto nObj_:
		if known (iname_[i]):
			_clearObj_(sc_(iname_[i]));
		fi;
		_refresh_(ClassName_[i]);
		_refresh_(iname_[i]);
	endfor;
	nObj_ := 0;

	for i:= 0 upto nClasses_:
		_refresh_(Classes_[i]);
	endfor;
	nClasses_ := 0;

	for i:= 0 upto nshortcuts_:
		_refresh_(oname_[i]);
		_refresh_(ovalue_[i]);
	endfor;
	nshortcuts_ := 0;
enddef;
vardef _refresh_(text _v) =
	if known (_v):
		if numeric _v:
			_v := whatever;
		%else if string _v:
		%	_v := whateverstring;
		elseif pair _v:
			_v := whateverpair;
		fi;
	fi;
enddef;
vardef _clearObj_(suffix n) =
	% clear objlabel in 2nd running
	% please reference https://wiki.contextgarden.net/MetaObj_and_Labels.
	save _j;
	forsuffixes $=
		pointlist_,
		pairlist_,
		pointarraylist_,
		subarraylist_,
		stringarraylist_,
		colorarraylist_,
		picturearraylist_,
		transformarraylist_,
		booleanarraylist_,
		numericarraylist_,
		pairarraylist_,
		points_in_arrayslist_,
		picturelist_,
		numericlist_,
		booleanlist_,
		colorlist_,
		stringlist_,
		transformlist_,
		sublist_
		:
		if known n.$:
			forsuffixes _j=scantokens(n.$):
				if known n._j.n_:
					for i:=0 upto n._j.n_:
						_refresh_(n._j[i]);
					endfor;
					n._j.n_ := 0;
				else:
					_refresh_(n._j);
				fi;
			endfor;
			n.$:=whateverstring;
		fi;
	endfor;
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%% workaround for same name in different fig %%%%%%
% WARNING: only for constructing different objects in different beginfig
%   setX("test0");
%   newEmptyBox.X(eb0)();
string ObjPrefix_;
ObjPrefix_:="foec";
def setX(expr s)= ObjPrefix_:=s enddef;
def X(suffix s)= sc_(ObjPrefix_).s enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%% default options %%%%%%%%%%%%%%%%%%%%%%
setCurveDefaultOption("arrows")("draw");
setCurveDefaultOption("linecolor")(SteelBlue);

%%%%%%%%%%%%%%%%%%%%%%%%%% object math label %%%%%%%%%%%%%%%%%%%%
vardef ObjMLabel@#(text p) text options=
	ObjLabel@#(textext("$" & p & "$")) options;
enddef;

%%%%%%%%%%%%%%%%%% Resistor DIN %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("R")("angle")(0);
setObjectDefaultOption("R")("dx")(6);
setObjectDefaultOption("R")("dy")(2);
setObjectDefaultOption("R")("linecolor")(FireBrick);
setObjectDefaultOption("R")("pathfillcolor")(Khaki);
setObjectDefaultOption("R")("framed")(true);

vardef newR@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "R");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathR(@#)) "pathfilled(true)";
enddef;
def BpathR(suffix n)=
	SchematicBpath(n)
enddef;
def drawR(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Resistor ANSI %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Ra")("angle")(0);
setObjectDefaultOption("Ra")("dx")(6);
setObjectDefaultOption("Ra")("dy")(2);
setObjectDefaultOption("Ra")("linecolor")(Green);
setObjectDefaultOption("Ra")("pathfillcolor")(Khaki);
setObjectDefaultOption("Ra")("framed")(true);

vardef newRa@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Ra");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	save _rwire, _rwn; path _rwire; numeric _rwn;
	_rwn := 4;
	save _x;
	vardef _x(expr _i, _p)=
		((4 * (_i - 1) + _p)/(4 * _rwn))
	enddef;
	_rwire := (0,0);
	for i:=1 step 1 until _rwn:
		_rwire := _rwire
			-- (_x(i, 1), 0.5)
			-- (_x(i, 3),-0.5)
			-- (_x(i, 4),  0);
	endfor;
	ObjPath(_rwire shifted (-0.5,0)
		xscaled @#dx
		yscaled @#dy
		rotated @#ang
		shifted @#.c);
enddef;
def BpathRa(suffix n)=
	SchematicBpath(n)
enddef;
def drawRa(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Dependent Current Source %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("DCS")("angle")(0);
setObjectDefaultOption("DCS")("dx")(5);
setObjectDefaultOption("DCS")("dy")(5);
setObjectDefaultOption("DCS")("linecolor")(FireBrick);
setObjectDefaultOption("DCS")("pathfillcolor")(Khaki);

vardef newDCS@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "DCS");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";
	
	ObjPath(BpathDCS(@#)) "pathfilled(true)";
	ObjPath((.25[@#iw,@#.ie]--.75[@#.iw,@#.ie]))
		"arrows(drawarrow)";
enddef;
def BpathDCS(suffix n)=
	(n.in--n.iw--n.is--n.ie--cycle)
enddef;
def drawDCS(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Independent Current Source %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("ICS")("angle")(0);
setObjectDefaultOption("ICS")("dx")(4);
setObjectDefaultOption("ICS")("dy")(4);
setObjectDefaultOption("ICS")("linecolor")(FireBrick);
setObjectDefaultOption("ICS")("pathfillcolor")(Khaki);

vardef newICS@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "ICS");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathICS(@#)) "pathfilled(true)";
	ObjPath((.2[@#iw,@#.ie]--.8[@#.iw,@#.ie]))
		"arrows(drawarrow)";
enddef;
def BpathICS(suffix n)=
	(n.in..n.iw..n.is..n.ie..cycle)
enddef;
def drawICS(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Dependent Voltage Source %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("DVS")("angle")(0);
setObjectDefaultOption("DVS")("dx")(4);
setObjectDefaultOption("DVS")("dy")(4);
setObjectDefaultOption("DVS")("linecolor")(FireBrick);
setObjectDefaultOption("DVS")("pathfillcolor")(Khaki);

vardef newDVS@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "DVS");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathDVS(@#)) "pathfilled(true)";

	begingroup;
	save xxx;
	vardef xxx(suffix n)(expr _pos, _llur)=
		save lpos;pair lpos; lpos=_pos[n.iw,n.ie];
		((lpos-.5_llur)--(lpos+.5_llur))
	enddef;
	ObjPath(xxx(@#)(.3, (@#dx/4,0)));
	ObjPath(xxx(@#)(.7, (@#dx/4,0)));
	ObjPath(xxx(@#)(.7, (0,@#dy/4)));
	endgroup;
enddef;
def BpathDVS(suffix n)=
	(n.in--n.iw--n.is--n.ie--cycle)
enddef;
def drawDVS(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Inependent Voltage Source %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("IVS")("angle")(0);
setObjectDefaultOption("IVS")("dx")(4);
setObjectDefaultOption("IVS")("dy")(4);
setObjectDefaultOption("IVS")("linecolor")(FireBrick);
setObjectDefaultOption("IVS")("pathfillcolor")(Khaki);

vardef newIVS@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "IVS");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathIVS(@#)) "pathfilled(true)";

	begingroup;
	save xxx;
	vardef xxx(suffix n)(expr _pos, _llur)=
		save lpos;pair lpos; lpos=_pos[n.iw,n.ie];
		((lpos-.5_llur)--(lpos+.5_llur))
	enddef;
	ObjPath(xxx(@#)(.3, (@#dx/4,0)));
	ObjPath(xxx(@#)(.7, (@#dx/4,0)));
	ObjPath(xxx(@#)(.7, (0,@#dy/4)));
	endgroup;
enddef;
def BpathIVS(suffix n)=
	(fullcircle scaled n.dx shifted n.c)
enddef;
def drawIVS(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Current Direction Mark %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("CDM")("angle")(0);
setObjectDefaultOption("CDM")("dx")(3);
setObjectDefaultOption("CDM")("dy")(1);
setObjectDefaultOption("CDM")("linecolor")(FireBrick);
setObjectDefaultOption("CDM")("pathfillcolor")(Khaki);

vardef newCDM@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "CDM");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathCDM(@#)) "arrows(->)";
enddef;
def BpathCDM(suffix n)=
	(n.iw--n.ie)
enddef;
def drawCDM(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Node %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Node")("angle")(0);
setObjectDefaultOption("Node")("dx")(1);
setObjectDefaultOption("Node")("dy")(1);
setObjectDefaultOption("Node")("linecolor")(FireBrick);
setObjectDefaultOption("Node")("pathfillcolor")(FireBrick);
setObjectDefaultOption("Node")("pathfilled")(true);

vardef newNode@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Node");

	SchematicInterface(0);

	ObjCode "SchematicEq@#";

	ObjPath(BpathNode(@#));
enddef;
def BpathNode(suffix n)=
	(n.in..n.iw..n.is..n.ie..cycle)
enddef;
def drawNode(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Switch %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Switch")("angle")(0);
setObjectDefaultOption("Switch")("dx")(5);
setObjectDefaultOption("Switch")("dy")(5);
setObjectDefaultOption("Switch")("linecolor")(FireBrick);
setObjectDefaultOption("Switch")("pathfillcolor")(FireBrick);

vardef newSwitch@#(expr _defcp) text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Switch");

	SchematicInterface(4);

	ObjCode "SchematicEq@#",
		"defPin@#(3,CirclePos@#(180),180)",
		"defPin@#(1,CirclePos@#(60),0)",
		"defPin@#(2,CirclePos@#(-60),0)";

	ObjPath(BpathSwitch(@#));% "pathfilled(true)";
	%for i:=1 upto 3:
	%	ObjPath(fullcircle scaled 1 shifted @#.pin[i])
	%		"linecolor(blue)", "pathfillcolor(blue)", "pathfilled(true)";
	%endfor;
	ObjPath(@#.pin[3]--@#.pin[_defcp]) "arrows(->)";
enddef;
def BpathSwitch(suffix n)=
	(n.in..n.iw..n.is..n.ie..cycle)
enddef;
def drawSwitch(suffix n) =
	drawMemorizedPaths_(n);
enddef;
%%%%%%%%%%%%%%%%%%%%%%%% pin connection simple %%%%%%%%%%%%%%%%%%%
% ncdiaga: ncdiag without armlength, auto intersect two directions
% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef pcsimple@#(text n)(text pn)(text m)(text pm) text options =
	save knp,kmp; boolean knp,kmp;
	knp:= known n.pin.n_;
	kmp:= known m.pin.n_;
  ncshort_@#("nc","pcsimple")
	(if knp: n.pin[pn] else: n.c fi)
	(if kmp: m.pin[pm] else: m.c fi)
	(options
	 , "angleA(" & decimal(
		if knp: n.pin_angle[pn] else: pn fi
	   ) & ")"
	 , "angleB(" & decimal(
		if kmp: m.pin_angle[pm] + 180 else: pm fi
	   ) & ")"
	);
enddef;

vardef pcsimple_(suffix $)(suffix n,m)(suffix p)=
  % we have to find one additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap;pair ap[];
  save aA,aB;numeric aA, aB;
  aA := CLOV_("angleA");
  aB := CLOV_("angleB");

  setupobjectfunction(n);

  if ((aA-aB) mod 180 <> 0): % intersect
    ap1-f(n)("A")=whatever*dir(aA);
    f(m)("B")-ap1=whatever*dir(aB);
    nc_core_$(n)(p)
      (smoothen(object_(n)("A")--ap1--object_(m)("B")
         cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
      (smoothen(objectpoint_(n)("A")--ap1--objectpoint_(m)("B"))
         (CLOV_("linearc")));
  else: % same direction
    ap1-f(n)("A")=CLOV_("armA")*dir(aA);
    f(m)("B")-ap2=whatever*dir(aB);
    ap2-ap1=whatever*dir(aA-90);
    nc_core_$(n)(p)
      (smoothen(object_(n)("A")--ap1--ap2--object_(m)("B")
         cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
      (smoothen(objectpoint_(n)("A")--ap1--ap2--objectpoint_(m)("B"))
         (CLOV_("linearc")));
  fi;
enddef;
