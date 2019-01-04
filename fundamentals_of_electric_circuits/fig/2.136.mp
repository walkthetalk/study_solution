XnewRa.r11;
XObjMLP.r11("R")(in)(top);
XnewRa.r12;
XObjMLP.r12("R")(in)(top);
XnewRa.r13;
XObjMLP.r13("R")(in)(top);
XnewRa.r14 "angle(90)";
XObjMLP.r14("R")(is)(rt);

XnewRa.r15;
XObjMLP.r15("R")(in)(top);
XnewRa.r16;
XObjMLP.r16("R")(in)(top);
XnewRa.r17;
XObjMLP.r17("R")(in)(top);
XnewRa.r18;
XObjMLP.r18("R")(in)(top);
XnewRa.r19 "angle(90)";
XObjMLP.r19("R")(is)(rt);

XnewRa.r110;
XObjMLP.r110("R")(in)(top);
XnewRa.r111;
XObjMLP.r111("R")(in)(top);
XnewRa.r112;
XObjMLP.r112("R")(in)(top);
XnewRa.r113;
XObjMLP.r113("R")(in)(top);
XnewRa.r114 "angle(90)";
XObjMLP.r114("R")(is)(rt);

XnewNode.n11;
XnewNode.n12;
XnewNode.n13;
XnewNode.n14;
XnewNode.n15;
XnewNode.n16;

X(r11).c = origin;
X(n11).c = X(r11).c + UD(6,0);
X(r14).c = X(n11).c + UD(6,0);
X(r12).c = (X(n11).c + X(r14).c)/2 + UD(0,6);
X(r13).c = (X(n11).c + X(r14).c)/2 + UD(0,-6);
X(n12).c = X(r12).c + UD(6,0);
X(n13).c = X(r13).c + UD(6,0);

X(r19).c = X(n12).c + UD(6,0);
X(r15).c = X(r19).c + UD(-3,3);
X(r16).c = X(r19).c + UD(3,3);
X(r17).c = X(r19).c + UD(-3,-3);
X(r18).c = X(r19).c + UD(3,-3);
X(n14).c = X(r19).c + UD(6,0);

X(r114).c = X(n13).c + UD(6,0);
X(r110).c = X(r114).c + UD(-3,3);
X(r111).c = X(r114).c + UD(3,3);
X(r112).c = X(r114).c + UD(-3,-3);
X(r113).c = X(r114).c + UD(3,-3);
X(n15).c = X(r114).c + UD(6,0);

X(n16).c = (X(n14).c + X(n15).c)/2 + UD(3,0);

Xpclist(
	"r11,2,n11,0",
	"n11,90,r12,1",
	"n11,-90,r13,1",
	"r12,2,n12,0",
	"r13,2,n13,0",
	"r14,2,n12,0",
	"r14,1,n13,0",
	"n12,90,r15,1",
	"n12,-90,r17,1",
	"r15,2,r16,1",
	"r17,2,r18,1",
	"r19,1,r18,1",
	"r19,2,r16,1",
	"r16,2,n14,-90",
	"r18,2,n14,90",
	"n13,90,r110,1",
	"n13,-90,r112,1",
	"r110,2,r111,1",
	"r110,2,r114,2",
	"r112,2,r113,1",
	"r112,2,r114,1",
	"r111,2,n15,-90",
	"r113,2,n15,90",
	"n14,0,n16,-90",
	"n15,0,n16,90"
);

XdrawObj(r11,r12,r13,r14,r15,r16,r17,r18,r19,r110,r111,r112,r113,r114);

% part 2
XnewRa.r21;
XObjMLP.r21("R")(in)(top);
XnewRa.r22;
XObjMLP.r22("R")(in)(top);
XnewRa.r23;
XObjMLP.r23("R")(in)(top);
XnewRa.r24 "angle(90)";
XObjMLP.r24("R")(is)(rt);

XnewRa.r25;
XObjMLP.r25("R")(in)(top);
XnewRa.r26;
XObjMLP.r26("R")(in)(top);
XnewRa.r27;
XObjMLP.r27("R")(in)(top);
XnewRa.r28;
XObjMLP.r28("R")(in)(top);
XnewRa.r29 "angle(90)";
XObjMLP.r29("R")(is)(rt);

XnewRa.r210;
XObjMLP.r210("R")(in)(top);
XnewRa.r211;
XObjMLP.r211("R")(in)(top);
XnewRa.r212;
XObjMLP.r212("R")(in)(top);
XnewRa.r213;
XObjMLP.r213("R")(in)(top);
XnewRa.r214 "angle(90)";
XObjMLP.r214("R")(is)(rt);

XnewNode.n21;
XnewNode.n22;
XnewNode.n23;
XnewNode.n24;
XnewNode.n25;

X(r21).c = X(r11).c + UD(0,-24);
X(n21).c = X(r21).c + UD(6,0);
X(r24).c = X(n21).c + UD(6,0);
X(r22).c = (X(n21).c + X(r24).c)/2 + UD(0,6);
X(r23).c = (X(n21).c + X(r24).c)/2 + UD(0,-6);
X(n22).c = X(r22).c + UD(6,0);
X(n23).c = X(r23).c + UD(6,0);

X(r29).c = X(n22).c + UD(6,0);
X(r25).c = X(r29).c + UD(-3,3);
X(r26).c = X(r29).c + UD(3,3);
X(r27).c = X(r29).c + UD(-3,-3);
X(r28).c = X(r29).c + UD(3,-3);
X(n24).c = X(r29).c + UD(6,0);

X(r214).c = X(n23).c + UD(6,0);
X(r210).c = X(r214).c + UD(-3,3);
X(r211).c = X(r214).c + UD(3,3);
X(r212).c = X(r214).c + UD(-3,-3);
X(r213).c = X(r214).c + UD(3,-3);
X(n25).c = X(r214).c + UD(6,0);

Xpclist(
	"r21,2,n21,0",
	"n21,90,r22,1",
	"n21,-90,r23,1",
	"r22,2,n22,0",
	"r23,2,n23,0",
	"r24,2,n22,0",
	"r24,1,n23,0",
	"n22,90,r25,1",
	"n22,-90,r27,1",
	"r25,2,r26,1",
	"r27,2,r28,1",
	"r29,1,r28,1",
	"r29,2,r26,1",
	"r26,2,n24,-90",
	"r28,2,n24,90",
	"n23,90,r210,1",
	"n23,-90,r212,1",
	"r210,2,r211,1",
	"r210,2,r214,2",
	"r212,2,r213,1",
	"r212,2,r214,1",
	"r211,2,n25,-90",
	"r213,2,n25,90",
	"n24,0,n16,90",
	"n25,0,n16,90"
);

XdrawObj(r21,r22,r23,r24,r25,r26,r27,r28,r29,r210,r211,r212,r213,r214);

% integrate
XnewRa.r31;
XObjMLP.r31("R")(in)(top);
XnewRa.r32 "angle(90)";
XObjMLP.r32("R")(is)(rt);
XnewNode.n31;
XnewNode.na "pathfillcolor(White)";
XObjMLP.na("a")(iw)(lft);
XnewNode.nb "pathfillcolor(White)";
XObjMLP.nb("b")(iw)(lft);

X(n31).c = (X(r11).c + X(r21).c)/2 + UD(-3,0);
X(r32).c = (X(r11).c + X(r21).c)/2 + UD(3,0);
X(r31).c = X(n31).c + UD(-3,0);
X(na).c = X(r31).c + UD(-3,0);
X(nb).c = (xpart X(na).c, ypart X(r213).c) + UD(0,-3);

Xpclist(
	"r11,2,r32,2",
	"r21,2,r32,1",
	"n31,90,r11,1",
	"n31,-90,r21,1",
	"r31,2,n31,0",
	"na,0,r31,1",
	"nb,0,n16,90"
);

XdrawObj(r31,r32,na,nb);
