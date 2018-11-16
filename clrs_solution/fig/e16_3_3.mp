input TEX;
input format;

bboxmargin := 0;

% 將長度爲 n 的 Q 擴展成長度爲 2n-1
% L 存儲左孩子索引， R 存儲右孩子索引
vardef huffman(suffix Q, L, R, n) :=
	numeric zleft, zright, zfreq;
	% 後面可以直接賦值，0 代表空指針
	for i := 1 upto n:
		L[i] := 0;
		R[i] := 0;
	endfor;

	numeric minidx;
	for i := 1 upto (n-1):
		minidx := 2 * i - 1;
		zleft := minidx;
		zright := minidx+1;
		zfreq := Q[zleft] + Q[zright];
		numeric j;
		j := n+i-1;
		forever:
			exitif j <= zright;
			exitif Q[j] <= zfreq;
			Q[j+1] := Q[j];
			L[j+1] := L[j];	% 0 代表空指針，可以直接賦值
			R[j+1] := R[j];
			j := j - 1;
		endfor;
		Q[j+1] := zfreq;
		L[j+1] := zleft;
		R[j+1] := zright;
	endfor;
enddef;

% BL 爲各層最左端的 x 座標
% BR 爲各層最右端的 x 座標
vardef img_bintree(suffix Q, L, R, BL, BR)(expr idx, xunit, yunit, gsize) :=
image(
	save fr;
	path fr;
	fr := fullcircle scaled gsize;

	save bboxl_left, bboxl_right, bboxr_left, bboxr_right;
	numeric bboxl_left[];
	numeric bboxl_right[];
	numeric bboxr_left[];
	numeric bboxr_right[];

	save picL, picR;
	picture picL;
	picture picR;
	if L[idx] > 0:
		picL := img_bintree(Q, L, R, bboxl_left, bboxl_right)(L[idx], xunit, yunit, gsize);
	fi;
	if R[idx] > 0:
		picR := img_bintree(Q, L, R, bboxr_left, bboxr_right)(R[idx], xunit, yunit, gsize);
	fi;

	numeric i;
	i := 1;
	numeric dist;
	dist := 0;
	forever:
		exitif (unknown bboxl_right[i]) or (unknown bboxr_left[i]);
		numeric tmp;
		tmp := bboxl_right[i] - bboxr_left[i];
		if tmp > dist:
			dist := tmp;
		fi;
	endfor;

	dist := dist + xunit;	% 保證即使某個分支爲空，也不會出現直上直下的情況

	pair leftshift;
	pair rightshift;
	leftshift := (-dist/2, -yunit);
	rightshift := (dist/2, -yunit);

	if known picL:
		draw picL shifted leftshift;
	fi;
	if known picR:
		draw picR shifted rightshift;
	fi;

	pair ownshift;
	ownshift := (0,0);

	draw fr withcolor black;
	label(decimal(Q[idx]), ownshift) withcolor black;
	if known picL:
		draw ((fr shifted ownshift) intersectionpoint (ownshift--leftshift))
			-- ((fr shifted leftshift) intersectionpoint (ownshift--leftshift));
	fi;
	if known picR:
		draw ((fr shifted ownshift) intersectionpoint (ownshift--rightshift))
			-- ((fr shifted rightshift) intersectionpoint (ownshift--rightshift));
	fi;

	% prepare for caller
	i := 1;
	forever:
		exitif unknown bboxl_left[i];
		BL[i] := bboxl_left[i] + xpart(leftshift);
	endfor;
	i := 1;
	forever:
		exitif unknown bboxr_right[i];
		BR[i] := bboxr_right[i] + xpart(rightshift);
	endfor;
)
enddef;

% global content
numeric len;
numeric Q[];
numeric L[];
numeric R[];

len := 7;
Q[1] := 1;
Q[2] := 1;
Q[3] := 2;
Q[4] := 3;
Q[5] := 5;
Q[6] := 8;
Q[7] := 13;

huffman(Q, L, R, len);

beginfig(1);
	numeric BL[];
	numeric BR[];
	draw img_bintree(Q, L, R, BL, BR)((2 * len - 1), .6cm, .6cm, .4cm);
endfig;

end;
