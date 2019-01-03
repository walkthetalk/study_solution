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
5. when placefigure, always/here/auto may result in corrupt view,
   or some figure missed if expected located on the bottom of page
   without enough space. so only use force in this project.
6. externalfigure, the path is set by setupexternalfigures,
   context arguments --path not work.
