save _n_;
def _n_(expr i)=
	%X(n)[i]
	X(sc_("n" & decimal(i)))
enddef;
for i:=0 upto 12:
	newNode._n_(i);
endfor;

for i:= 1 upto 6:
	_n_(i).c   = UD(4,0) rotated ((i-1)*60);
	_n_(i+6).c = _n_(2).c shifted (_n_(1).c - origin) rotated ((i-1)*60);
endfor;
_n_(0).c = _n_(8).c + (_n_(9).c - _n_(2).c);

for i:=1 upto 12:
	drawObj(_n_(i));
endfor;

for i:=1 upto 6:
	save _next;numeric _next; _next := i mod 6 + 1;
	ncline(_n_(i))(_n_(_next));
	ncline(_n_(i))(_n_(i+6));
	ncline(_n_(i+6))(_n_(_next));
endfor;
Xpclist(
	"n8,180,n0,180",
	"n11,180,n0,90"
);
