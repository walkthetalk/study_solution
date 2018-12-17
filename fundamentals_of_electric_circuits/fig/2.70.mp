save _n_;
def _n_(expr i)=
	%X(n)[i]
	X(sc_("n" & decimal(i)))
enddef;
for i:=1 upto 12:
	newNode._n_(i);
endfor;

numeric uc;
uc := 20;
for i:= 1 upto 6:
	_n_(i).c   = (uc,0) rotated ((i-1)*60);
	_n_(i+6).c = _n_(2).c shifted (uc,0) rotated ((i-1)*60);
endfor;

for i:=1 upto 12:
	drawObj(_n_(i));
endfor;

for i:=1 upto 6:
	save _next;numeric _next; _next := i mod 6 + 1;
	ncline(_n_(i))(_n_(_next));
	ncline(_n_(i))(_n_(i+6));
	ncline(_n_(i+6))(_n_(_next));
endfor;
ncbar(_n_(8))(_n_(11)) "angleA(180)", "armA(2uc)"; 
