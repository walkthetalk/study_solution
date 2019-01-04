input smetaobj;
input colordef;

numeric elesize_ratio;
elesize_ratio := 3;
numeric eleconn_ratio;
eleconn_ratio := 10;
def UD(text _nop_)=
	((_nop_) * eleconn_ratio)
enddef;

vardef stringify_color(expr _c) =
	"(" & decimal(redpart(_c)) & ", "
	    & decimal(greenpart(_c)) & ", "
	    & decimal(bluepart(_c)) & ")"
enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% models %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef _model_coil(expr _n_)=
	save _h_; numeric _h_; _h_ := 0.4;
	save _p_; path _p_;
	_p_ := origin;
	_p_ := _p_{dir 90}..(0.5,_h_){dir 0}..{dir -90}(1,0);
	for i:=1 step 0.5 until _n_/2:
		_p_ := _p_..(i-0.25,-_h_){dir 180}..(i-0.5,0){dir 90}..(i,_h_){dir 0}..{dir -90}(i+0.5,0);
	endfor;

	_p_
enddef;

vardef model_coil(expr _l_, _n_)=
	save _xs_; numeric _xs_;
	_xs_ = _l_ / (_n_/2+0.5);
	(_model_coil(_n_) xscaled _xs_ yscaled _xs_)
enddef;

vardef model_zigzag(expr _n_)=
	save _rwire; path _rwire;
	save _x;
	vardef _x(expr _i, _p)=
		((4 * (_i - 1) + _p)/(4 * _n_))
	enddef;
	_rwire := (0,0);
	for i:=1 step 1 until _n_:
		_rwire := _rwire
			-- (_x(i, 1), 0.5)
			-- (_x(i, 3),-0.5)
			-- (_x(i, 4),  0);
	endfor;
	(_rwire shifted (-0.5,0))
enddef;


%%%%%%%%%%%%%%%%%%%%%%%%%%%% schematic aux %%%%%%%%%%%%%%%%%%%%%%%%%%%
% assign point value by regular value
% NOTE: X=[-0.5,0.5], Y=[-0.5,0.5]
def RegToReal(suffix n)(text _point_or_path_)=
	((_point_or_path_)
		xscaled (n.dx)
		yscaled (n.dy)
		rotated n.ang shifted n.c)
enddef;

vardef defXExt(expr _src_)=
	save _tmp; string tmp;
	tmp := "vardef X" & _src_ & "@# text _options_ ="
		& _src_ & " X(@#) _options_ "
		& "enddef;";
	sc_ tmp;
enddef;

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

vardef __SchematicEq@#=
	@#ang:= OptionValue@#("angle");

	save DX,DY; numeric DX,DY;
	DX = @#dx + 1*elesize_ratio;
	DY = @#dy + 1*elesize_ratio;

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

vardef SchematicEq@#=
	@#dx = OptionValue@#("dx") * elesize_ratio;
	@#dy = OptionValue@#("dy") * elesize_ratio;
	__SchematicEq@#;
enddef;

vardef SchematicPicEq@#(expr _pic)=
	@#dx = xpart (urcorner _pic - ulcorner _pic);
	@#dy = ypart (urcorner _pic - lrcorner _pic);
	__SchematicEq@#;
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
	save _pu; numeric _pu; _pu:=elesize_ratio;
(
	if _edgestr = "n":
		(0, @#dy/2) shifted (_offset * _pu, 0)
	elseif _edgestr = "s":
		(0, -@#dy/2) shifted (_offset * _pu, 0)
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
vardef defSpotPin@#(suffix _pinid, _pos, _angle) =
	@#pin[_pinid]=@#_pos;
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
vardef ObjTLabel@#(text p) text options=
	ObjLabel@#(textext(p)) options;
enddef;

vardef ObjMLP@#(text p)(suffix _labpoint_)(suffix _labdir_) text options=
	ObjMLabel@#(p)
		"labpoint(" & (str _labpoint_) & ")",
		if (str _labdir_) <> "c":
			"labdir(" & (str _labdir_) & ")",
		fi
		options;
enddef;
vardef ObjTLP@#(text p)(suffix _labpoint_)(suffix _labdir_) text options=
	ObjTLabel@#(p)
		"labpoint(" & (str _labpoint_) & ")",
		if (str _labdir_) <> "c":
			"labdir(" & (str _labdir_) & ")",
		fi
		options;
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

	ObjPath(RegToReal(@#)(model_zigzag(4)));
enddef;
def BpathRa(suffix n)=
	SchematicBpath(n)
enddef;
def drawRa(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Adjustable Resistor ANSI %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("ARa")("angle")(0);
setObjectDefaultOption("ARa")("dx")(12);
setObjectDefaultOption("ARa")("dy")(2);
setObjectDefaultOption("ARa")("linecolor")(Green);
setObjectDefaultOption("ARa")("pathfillcolor")(Khaki);
setObjectDefaultOption("ARa")("framed")(true);

vardef newARa@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "ARa");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(RegToReal(@#)(model_zigzag(8)));
	ObjPath(RegToReal(@#)((0.5,0)--(0.5,1.5)--(0,1.5)--(0,0.5)))
		"linecolor(SteelBlue)",
		"arrows(drawarrow)";
enddef;
def BpathARa(suffix n)=
	SchematicBpath(n)
enddef;
def drawARa(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% potentiometer %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Potentiometer")("angle")(0);
setObjectDefaultOption("Potentiometer")("dx")(6);
setObjectDefaultOption("Potentiometer")("dy")(2);
setObjectDefaultOption("Potentiometer")("linecolor")(Green);
setObjectDefaultOption("Potentiometer")("pathfillcolor")(Khaki);
setObjectDefaultOption("Potentiometer")("framed")(true);

vardef newPotentiometer@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Potentiometer");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(RegToReal(@#)(model_zigzag(4)));
	ObjPath(RegToReal(@#)((0.4,-1)--(-0.4,1)))
		"linecolor(FireBrick)",
		"arrows(drawarrow)";
enddef;
def BpathPotentiometer(suffix n)=
	SchematicBpath(n)
enddef;
def drawPotentiometer(suffix n) =
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

%%%%%%%%%%%%%%%%%% Light Bulb %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("LightBulb")("angle")(0);
setObjectDefaultOption("LightBulb")("dx")(6);
setObjectDefaultOption("LightBulb")("dy")(8.1);
setObjectDefaultOption("LightBulb")("linecolor")(FireBrick);
setObjectDefaultOption("LightBulb")("pathfillcolor")(Khaki);

vardef newLightBulb@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "LightBulb");

	SchematicInterface(2);
	ObjPairArray(bpl)(8); % bounding point list
	ObjNumeric coiln;

	ObjCode "SchematicEq@#",
		"defSpotPin@#(1,isw,180)",
		"defSpotPin@#(2,ise,0)";

	@#bpl[1] = (-0.345,0.24);
	@#bpl[2] = (-0.237,0.06);
	@#bpl[3] = (-0.185,-0.17);
	@#bpl[4] = (-0.185,-0.17);
	@#bpl[5] = (-0.185,-0.42);
	@#bpl[6] = (-0.46,-0.42);
	@#bpl[7] = (-0.5,-0.46);
	@#bpl[8] = (-0.5,-0.5);
	@#bpl[9] = (-0.19,0.2);
	@#bpl[10]= (-0.1,-0.17);
	@#coiln= 5;

	for i := -0.5 step 0.1 until 0.5:
		%ObjPath(RegToReal(@#)((i,0.5)--(i,-0.5))) "linecolor(blue)";
		%ObjPath(RegToReal(@#)((0.5,i)--(-0.5,i))) "linecolor(blue)";
	endfor;

	ObjPath(RegToReal(@#)(
		BpathLightBulbBulb(@#)
	)) "linecolor(Orange)";%, "linewidth(1)";
	%ObjPath(fullcircle shifted RegToReal(@#)(0,0));
	ObjPath(RegToReal(@#)(
		BpathLightBulbHull(@#)
	)) "linecolor(black)";%, "linewidth(1)";
	ObjPath(RegToReal(@#)(
		BpathLightBulbBase(@#)
	)) "linecolor(black)";%, "linewidth(1)";
enddef;
def BpathLightBulbA(suffix n)=
	(n.bpl[1]{dir -90}..{dir -40}n.bpl[2]..{dir -100}n.bpl[3])
enddef;
def BpathLightBulbB(suffix n)=
	(n.bpl[4]--n.bpl[5])
enddef;
vardef BpathLightBulbHull(suffix n)=
	(BpathLightBulbB(n)--(reverse BpathLightBulbB(n) xscaled (-1))--cycle)
enddef;
def BpathLightBulbC(suffix n)=
	(n.bpl[6]{dir 180}..{dir -90}n.bpl[7]--n.bpl[8])
enddef;
vardef BpathLightBulbBase(suffix n)=
	(BpathLightBulbC(n)--(reverse BpathLightBulbC(n) xscaled (-1))--cycle)
enddef;
def BpathLightBulbRod(suffix n)=
	(n.bpl[9]--n.bpl[10])
enddef;
def BpathLightBulbBulb(suffix n)=
	(BpathLightBulbA(n)--(reverse BpathLightBulbA(n) xscaled (-1))..{dir 180}(0,0.5)..cycle)
enddef;
vardef BpathLightBulbFlash(suffix n)=
	save _p; path _p;
	_p := (0, 0)--(1,0);
	for i := 0 upto 5:
		_p := _p -- ((.5,0) rotated (i * 30+15))
			-- ((1, 0) rotated (i * 30+30));
	endfor;
	_p := _p -- cycle;
	_p
enddef;
vardef BpathLightBulbScrew(suffix n)=
	(n.bpl[4]{dir -5}..(0, ypart n.bpl[4]){dir 5}..(n.bpl[4] xscaled (-1)){dir -5})
enddef;
vardef BpathLightBulbAux(suffix n)=
	save _p_; path _p_;
	_p_ := (BpathLightBulbA(n)--BpathLightBulbB(n)--BpathLightBulbC(n));
	(_p_--(reverse _p_ xscaled (-1))..{dir 180}(0,0.5)..cycle)
enddef;
def BpathLightBulb(suffix n)=
	RegToReal(n)(BpathLightBulbAux(n))
enddef;
vardef drawLightBulb(suffix n) =
	save _tsquare_;
	vardef _tsquare_(expr xstart, xend)=
		((xstart,-0.5)--(xend,-0.5)--(xend,0.5)--(xstart,0.5)--cycle)
	enddef;
	save _shadehull_; picture _shadehull_;
	_shadehull_ := image(
		fill _tsquare_(-0.5,-0.15) withcolor Gray;
		fill _tsquare_(xpart n.bpl[4],-0.05)
			withshademethod "linear"
			withshadevector (0,1)
			withshadecolors (Gray,white);
		fill _tsquare_(-0.05, 0.101)
			withshademethod "linear"
			withshadevector (0,1)
			withshadecolors (white,black);
		fill _tsquare_(0.099,-xpart n.bpl[4])
			withshademethod "linear"
			withshadevector (0,1)
			withshadecolors (black, Gray);
		for i := 1 upto 4:
			draw BpathLightBulbScrew(n) shifted (0, (-i * 0.02))
				withcolor black withpen (pencircle scaled 0.01);
		endfor;
	);
	clip _shadehull_ to BpathLightBulbHull(n);

	save _shadebulb_; picture _shadebulb_;
	_shadebulb_ := image(
		fill fullcircle scaled 1.5 shifted (0,0.4) withcolor yellow;
		fill fullcircle shifted (0,0.4)
			withshademethod "circular"
			%withshadevector (0.8, 1)
			%withshadecenter (0,0.8)
			withshadedomain (0,2)
			%withshadefactor 0.5
			withshadecolors (white,yellow);
		fill BpathLightBulbFlash(n) scaled 0.18 shifted (0,0.2) withcolor (.5white + .5yellow);
		% filament
		draw model_coil(-(xpart n.bpl[9])*2,n.coiln) shifted n.bpl[9] withcolor Orange withpen (pencircle scaled 0.02);
		% rod
		draw BpathLightBulbRod(n) withcolor LightSlateGray withpen (pencircle scaled 0.03);
		draw BpathLightBulbRod(n) xscaled (-1) withcolor LightSlateGray withpen (pencircle scaled 0.03);
	);
	clip _shadebulb_ to BpathLightBulbBulb(n);

	draw RegToReal(n)(_shadebulb_);
	draw RegToReal(n)(_shadehull_);

	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Loudspeaker %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Loudspeaker")("angle")(0);
setObjectDefaultOption("Loudspeaker")("dx")(4);
setObjectDefaultOption("Loudspeaker")("dy")(8);
setObjectDefaultOption("Loudspeaker")("linecolor")(FireBrick);
setObjectDefaultOption("Loudspeaker")("pathfillcolor")(Yellow);

vardef newLoudspeaker@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Loudspeaker");

	SchematicInterface(2);
	ObjPairArray(bpl)(6); % bounding point list

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w,1),90)",
		"defPin@#(2,StdPos@#(w,2),-90)";

	@#bpl[1] = (-0.5,0.2);
	@#bpl[2] = (-0.25,0.2);
	@#bpl[3] = (0.5,0.5);
	@#bpl[4] = @#bpl[1] yscaled -1;
	@#bpl[5] = @#bpl[2] yscaled -1;
	@#bpl[6] = @#bpl[3] yscaled -1;

	ObjPath(BpathLoudspeaker(@#)) "pathfilled(true)";
	ObjPath(RegToReal(@#)(@#.bpl[2]--@#.bpl[5]));
enddef;

def BpathLoudspeaker(suffix n)=
	RegToReal(n)(n.bpl[1]--n.bpl[2]--n.bpl[3]--n.bpl[6]--n.bpl[5]--n.bpl[4]--cycle)
enddef;
vardef drawLoudspeaker(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Current Direction Mark %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("CDM")("angle")(0);
setObjectDefaultOption("CDM")("dx")(4);
setObjectDefaultOption("CDM")("dy")(1);
setObjectDefaultOption("CDM")("arrows")("drawarrow");
setObjectDefaultOption("CDM")("linecolor")(FireBrick);
setObjectDefaultOption("CDM")("pathfillcolor")(Khaki);

vardef newCDM@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "CDM");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathCDM(@#));
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

%%%%%%%%%%%%%%%%%% LabelNode %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("LabelNode")("angle")(0);
%setObjectDefaultOption("LabelNode")("dx")(1);
%setObjectDefaultOption("LabelNode")("dy")(1);
setObjectDefaultOption("LabelNode")("linecolor")(FireBrick);
setObjectDefaultOption("LabelNode")("pathfillcolor")(Khaki);
setObjectDefaultOption("LabelNode")("pathfilled")(true);

vardef newLabelNode@#(expr _picstr)(expr _frmoption) text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "LabelNode");

	SchematicInterface(0);
	ObjPicture mainpic;
	@#.mainpic := thelabel(textext(
		"\framedtext[width=fit,frame=off,align=middle,offset=0pt,"
		& _frmoption
		& "]{"
		& _picstr
		& "}"
	), origin);

	ObjCode "SchematicPicEq@#(@#mainpic)";

	ObjPath(BpathLabelNode(@#));
enddef;
def BpathLabelNode(suffix n)=
	SchematicBpath(n)
enddef;
def drawLabelNode(suffix n) =
	drawMemorizedPaths_(n);
	draw n.mainpic rotated n.ang shifted n.c withcolor FireBrick;
enddef;

%%%%%%%%%%%%%%%%%% Digital Earth %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("DEarth")("angle")(0);
setObjectDefaultOption("DEarth")("dx")(3);
setObjectDefaultOption("DEarth")("dy")(1);
setObjectDefaultOption("DEarth")("linecolor")(Green);
setObjectDefaultOption("DEarth")("pathfillcolor")(Khaki);
setObjectDefaultOption("DEarth")("pathfilled")(true);

vardef newDEarth@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "DEarth");

	SchematicInterface(1);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(n, 0),90)";

	ObjPath(@#.inw--@#.ine);
	ObjPath(subpath (1/6,5/6) of (@#.iw--@#.ie));
	ObjPath(subpath (1/3,2/3) of (@#.isw--@#.ise));
enddef;
def BpathDEarth(suffix n)=
	SchematicBpath(n)
enddef;
def drawDEarth(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Battery %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Battery")("angle")(0);
setObjectDefaultOption("Battery")("dx")(3);
setObjectDefaultOption("Battery")("dy")(1);
setObjectDefaultOption("Battery")("linecolor")(Green);
setObjectDefaultOption("Battery")("pathfillcolor")(Khaki);
setObjectDefaultOption("Battery")("pathfilled")(true);

vardef newBattery@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Battery");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(n, 0),90)",
		"defPin@#(2,StdPos@#(s, 0),-90)";

	ObjPath(@#.inw--@#.ine);
	ObjPath(subpath (1/6,5/6) of (@#.isw--@#.ise));
enddef;
def BpathBattery(suffix n)=
	SchematicBpath(n)
enddef;
def drawBattery(suffix n) =
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

	SchematicInterface(3);

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

%%%%%%%%%%%%%%%%%% SSwitch %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("SSwitch")("angle")(0);
setObjectDefaultOption("SSwitch")("dx")(5);
setObjectDefaultOption("SSwitch")("dy")(5);
setObjectDefaultOption("SSwitch")("linecolor")(FireBrick);
setObjectDefaultOption("SSwitch")("pathfillcolor")(Yellow);

vardef newSSwitch@#(expr _defState) text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "SSwitch");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w,0),180)",
		"defPin@#(2,StdPos@#(e,0),0)";

	if (_defState):
		ObjPath(@#.pin[1]--@#.pin[2]) "arrows(->)";
	else:
		ObjPath(RegToReal(@#)(
			((0,0)--(1,0)) rotated 60 shifted (-0.5,0)
		)) "arrows(->)";
	fi;
	ObjPath(fullcircle shifted @#.pin[1]) "pathfilled(true)", "pathfillcolor(White)";
	ObjPath(fullcircle shifted @#.pin[2]) "pathfilled(true)", "pathfillcolor(White)";
enddef;
def BpathSSwitch(suffix n)=
	SchematicBpath(n)
enddef;
def drawSSwitch(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% TriSwitch %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("TriSwitch")("angle")(0);
setObjectDefaultOption("TriSwitch")("dx")(5);
setObjectDefaultOption("TriSwitch")("dy")(5 * sqrt(3));
setObjectDefaultOption("TriSwitch")("linecolor")(FireBrick);
setObjectDefaultOption("TriSwitch")("pathfillcolor")(Yellow);

vardef newTriSwitch@#(expr _defcp) text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "TriSwitch");

	SchematicInterface(4);

	ObjCode "SchematicEq@#",
		"defPin@#(4,StdPos@#(w,0),180)",
		"defPin@#(1,StdPos@#(n,0),60)",
		"defPin@#(2,StdPos@#(e,0),0)",
		"defPin@#(3,StdPos@#(s,0),-60)";

	ObjPath(BpathTriSwitch(@#)) "pathfilled(true)";
	ObjPath(@#.pin[4]--@#.pin[_defcp]) "arrows(->)";
	ObjPath(fullcircle shifted @#.pin[1]) "pathfilled(true)", "pathfillcolor(White)";
	ObjPath(fullcircle shifted @#.pin[2]) "pathfilled(true)", "pathfillcolor(White)";
	ObjPath(fullcircle shifted @#.pin[3]) "pathfilled(true)", "pathfillcolor(White)";
	ObjPath(fullcircle shifted @#.pin[4]) "pathfilled(true)", "pathfillcolor(White)";
enddef;
def BpathTriSwitch(suffix n)=
	(n.in..n.iw..n.is..n.ie..cycle)
enddef;
def drawTriSwitch(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Volt meter %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Vmeter")("angle")(0);
setObjectDefaultOption("Vmeter")("dx")(8);
setObjectDefaultOption("Vmeter")("dy")(8);
setObjectDefaultOption("Vmeter")("linecolor")(Green);
setObjectDefaultOption("Vmeter")("pathfillcolor")(Khaki);

vardef newVmeter@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Vmeter");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	ObjPath(BpathVmeter(@#))
		"linecolor(FireBrick)",
		"pathfilled(true)",
		"pathfillcolor(Yellow)";
	ObjPath(RegToReal(@#)(
		(-0.5,0)--(model_zigzag(4) xscaled 6/8 yscaled 2/8)--(0.5,0)
	));
	ObjPath(RegToReal(@#)(
		(halfcircle--cycle) scaled 0.5
		shifted (0,0.2)
	));
	ObjPath(RegToReal(@#)(
		(origin--(0.25,0) rotated 120)
		shifted (0,0.2)
	)) "linecolor(FireBrick)", "arrows(drawarrow)";
enddef;
def BpathVmeter(suffix n)=
	RegToReal(n)(fullcircle);
enddef;
def drawVmeter(suffix n) =
	drawMemorizedPaths_(n);
enddef;

%%%%%%%%%%%%%%%%%% Fuse %%%%%%%%%%%%%%%%%%
setObjectDefaultOption("Fuse")("angle")(0);
setObjectDefaultOption("Fuse")("dx")(4);
setObjectDefaultOption("Fuse")("dy")(2);
setObjectDefaultOption("Fuse")("linecolor")(Green);
setObjectDefaultOption("Fuse")("pathfillcolor")(Khaki);

vardef newFuse@# text options =
	ExecuteOptions(@#)(options);
	assignObj(@#, "Fuse");

	SchematicInterface(2);

	ObjCode "SchematicEq@#",
		"defPin@#(1,StdPos@#(w, 0),180)",
		"defPin@#(2,StdPos@#(e, 0),0)";

	save _x;
	vardef _x =
		save main;
		defcurve.main(-180,180,10,20)(sind)(3.1415926/180*cosd);
		pathcurve.main xscaled (1/360) yscaled (-1/2)
	enddef;
	ObjPath(RegToReal(@#)(_x));
enddef;
def BpathFuse(suffix n)=
	SchematicBpath(n)
enddef;
def drawFuse(suffix n) =
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

% NOTE: if _src_ contain '-', we can't use 'suffix' to iterate it.
%       so we need use custom function.
vardef Xsplitstr@#(expr _src_) =
	save _tc_, pcnt, scnt;
	string _tc_;

	@#idx := 0; @#[0] := "";
	numeric pcnt;pcnt:= 0;
	numeric scnt;scnt:= 0;
	for i:=1 upto length _src_:
		_tc_ := substring (i-1, i) of _src_;
		if (_tc_ = ",") and (pcnt = 0) and (scnt = 0):
			@#idx := @#idx + 1;
			@#[@#idx] := "";
		else:
			@#[@#idx] := @#[@#idx] & _tc_;
			if (_tc_ = "("):
				pcnt := pcnt + 1;
			elseif (_tc_ = ")"):
				pcnt := pcnt - 1;
			elseif (_tc_ = "["):
				scnt := scnt + 1;
			elseif (_tc_ = "]"):
				scnt := scnt - 1;
			fi;
		fi;
	endfor;
enddef;

vardef pclist@#(text _conns_) text options =
	save sstr;
	string sstr[];
	numeric sstr.idx;

	for $ = _conns_:
		Xsplitstr.sstr($);
		pcsimple@#
			(sc_ sstr[0])
			(sc_ sstr[1])
			(sc_ sstr[2])
			(sc_ sstr[3]) options;
	endfor;
enddef;

vardef Xpclist@#(text _conns_) text options =
	save sstr;
	string sstr[];
	numeric sstr.idx;

	for $ = _conns_:
		Xsplitstr.sstr($);
		pcsimple@#
			(X(sc_ sstr[0]))
			(sc_ sstr[1])
			(X(sc_ sstr[2]))
			(sc_ sstr[3]) options;
	endfor;
enddef;

vardef pcsimple_(suffix $)(suffix n,m)(suffix p)=
  % we have to find one additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap;pair ap[];
  save aA,aB,aC;numeric aA, aB, aC;
  aA := CLOV_("angleA");
  aB := CLOV_("angleB");

  setupobjectfunction(n);
  aC := angle(f(n)("A")-f(m)("B"));

  if ((aA-aB) mod 180 <> 0): % intersect
    ap1-f(n)("A")=whatever*dir(aA);
    f(m)("B")-ap1=whatever*dir(aB);
    nc_core_$(n)(p)
      (smoothen(object_(n)("A")--ap1--object_(m)("B")
         cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
      (smoothen(objectpoint_(n)("A")--ap1--objectpoint_(m)("B"))
         (CLOV_("linearc")));
  elseif ((aC-aA) mod 180 = 0): % should be direct line
    nc_core_$(n)(p)
      (smoothen(object_(n)("A")--object_(m)("B")
         cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
      (smoothen(objectpoint_(n)("A")--objectpoint_(m)("B"))
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

%%%%%%%%%%%%%%%%%%%%%%%%% X series %%%%%%%%%%%%%%%%%%%%%%%%%
defXExt("newNode");
defXExt("newLabelNode");
defXExt("newARa");
defXExt("newPotentiometer");
defXExt("newRa");
defXExt("newR");
defXExt("newSwitch");
defXExt("newSSwitch");
defXExt("newTriSwitch");
defXExt("newBattery");
defXExt("newIVS");
defXExt("newICS");
defXExt("newDVS");
defXExt("newDCS");
defXExt("newDEarth");
defXExt("newLightBulb");
defXExt("newLoudspeaker");
defXExt("newVmeter");
defXExt("newFuse");
defXExt("newCDM");
defXExt("ObjMLP");
defXExt("ObjTLP");

vardef Xncline@#(text n)(text m) text options =
	ncline@#(X(n))(X(m)) options;
enddef;
vardef Xnccurve@#(text n)(text m) text options =
	nccurve@#(X(n))(X(m)) options;
enddef;

def XdrawObj(text l)=
	forsuffixes $:=l:
		drawObj(X($));
	endfor;
enddef;
