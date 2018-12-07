input schematic;

beginfig(1);
	clearObjs;
	setX("fig128");
	draw (0,0)--(1,0);
	draw (0,0)--(0,1);

	snewR.X(r1) "angle(90)";
	ObjLabel.X(r1)(btex $1$ etex);

	snewR.X(r2) "angle(90)";
	ObjLabel.X(r2)(btex $2$ etex);

	snewR.X(r4) "angle(90)";
	ObjLabel.X(r4)(btex $4$ etex);

	snewR.X(r3) "angle( 0)";
	ObjLabel.X(r3)(btex $3$ etex) "labrotate(30)";

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
	snewR.X(r1) "angle(90)";
	ObjLabel.X(r1)(btex $p_1$ etex)
		"labpoint(r_s)", "labdir(rt)";

	snewR.X(r2);
	ObjLabel.X(r2)(btex $p_2$ etex)
		"labpoint(r_s)", "labdir(bot)";

	snewR.X(r3) "angle(90)";
	ObjLabel.X(r3)(btex $p_3$ etex)
		"labpoint(r_s)", "labdir(rt)";

	snewR.X(r4);
	ObjLabel.X(r4)(btex $p_4$ etex)
		"labpoint(r_s)", "labdir(bot)";

	newDCS.X(u1) "angle(90)";
	ObjLabel.X(u1)(btex $p_5$ etex)
		"labpoint(r_s)", "labdir(urt)";
	ObjLabel.X(u1)(btex $0.4I$ etex)
		"labpoint(r_s)", "labdir(lrt)";
		

	snewBox.eb0(btex Box etex);
	eb0.c = (300,200);
	drawObj(eb0);

	X(r1).c = origin;
	X(r2).c = X(r1).c+(30,30);
	X(r3).c = X(r1).c+(60,0);
	X(r4).c = X(r2).c+(60,0);
	X(u1).c = X(r3).c + (60,0);
	drawObj(X(r1),X(r2),X(r3),X(r4),X(u1));

	pcsimple(X(u1))(2)(X(r4))(2);
	pcsimple(X(u1))(1)(X(r3))(1);
	pcsimple(X(r3))(2)(X(r4))(1);
	pcsimple(X(r3))(2)(X(r2))(2);
	pcsimple(X(r1))(2)(X(r2))(1);
	pcsimple(X(r3))(1)(X(r1))(1);

endfig;

end;
