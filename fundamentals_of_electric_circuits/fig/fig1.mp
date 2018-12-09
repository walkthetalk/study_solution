input schematic;
input latexmp;

labeloffset := 0;
laboff     :=(  0,  0); labxf     :=.5;  labyf     :=.5;
laboff.lft :=( -1,  0); labxf.lft :=1 ;  labyf.lft :=.5;
laboff.rt  :=(  1,  0); labxf.rt  :=0 ;  labyf.rt  :=.5;
laboff.bot :=(  0, -1); labxf.bot :=.5;  labyf.bot :=1 ;
laboff.top :=(  0,  1); labxf.top :=.5;  labyf.top :=0 ;
laboff.ulft:=(-.7, .7); labxf.ulft:=1 ;  labyf.ulft:=0 ;
laboff.urt :=( .7, .7); labxf.urt :=0 ;  labyf.urt :=0 ;
laboff.llft:=(-.7,-.7); labxf.llft:=1 ;  labyf.llft:=1 ;
laboff.lrt :=( .7,-.7); labxf.lrt :=0 ;  labyf.lrt :=1 ;

vardef ObjMLabel@#(text p) text options=
	save _pic; picture _pic; _pic = textext("$" & p & "$");
	save _ppp; picture _ppp; _ppp = image (
		draw _pic;
		draw bbox(_pic);
	);
	ObjLabel@#(_ppp) options;
enddef;

beginfig(1);
	clearObjs;
	setX("fig128");
	draw (0,0)--(1,0);
	draw (0,0)--(0,1);

	snewR.X(r1) "angle(90)";
	ObjMLabel.X(r1)("1");

	snewR.X(r2) "angle(90)";
	ObjMLabel.X(r2)("2");

	snewR.X(r4) "angle(90)";
	ObjMLabel.X(r4)("4");

	snewR.X(r3) "angle( 0)";
	ObjMLabel.X(r3)("3") "labrotate(30)";

	snewBox.eb0(btex Box etex);
	eb0.c = (300,200);
	drawObj(eb0);

	X(r1).c = origin;
	X(r2).c = X(r1).c+(30,0);
	X(r4).c = X(r2).c+(60,0);
	X(r3).c = (X(r2).c+X(r4).c)/2 + (0,30);
	drawObj(X(r1),X(r2),X(r3),X(r4));

	pcsimple(X(r3))(2)(X(r4))(2);
	pcsimple(X(r3))(1)(X(r2))(2);
	pcsimple(X(r1))(2)(X(r3))(1);
	pcsimple(X(r2))(1)(X(r4))(1)
		"armA(ypart(X(r3).c-X(r2).n))";
	pcsimple(X(r2))(1)(X(r1))(1)
		"armA(ypart(X(r3).c-X(r2).n))";
endfig;

beginfig(2);
	clearObjs;
	setX("fig129");
	draw (0,0)--(1,0);
	draw (0,0)--(0,1);
	snewIVS.X(u1) "angle(90)";
	ObjMLabel.X(u1)("p_1")
		"labpoint(is)", "labdir(rt)";
	ObjMLabel.X(u1)("30V")
		"labpoint(in)", "labdir(lft)";

	snewR.X(r2);
	ObjMLabel.X(r2)("p_2")
		"labpoint(is)", "labdir(bot)";
	ObjMLabel.X(r2)("+")
		"labpoint(inw)", "labdir(top)";
	ObjMLabel.X(r2)("-")
		"labpoint(ine)", "labdir(top)";
	ObjMLabel.X(r2)("10V")
		"labpoint(in)", "labdir(top)";

	snewR.X(r3) "angle(90)";
	ObjMLabel.X(r3)("p_3")
		"labpoint(is)", "labdir(rt)";
	ObjMLabel.X(r3)("+")
		"labpoint(ine)", "labdir(lft)";
	ObjMLabel.X(r3)("-")
		"labpoint(inw)", "labdir(lft)";
	ObjMLabel.X(r3)("20V")
		"labpoint(in)", "labdir(lft)";

	snewR.X(r4);
	ObjMLabel.X(r4)("p_4")
		"labpoint(is)", "labdir(bot)";
	ObjMLabel.X(r4)("+")
		"labpoint(inw)", "labdir(top)";
	ObjMLabel.X(r4)("-")
		"labpoint(ine)", "labdir(top)";
	ObjMLabel.X(r4)("8V")
		"labpoint(in)", "labdir(top)";

	newDCS.X(u2) "angle(90)";
	ObjMLabel.X(u2)("p_5")
		"labpoint(is)", "labdir(urt)";
	ObjMLabel.X(u2)("0.4I")
		"labpoint(is)", "labdir(lrt)";
	ObjMLabel.X(u2)("12V")
		"labpoint(in)", "labdir(lft)";
	ObjMLabel.X(u2)("+")
		"labpoint(ie)", "labdir(ulft)";
	ObjMLabel.X(u2)("-")
		"labpoint(iw)", "labdir(llft)";

	newCDM.X(cdm0) "angle(180)";
	ObjMLabel.X(cdm0)("4A")
		"labpoint(is)", "labdir(top)";
	newCDM.X(cdm1);
	ObjMLabel.X(cdm1)("I=10A")
		"labpoint(in)", "labdir(top)";
	newCDM.X(cdm2) "angle(-90)";
	ObjMLabel.X(cdm2)("14A")
		"labpoint(in)", "labdir(rt)";

	numeric uc;
	uc := 45;
	X(u1).c = origin;
	X(r2).c = X(u1).c+(uc,uc);
	X(r3).c = X(u1).c+(2uc,0);
	X(r4).c = X(r2).c+(2uc,0);
	X(u2).c = X(r3).c + (2uc,0);

	X(cdm0).inw = (xpart(X(u2).c), ypart(X(r4).c));
	X(cdm1).isw = (xpart(X(u1).c), ypart(X(r2).c));
	X(cdm2).ese = X(r3).ie;

	drawObj(X(u1),X(r2),X(r3),X(r4),X(u2));
	drawObj(X(cdm0),X(cdm1),X(cdm2));

	pcsimple(X(u2))(2)(X(r4))(2);
	pcsimple(X(r3))(1)(X(u2))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
	pcsimple(X(r3))(1)(X(u1))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
	pcsimple(X(r3))(2)(X(r4))(1);
	pcsimple(X(r3))(2)(X(r2))(2);
	pcsimple(X(u1))(2)(X(r2))(1);

	ShowIFrame(X(u1));
	ShowFrame(X(u1));
	ShowIFrame(X(cdm2));
	ShowFrame(X(cdm2));
	ShowIFrame(X(cdm0));
	ShowFrame(X(cdm0));
endfig;

end;
