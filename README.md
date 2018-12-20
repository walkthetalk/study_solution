we use asy to draw figures without text
we use metapost to draw figures with text in document
1. use asy+context to draw text is too pain
2. the clip fuction provided by metapost is too simple
3. metaobj can't work because of two runs schem. the workaround is pain.
   please reference https://wiki.contextgarden.net/MetaObj_and_Labels.
   I use smetaobj which is based on original metaobj.
4. we can't use \processcommalist or \dorecurse between combination,
   the workaround is extend it using lua code.
   but you should take care of the 'comma'.
