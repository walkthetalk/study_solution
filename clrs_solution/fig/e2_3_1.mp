input merge_sort

beginfig(1);
numeric gridsize;
numeric ALength;	% don't use 'length' which is keyword used by arrow
numeric data[];
data[1] := 3;
data[2] := 41;
data[3] := 52;
data[4] := 26;
data[5] := 38;
data[6] := 57;
data[7] := 9;
data[8] := 49;
ALength := 8;
gridsize := .5cm;

draw merge_sort(data, ALength)(gridsize, 1, ALength, true, true);
endfig;

end;
