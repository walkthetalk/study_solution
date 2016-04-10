
vardef graph_node(suffix nodes)(expr frame, idx) :=
image(
draw frame shifted nodes[ASCII(idx)];
label(idx, nodes[ASCII(idx)]);
)
enddef;

vardef graph_line(suffix nodes)(expr frame, snode, enode) :=
graph_line_idx(nodes)(frame, ASCII(snode), ASCII(enode))
enddef;

vardef graph_line_idx(suffix nodes)(expr frame, sidx, eidx) :=
save startpoint, stoppoint;
pair startpoint, stoppoint;
startpoint := nodes[sidx];
stoppoint := nodes[eidx];
save ret;
path ret;
ret := (startpoint--stoppoint) cutbefore (frame shifted startpoint) cutafter (frame shifted stoppoint);

ret
enddef;

vardef graph_curve(suffix nodes)(expr frame, snode, enode, dist) :=
save startpoint, stoppoint, midpoint;
pair startpoint, stoppoint, midpoint;
startpoint := nodes[ASCII(snode)];
stoppoint := nodes[ASCII(enode)];

message "snode: " & snode & " " & decimal(xpart(startpoint)) & " " & decimal(ypart(startpoint));
message "enode: " & enode & " " & decimal(xpart(stoppoint)) & " " & decimal(ypart(stoppoint));
midpoint := (startpoint + stoppoint)/2;
if xpart(startpoint) = xpart(stoppoint):
	message "x is " & decimal(xpart(startpoint));
	message "x is " & decimal(xpart(stoppoint));
	midpoint := (xpart(midpoint) + dist, ypart(midpoint));
elseif ypart(startpoint) = ypart(stoppoint):
	message "y is " & decimal(ypart(startpoint));
	midpoint := (xpart(midpoint), ypart(midpoint) + dist);
else:
	save k, deltax, deltay;
	numeric k, deltax, deltay;
	k := (ypart(stoppoint) - ypart(startpoint)) / (xpart(stoppoint) - xpart(startpoint));
	deltay := dist / sqrt(1 + k * k);
	deltax := -k * deltay;
	message "deltax deltay is " & decimal(deltax) & " " & decimal(deltay);
	message "midpoint is " & decimal(xpart(midpoint)) & " " & decimal(ypart(midpoint));
	midpoint := midpoint + (deltax, deltay);
	message "midpoint is " & decimal(xpart(midpoint)) & " " & decimal(ypart(midpoint));
fi;
save ret;
path ret;
ret := (startpoint..midpoint..stoppoint) cutbefore (frame shifted startpoint) cutafter (frame shifted stoppoint);

ret
enddef;
