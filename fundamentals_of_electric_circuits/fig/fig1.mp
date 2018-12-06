input schematic;

beginfig(1);
	draw (0,0)--(1,0);
	draw (0,0)--(0,1);

	snewR.r1 "angle(90)";
	ObjLabel.r1(btex $1$ etex);

	snewR.r2 "angle(90)";
	ObjLabel.r2(btex $2$ etex);

	snewR.r4 "angle(90)";
	ObjLabel.r4(btex $4$ etex);

	snewR.r3 "angle( 0)";
	ObjLabel.r3(btex $3$ etex) "labrotate(30)";

	snewBox.eb0(btex Box etex);
	eb0.c = (300,200);
	drawObj(eb0);

	r1.c = origin;
	r2.c = r1.c+(30,0);
	r4.c = r2.c+(60,0);
	r3.c = (r2.c+r4.c)/2 + (0,30);
	drawObj(r1,r2,r3,r4);
	ncdiag(r3.p2)(r4.p2)
		"angleA(0)",
		"angleB(-90)",
		"arrows(-)",
		"linecolor(blue)";
endfig;

beginfig(2);
	draw (0,0)--(1,0);
	draw (0,0)--(0,1);

	snewR.r1 "angle(90)";
	ObjLabel.r1(btex $1$ etex);

	snewR.r2 "angle(90)";
	ObjLabel.r2(btex $2$ etex);

	snewR.r4 "angle(90)";
	ObjLabel.r4(btex $4$ etex);

	snewR.r3 "angle( 0)";
	ObjLabel.r3(btex $3$ etex) "labrotate(30)";

	r1.c = origin;
	r2.c = r1.c+(30,0);
	r4.c = r2.c+(60,0);
	r3.c = (r2.c+r4.c)/2 + (0,30);
	drawObj(r1,r2,r3,r4);
	ncdiag(r3.p2)(r4.p2)
		"angleA(0)",
		"angleB(-90)",
		"arrows(-)",
		"linecolor(blue)";
endfig;

end;
