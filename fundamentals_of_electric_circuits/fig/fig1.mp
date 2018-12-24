
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
XnewLightBulb.nb1;
X(nb1).c = origin;
XdrawObj(nb1);
message "######### " & decimal(xpart X(nb1).bpl[1]);
endfig;

end;
