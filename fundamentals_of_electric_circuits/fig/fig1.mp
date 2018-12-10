input schematic;
input latexmp;

labeloffset := 1;

vardef ObjMLabel@#(text p) text options=
	save _pic; picture _pic; _pic = textext("$" & p & "$");
	save _ppp; picture _ppp; _ppp = image (
		draw _pic;
		draw bbox(_pic);
	);
	ObjLabel@#(_ppp) options;
enddef;

beginfig(1);
	clearObjsForTwiceRun;
	setX("fig128");
	draw (0,0)--(1,0);
	draw (0,0)--(0,1);

	newR.X(r1) "angle(90)";
	ObjMLabel.X(r1)("1");

	newR.X(r2) "angle(90)";
	ObjMLabel.X(r2)("2");

	newR.X(r4) "angle(90)";
	ObjMLabel.X(r4)("4");

	newR.X(r3) "angle( 0)";
	ObjMLabel.X(r3)("3") "labrotate(30)";

	newBox.eb0(btex Box etex);
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
	clearObjsForTwiceRun;
	setX("fig129");

	newIVS.X(u1) "angle(90)";
	ObjMLabel.X(u1)("p_1")
		"labpoint(is)", "labdir(rt)";
	ObjMLabel.X(u1)("30V")
		"labpoint(in)", "labdir(lft)";

	newR.X(r2);
	ObjMLabel.X(r2)("p_2")
		"labpoint(is)", "labdir(bot)";
	ObjMLabel.X(r2)("+")
		"labpoint(inw)", "labdir(top)";
	ObjMLabel.X(r2)("-")
		"labpoint(ine)", "labdir(top)";
	ObjMLabel.X(r2)("10V")
		"labpoint(in)", "labdir(top)", "labshift((0,10))";

	newR.X(r3) "angle(90)";
	ObjMLabel.X(r3)("p_3")
		"labpoint(is)", "labdir(rt)";
	ObjMLabel.X(r3)("+")
		"labpoint(ine)", "labdir(lft)";
	ObjMLabel.X(r3)("-")
		"labpoint(inw)", "labdir(lft)";
	ObjMLabel.X(r3)("20V")
		"labpoint(in)", "labdir(lft)";

	newR.X(r4);
	ObjMLabel.X(r4)("p_4")
		"labpoint(is)", "labdir(bot)";
	ObjMLabel.X(r4)("+")
		"labpoint(inw)", "labdir(top)";
	ObjMLabel.X(r4)("-")
		"labpoint(ine)", "labdir(top)";
	ObjMLabel.X(r4)("8V")
		"labpoint(in)", "labdir(top)", "labshift((0,10))";

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
	uc := 10;
	X(r3).c = origin;
	X(u1).c = X(r3).c+(-9uc,0);
	X(u2).c = X(r3).c+( 9uc,0);
	X(r2).c = X(r3).c+(-3uc,5uc);
	X(r4).c = X(r3).c+( 3uc,5uc);

	X(cdm0).nnw = (xpart(X(u2).c), ypart(X(r4).c));
	X(cdm1).ssw = (xpart(X(u1).c), ypart(X(r2).c));
	X(cdm2).se = X(r3).ie;

	pcsimple(X(u2))(2)(X(r4))(2);
	pcsimple(X(r3))(1)(X(u2))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
	pcsimple(X(r3))(1)(X(u1))(1) "armA(ypart(X(r4).iw-X(r3).ie))";
	pcsimple(X(r3))(2)(X(r4))(1);
	pcsimple(X(r3))(2)(X(r2))(2);
	pcsimple(X(u1))(2)(X(r2))(1);

	drawObj(X(u1),X(r2),X(r3),X(r4),X(u2));
	drawObj(X(cdm0),X(cdm1),X(cdm2));
endfig;

beginfig(3);	clearObjsForTwiceRun;
	setX("fig131");

	newR.X(r0);
	ObjMLabel.X(r0)("-")
		"labpoint(ine)", "labdir(urt)";
	ObjMLabel.X(r0)("+")
		"labpoint(inw)", "labdir(ulft)";
	ObjMLabel.X(r0)("12V")
		"labpoint(n)", "labdir(top)", "labshift((0,10))";
	ObjMLabel.X(r0)("p_2")
		"labpoint(is)", "labdir(bot)";

	newR.X(r1) "angle(90)";
	ObjMLabel.X(r1)("-")
		"labpoint(ine)", "labdir(lft)";
	ObjMLabel.X(r1)("+")
		"labpoint(inw)", "labdir(lft)";
	ObjMLabel.X(r1)("V_0")
		"labpoint(n)", "labdir(lft)";
	ObjMLabel.X(r1)("p_3")
		"labpoint(is)", "labdir(rt)";

	newR.X(r2);
	ObjMLabel.X(r2)("-")
		"labpoint(ise)", "labdir(lrt)";
	ObjMLabel.X(r2)("+")
		"labpoint(isw)", "labdir(llft)";
	ObjMLabel.X(r2)("28V")
		"labpoint(s)", "labdir(bot)", "labshift((0,-10))";
	ObjMLabel.X(r2)("p_4")
		"labpoint(ie)", "labdir(urt)";

	newR.X(r3);
	ObjMLabel.X(r3)("-")
		"labpoint(ise)", "labdir(lrt)";
	ObjMLabel.X(r3)("+")
		"labpoint(isw)", "labdir(llft)";
	ObjMLabel.X(r3)("28V")
		"labpoint(s)", "labdir(bot)", "labshift((0,-10))";
	ObjMLabel.X(r3)("p_5")
		"labpoint(ie)", "labdir(urt)";

	newDVS.X(u2) "angle(-90)";
	ObjMLabel.X(u2)("5I_0")
		"labpoint(in)", "labdir(rt)";
	ObjMLabel.X(u2)("p_6")
		"labpoint(is)", "labdir(lft)";

	newIVS.X(u1) "angle(90)";
	ObjMLabel.X(u1)("30V")
		"labpoint(in)", "labdir(lft)";
	ObjMLabel.X(u1)("p_1")
		"labpoint(is)", "labdir(rt)";

	newCDM.X(cdm0) "angle(-90)";
	ObjMLabel.X(cdm0)("I")
		"labpoint(in)", "labdir(rt)";
	newCDM.X(cdm1) "angle(90)";
	ObjMLabel.X(cdm1)("4A")
		"labpoint(is)", "labdir(rt)";

	numeric uc;
	uc := 10;
	X(r1).c = origin;
	X(r0).c = X(r1).c + (-6uc, 6uc);
	X(r2).c = X(r1).c + ( 6uc, 6uc);
	X(r3).c = X(r1).c + ( 6uc,12uc);
	X(u1).c = X(r1).c + (-12uc,0);
	X(u2).c = X(r1).c + ( 12uc,0);
	X(cdm0).ssw = (xpart X(r1).c, ypart X(r0).ie + 5uc);
	X(cdm1).ne  = X(r0).ie + (0,5uc);

	drawObj(X(r0),X(r1),X(r2),X(r3),X(u1),X(u2));

	save _sl; string _sl; _sl := "armA(6uc - ypart(X(r1).c - X(r1).w))";
	pcsimple(X(u1))(2)(X(r0))(1);
	pcsimple(X(r0))(2)(X(r1))(2);
	pcsimple(X(r1))(2)(X(r2))(1);
	pcsimple(X(r1))(2)(X(r3))(1);
	pcsimple(X(r2))(2)(X(u2))(1);
	pcsimple(X(r3))(2)(X(u2))(1);
	pcsimple(X(r1))(1)(X(u2))(2) _sl;
	pcsimple(X(r1))(1)(X(u1))(1) _sl;
	%pcsimple(X(r0))(2)(X(u1))(1) "armA(5uc)";
	%pcsimple(X(r0))(1)(X(u1))(2) "armA(3uc)";
	%pcsimple(X(r0))(1)(X(u2))(2) "armA(3uc)";
	%pcsimple(X(r1))(1)(X(u2))(1);
	%drawObj(X(cdm0),X(cdm1));
endfig;

end;
