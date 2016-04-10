input btree;
input format;

bboxmargin := 0;

beginfig(1);
btree_build(btree)(20,2,"FSQKCLHTVWMRNPABXYDZE");
draw img_btree(btree)(btree_draw_style_shrink, 0.4cm, 1.5cm, black, black);
endfig;

end;
