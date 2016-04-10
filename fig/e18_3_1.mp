input btree;
input format;

bboxmargin := 0;

beginfig(1);
btree_build(testtree)(20, 3, "ABPYZQRXTUVSCDEGKLFMNOJ");
btree_delete_seq(testtree)("FMGDB");
draw img_btree(testtree)(btree_draw_style_shrink, 0.4cm, 1.5cm, red, red);
endfig;

beginfig(2);
btree_delete(testtree)(ASCII("C"));
draw img_btree(testtree)(btree_draw_style_shrink, 0.4cm, 1.5cm, black, black);
endfig;

beginfig(3);
btree_delete(testtree)(ASCII("P"));
draw img_btree(testtree)(btree_draw_style_shrink, 0.4cm, 1.5cm, black, black);
endfig;

beginfig(4);
btree_delete(testtree)(ASCII("V"));
draw img_btree(testtree)(btree_draw_style_shrink, 0.4cm, 1.5cm, black, black);
endfig;

end;
