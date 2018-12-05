% metaobj.mp 0.93
% D. Roegel (roegel@loria.fr)
% January 15 - June 14, 2001
% November 13, 2001
% December 5, 2001
% December 23, 2002
% March 23, 2004
% April 9, 2004
% May 27, 2004
% June 1, 2004
% October 5, 2005
% October 23, 2005
% May 1st, 2006
% June 18, 2006
%
% MetaPost bug:
% ------------
%   With this file, I discovered a bug in the linux/web2c 7.3.1
%   implementation of metapost. There is a memory leak with
%   respect to strings. Apparently, if you increase |pool_size|
%   and recreate the |.mem|, you can avoid it, but I am not
%   sure the problem is really gone.
%   I mentionned this problem on the metafont mailing list on January 26, 2001.
%
% History:
%
%         January 15, 2001: start of the package
%         January     2001: development of most of
%                           the low-level object functions
%                           including cloning,
%                           as well as many classes of objects,
%                           including trees and the option mechanism
%         January 26, 2001: metapost bug discovered
%         February    2001: code improved
%         March-May   2001: paths and labels,
%                           addition of many of PSTricks' features
%         May 29,     2001: first private release (0.5)
%                           with a 120 pages documentation
%                           and 225 KB of core code.
%         May 31,     2001: new option pathfilled for paths
% 0.51  
%         June 5,     2001: coil and zigzag connections, option shortcuts
%                             (arm for armA and armB, etc.), arrows shortcuts
%                             (-, ->, etc.)
%         June 6,     2001: flip and treeflip options, linetension split
%                           into linetensionA and linetensionB
%         June 7,     2001: define_global_pair_option
%                           framestyle option
%                           ObjColor, ObjString, ObjBoolean and ObjTransform
%                           Second private release (0.51)
% 0.52    June  8,    2001: shadowcolor option
%         June 12,    2001: general shadows for all objects,
%                           and simplification of the shadow mechanism for Box
% 0.60    June 13,    2001: boxheight and boxdepth parameters for ncbox
%                            and ncarcbox; addUserPath,addStandardPath,ObjPath;
% 0.80    June 14,    2001: addition of |unfill| in objects
%         June 14,    2001: first released version on CTAN
% 0.81    Nov. 13,    2001: bug correction: contrary to what is written above,
%                           ObjColor, ObjString, ObjBoolean and ObjTransform
%                           were not correctly implemented. The field
%                           containing their list (for instance booleanlist_)
%                           was not declared. (Bug reported by
%                           Marc van Dongen, dongen@cs.ucc.ie,
%                           November 5, 2001.)
% 0.82    Dec.  5,    2001: for compatibility with ConTeXt, the |.exp|
%                           extensions were renamed into |.expl|
%                           (Bug reported by Eckhart Guthöhrlein,
%                            eckhart_guthoehrlein@public.uni-hamburg.de,
%                            July 3, 2001)
% 0.83    Dec. 23,    2002: in addPath, an incorrect use of infinity was
%                           replaced by length (infinity can't be used to
%                           get the end of a cyclic path, see metapost manual)
%                           (bug noticed by Jan Holfert (jan.holfert@gmx.net),
%                            comp.text.tex, 2002-05-13 15:00:07 PST,
%                            but never reported to me since);
%                           all other such misuses (in five other macros)
%                           have been corrected.
% 0.84    March 23,   2004: bug correction in newCircle (usually, only half
%                           of the cardinal points were correctly positionned)
%                           (bug noticed by Stephan Hennig,
%                            comp.text.tex, 2004-03-18 14:55:54 PST)
%                           The bug is also visible on page 43 of the manual,
%                           when the use of posA(n) is shown.
%                           It will be corrected in future versions of
%                           the manual.
% 0.85    April  9,   2004: arctime renamed into arctime_
%                           to avoid conflict with the cmarrows package
%                           (bug noticed by Stephan Hennig,
%                            comp.text.tex)
% 0.86    May   27,   2004: treemode made a global option of trees
%                           (bug noticed by Stephan Hennig)
%                           (Actually, a number of local options should be
%                            made global, and will probably be made so soon.)
% 0.87    June   1,   2004: - in drawTree, the root is unfilled only when
%                             there are fan children; before, it was always done
%                             (bug noticed by Stephan Hennig, May 29, 2004)
%                           - in all tc... macros, ntreepos was replaced
%                             by treeroot (bug noticed by Stephan Hennig, May 29, 2004)
%                           - labshift option now works when labels are attached
%                             to paths
% 0.88    October 5, 2005: - in newMatrix, the largest and tallest elements
%                            were not correctly computed when the options
%                            matrixnodehsize or matrixnodevsize were positive;
%                            surprisingly, these options had never been tested.
%                            (bug noticed by Stephan Hennig, September 2005)
% 0.89    October 23, 2005: - in newMatrix, the bounding box was not correctly
%                             computed when the options
%                             matrixnodehsize or matrixnodevsize were positive;
%                             (bug noticed by Stephan Hennig, October 2005)
%                           - also in newMatrix, the vertical distance between
%                             two rows was not correctly computed when the option
%                             matrixnodevsize was positive (the horizontal
%                             distance problem was corrected for version 0.88,
%                             but this one was forgotten)
%                             (bug noticed by Stephan Hennig, October 2005)
% 0.90    May 1st, 2006:    - in ObjLabel, user labels were only
%                             correctly positionned when the c point of the
%                             object was at the origin, because I had forgotten
%                             to translate the label. Incidentally, the bug
%                             occurred right next to the labshift bug corrected
%                             for version 0.87.
%                             (bug noticed by Stephan Hennig, May 2004,
%                              who reminded me on April 30, 2006)
% 0.91    June 18, 2006:    - connections such as ncdiag didn't use
%                             global defaults for angleA and angleB
%                             (bug noticed by Stephan Hennig, 18 June 2006)
%                             This was corrected in macro nc__.
% 0.92    Sep 27, 2006:     - define_local_picture_option added
%                               for labels on connections
%                              (this change, and those up to Oct. 5,
%                               were prompted by Steffen Reith
%                               Steffen Reith <streit@streit.cc>)
% 0.921   Oct  2, 2006:     - labpos, labpic, labdist, labangle
%                             and labdir can now be used with immediate
%                             connections
%         Oct  3, 2006:     - the objpathlabel_ macro had a bug related
%                             to the change of version 0.90, in that
%                             labels were not correctly positioned if
%                             the object was not centered at the origin;
%                             the problem had only partly been corrected
%                             in version 0.90;
%         Oct  5, 2006:     - finished the label code for connections
%                             added to objects (nc_core_)
%                           - the labdist option is now recognized also
%                             for ObjLabel
% 0.923   Nov 10, 2006:     - additional testing in nc__ for the case
%                             where the two object centers are the same;
%                           - new `curvemax' option for nccurve
%                             (prompted by Steffen Reith
%                               Steffen Reith <streit@streit.cc>)
%                           - `nccurve_' was extended to improve
%                             its behavior when the curve is looping
% 0.93    Dec 3,  2006:     - improvement of Container class
%                             to be mentioned in LGC2
%                             (this class was suggested by Michael Schwarz)
%
% The code has a lot of formatting for the mft program, but mft (even
% with Ulrick Vieth's changes) can't be used, because metaobj's code
% has too many idiosyncrasies. And besides, mft overflows anyway...

% Don't load this package twice:
if known metaobj_version: expandafter endinput; fi;

numeric metaobj_version;string metaobj_date;
metaobj_version=0.93;
metaobj_date="2006/12/03";
% The banner:
message "******* metaobj " & decimal (metaobj_version) &
        " (c) D. Roegel (" & metaobj_date & ") *******";message "";

tracingstats:=1;

% This helps simplifying the code.
def quote(expr s)=
  ditto & s & ditto
enddef;

% Compatibility with |boxes.mp|:
def boxit=newBox enddef;
def circleit=newEllipse enddef;

% Compatibility with |rboxes.mp| (which includes |boxes.mp|):
def rboxit=newRBox enddef;

% We also define |drawboxes|, |drawboxed|, |drawunboxed|, more or less
% similar to the ones in |boxes.mp|.
% The corresponding functions in |boxes.mp| also do |fixsize(t); fixpos(t);|

def drawboxed(text t) =         % Draw each box
  forsuffixes s=t:
    if unknown s.c: s.c=origin;fi;
    drawObj(s);
    draw BpathObj(s);
  endfor
enddef;

def drawunboxed(text t) =       % Draw contents of each box
  forsuffixes s=t:
    if unknown s.c: s.c=origin;fi;
    drawObj(s);
  endfor
enddef;

def drawboxes(text t) =         % Draw boundary path for each box
  forsuffixes s=t:
    if unknown s.c: s.c=origin;fi;    
    draw BpathObj(s);
  endfor
enddef;

%---------------------------------------------------------------------
% First, let's borrow two definitions from |boxes.mp|. We just give
% them different names to avoid conflicts.

% (from |str_prefix| in |boxes.mp|)
% Find the length of the prefix of string |s| for which |cond| is true for each
% character c of the prefix
vardef str_prefix_(expr s)(text cond) =
  save i_, c; string c;
  i_ = 0;
  forever:
    c := substring (i_,i_+1) of s;
    exitunless cond;
    exitif incr i_=length s;
  endfor
  i_
enddef;

% (from |generisize| in |boxes.mp|)
% Take a string returned by the |str| operator and return the same string
% with explicit numeric subscripts replaced by generic subscript symbols [].
vardef generisize_(expr ss) =
  save res, s, l; string res, s;
  res = "";             % result so far
  s = ss;               % left to process
  forever: exitif s="";
    l := str_prefix_(s, (c<>"[") and ((c<"0") or (c>"9")));
    res := res & substring (0,l) of s;
    s := substring (l,infinity) of s;
    if s<>"":
      res := res & "[]";
      l := if s>="[":  1 + str_prefix_(s, c<>"]")
           else:  str_prefix_(s, (c=".") or ("0"<=c) and (c<="9"))
           fi;
      s := substring(l,infinity) of s;
    fi
  endfor
  res
enddef;

% We also use |pathsel__| when constructing an ellipse.
% (from |pathsel_| in |boxes.mp|)
vardef pathsel__(expr a_,b_)(expr dhi)(expr circmargin)(text tt) =
  save f_, p_; path p_;
  p_ = origin..(a_,b_)+circmargin*unitvector(a_,b_);
  vardef f_(expr d_) =
    xpart((tt) intersectiontimes p_) >= 0
  enddef;
  solve f_(0,dhi+1.5circmargin)
enddef;

%---------------------------------------------------------------------

boolean show_object_names,show_corners,show_empty_boxes;
show_object_names=false;show_corners=false;
show_empty_boxes=false;

let obj=scantokens; % This is for clarity and should only be used
                    % when the argument of |scantokens| is a suffix
                    % representing an object. Otherwise, use |sc_|.
def Obj(expr n)=obj(iname_[n]) enddef;

% A few definitions to simplify the code
let sc_=scantokens;
% |currentObjname| is a string representing the current object
def sco_(expr s)=sc_(currentObjname&s) enddef;

def setcurrentobjname_(expr n)=
  save currentObjname;  
  string currentObjname;
  currentObjname=n;
enddef;

% An array of class names.
string Classes_[];
numeric nClasses_; % Number of different instanciated classes.
nClasses_=0;

numeric ClassName_[]; % The class name of an object.
                      % This is an index into the |Classes_| array.

% This array records the name of an object (not its class)
string iname_[];
% This function accesses the internal name.
def internalname_(expr n)=iname_[n] enddef;

def objClassName_(expr n)= Classes_[ClassName_[n]] enddef;

% Objects can have shortcut names; these are names defined
% by the user and which will lead to the object numbers.
% We use two arrays. The first has the shortcuts,
% the second has the object numbers.

string oname_[];
numeric ovalue_[];
numeric nshortcuts_;
nshortcuts_=0;

vardef addShortCut_(expr oname,ovalue)=
  save found;boolean found;found=false;
  for i:=1 upto nshortcuts_:
    if oname_[i]=oname:
      ovalue_[i]:=ovalue;
      found:=true;
    fi;
    exitif found;
  endfor;
  if not found:
    nshortcuts_:=nshortcuts_+1;
    oname_[nshortcuts_]=oname;
    ovalue_[nshortcuts_]:=ovalue;
  fi;
enddef;

% This function returns the number of an object, given its shortcut.
vardef objValue_(expr oname)=
  save val;numeric val;
  hide(
  for i:=1 upto nshortcuts_:
    if oname_[i]=oname:
      val:=ovalue_[i];
    fi;
    exitif known val;
  endfor;
  )
  val
enddef;

def nameToSuffixString_(expr s)=
  iname_[objValue_(s)]
enddef;

def nameToSuffix_(expr s)=
  obj(nameToSuffixString_(s))
enddef;

let O_=nameToSuffix_;

vardef addclass_(expr n,clname)=
  save i,j;
  if nClasses_>0:
    % first, see if |clname| is a known class name
    for i:=0 upto nClasses_-1:j:=i;
      exitif clname=Classes_[i];
    endfor;
    if clname=Classes_[j]:
      ClassName_[n]=j;
    else: % it is a new class name
      %createClassTest(clname); % we call it elsewhere
      ClassName_[n]=nClasses_;
      Classes_[nClasses_]=clname;
      nClasses_:=nClasses_+1;
    fi;
  else: % it is the first class name
    %createClassTest(clname); % we call it elsewhere
    ClassName_[n]=nClasses_;
    Classes_[nClasses_]=clname;
    nClasses_:=nClasses_+1;
  fi;
enddef;

def createClassTest(expr clname)=
  sc_ ("def is" & clname &
      "(suffix n)= (objClassName_(n)=" &
        ditto & clname & ditto & ") enddef;")
enddef;


% This is sometimes useful
vardef whateverstring = save ?; string ?; ? enddef;
def whateverpair = (whatever,whatever) enddef;


% We need an array to store option function names whose parameter
% is a string. For instance, when the option is "drawfunction(mydraw)",
% the string |"drawfunction"| is in the array and makes it possible
% to extract |"mydraw"| without calling the function |drawfunction|.
% This is not true of all option functions. Those having numeric
% parameters do not need a special treatment.

string opfunc_[];
numeric nopfunc_;nopfunc_=0;

% This function adds a string to the array.
% |addOptionFunction| should be called where the option functions
% are defined.
def addOptionFunction(expr s)=
  nopfunc_:=nopfunc_+1;
  opfunc_[nopfunc_]=s;
enddef;

% This function checks if a string is in the array:
vardef isOpFunc_(expr s)=
  save b;boolean b;
  hide(
    b=false;
    for i:=1 upto nopfunc_:
      if opfunc_[i]=s:b:=true;fi;
      exitif b;
    endfor;
    )
  b
enddef;

% This function takes a string such as |"drawfunction(mydraw)"|
% and replaces it with |"drawfunction("mydraw")"|
% if the function name (the first part, here |"drawfunction"|)
% is in the |opfunc_| array.
% The argument of the function can have parentheses, but they must
% be balanced. For instance, we can have |"color((0,1,1))"|.
% The argument can also contain spaces.

vardef correctOption_(expr s)=
  save a,b,c,l;string c;l=0; % parenthesis depth
  for i:=0 upto length(s)-1:
    c:=substring(i,i+1) of s;
    if (c="(") and (l=0): a:=i;
    elseif (c=")") and (l=1): b:=i;  
    fi;
    if c="(": l:=l+1;fi;
    if c=")": l:=l-1;fi;
  endfor;
  if isOpFunc_(substring(0,a) of s):
    (substring(0,a+1) of s &
     ditto & substring(a+1,b) of s & ditto
      & substring(b,infinity) of s)
  else: s
  fi
enddef;

% Apply a linear transformation to object |n|.
% The last parameter is of type |transform|.
% Fixed objects can be transformed, but they are untied.
vardef transformObj(suffix n)(expr $)=
  save p_,q_,i; pair p_[],q_[];
  memorizePoints_(n,$);
  % update the current transformation:
  n.ctransform_:=n.ctransform_ transformed $;
  % update the transformations for the non-standard labels
  % (such labels can be added to an object, even after several
  % transformations have been applied to it)
  if known n.ipic_.transf_.n_:
    for i:=1 upto n.ipic_.transf_.n_:
      n.ipic_.transf_[i]:=n.ipic_.transf_[i] transformed $;
    endfor;
  fi;
  % |message "transforming a box of type " & objClassName_(n);|
  begingroup
    save tie_function_; % used in the |subobjties_| strings
    for i:=1 upto n.nsubobjties_:
      % we define the function |tie_function_|:
      sc_ n.subobjties_[i];
      % and we call it:
      sc_ "tie_function_".n($);
    endfor;
  endgroup;
enddef;

% streamlined version: |n| is a number representing an object
vardef transform_Obj(expr n)(expr $)=
  hide(transformObj(obj(iname_[n]))($)) n
enddef;

% rotate object |n| by angle |$| around the origin
def rotateObj(suffix n)(expr $)=
  transformObj(n)(identity rotated $);
enddef;

% streamlined version: |n| is a number representing an object
vardef rotate_Obj(expr n)(expr $)=
  hide(rotateObj(obj(iname_[n]))($)) n
enddef;

% scale object |n| by |$|
def scaleObj(suffix n)(expr $)=
  transformObj(n)(identity scaled $);
enddef;

% streamlined version: |n| is a number representing an object
vardef scale_Obj(expr n)(expr $)=
  hide(scaleObj(obj(iname_[n]))($)) n
enddef;

% xscale object |n| by |$|
def xscaleObj(suffix n)(expr $)=
  transformObj(n)(identity xscaled $);
enddef;

% streamlined version: |n| is a number representing an object
vardef xscale_Obj(expr n)(expr $)=
  hide(xscaleObj(obj(iname_[n]))($)) n
enddef;

% yscale object |n| by |$|
def yscaleObj(suffix n)(expr $)=
  transformObj(n)(identity yscaled $);
enddef;

% streamlined version: |n| is a number representing an object
vardef yscale_Obj(expr n)(expr $)=
  hide(yscaleObj(obj(iname_[n]))($)) n
enddef;

% reflect object |n| around the line defined by the two points |$| and |$$|
def reflectObj(suffix n)(expr $,$$)=
  transformObj(n)(identity reflectedabout($,$$));
enddef;

% streamlined version: |n| is a number representing an object
vardef reflect_Obj(expr n)(expr $,$$)=
  hide(reflectObj(obj(iname_[n]))($,$$)) n
enddef;

% slant object |n| 
def slantObj(suffix n)(expr $)=
  transformObj(n)(identity slanted $);
enddef;

% streamlined version: |n| is a number representing an object
vardef slant_Obj(expr n)(expr $)=
  hide(slantObj(obj(iname_[n]))($)) n
enddef;

def declarestring_(expr s)(text l)=
  for $:=l:
    sc_("string " & s & "." & $);
  endfor;
enddef;

% |s| is an object; this function returns true if |s| has not been used
% as a prefix before.
def isNewPrefix(suffix s)=
  (not string s.pointlist_)
enddef;

% returns |true| if |v| is of type |t|, where both |t| and |v|
% are strings
def isOfType(expr t,v)=
  (sc_(t & " " & v))
enddef;

% returns a string representing the type of |v|
def TypeOf(expr v)=
  if numeric v:"numeric"
  elseif boolean v:"boolean"
  elseif pair v:"pair"
  elseif string v:"string"
  elseif color v:"color"
  elseif transform v:"transform"
  fi
enddef;

% |n| is the object and |s| its class
def assignObj(suffix n)(expr s)=
  n=incr(nObj_);   % new object number
  iname_[n]=str n; % the number and the associated string are recorded
                   % so that we can go from the number to the name
                   % (and hence to the object)
  addclass_(n,s);   % |n|'s class is memorized too
  % memorize a shortcut, if there is one:
  if known o_name_val:
    addShortCut_(o_name_val,n);
    o_name_val:=whateverstring;
  else:
    % we memorize the standard shortcut, which is |str n|, but only
    % if the object was given a name explicitely:
    if not streamlined_ and memorizeShortcuts:
      addShortCut_(str n,n);
    fi;
  fi;
  % reset |streamlined_|
  streamlined_:=false; 
  save gen_n_;string gen_n_;gen_n_=generisize_(str n);
  if not string n.pointlist_:
    declarestring_(gen_n_)(
              "pointlist_",      % list of points
              "pairlist_",       % list of pairs (non movable points)
              "pointarraylist_", % list of arrays
              "subarraylist_",   % list of arrays of subobjects
              "stringarraylist_",% list of arrays of strings
              "colorarraylist_", % list of arrays of colors 
              "picturearraylist_",% list of arrays of pictures
              "transformarraylist_",% list of arrays of transforms
              "booleanarraylist_",% list of arrays of booleans
              "numericarraylist_",   % list of arrays of numerics
              "pairarraylist_",  % list of arrays of pairs
              "points_in_arrayslist_", % list of all points of all arrays
              "picturelist_",    % list of pictures
              "numericlist_",    % list of numerics (useful for duplication)
	      "booleanlist_",    % list of booleans (ditto)
	      "colorlist_",      % list of colors (ditto)
	      "stringlist_",     % list of strings (ditto)
	      "transformlist_",  % list of transforms (ditto)
              "sublist_",        % list of subobjects
              "subobjties_[]",   % subobj tying equations (1 string/subobject)
              "code_",           % the code of an object
              "extra_code_");    % the extra code of an object
    expandafter numeric sc_(gen_n_).nsubobjties_;
               % number of subobjties
    expandafter transform sc_(gen_n_).ctransform_;
               % current transform of that object
  fi;
  % initialize the lists:
  forsuffixes $=pointlist_,pairlist_,pointarraylist_,subarraylist_,
    stringarraylist_,colorarraylist_,picturearraylist_,transformarraylist_,
    booleanarraylist_,numericarraylist_,pairarraylist_,points_in_arrayslist_,
    picturelist_,numericlist_,booleanlist_,colorlist_,stringlist_,
    transformlist_,sublist_,code_,extra_code_:
    n$:="";
  endfor;
  n.nsubobjties_=0;
  n.ctransform_:=identity;
  setcurrentobjname_(str n);
enddef;

numeric nObj_; % number of instanciated objects ($\geq$|nClasses_|)
               % and also last instanciated object
nObj_=0;

% There is no box with the number 0 and we reserve this number
% for the ``null box'' which is useful in certain places, such as matrices:
newinternal nb;
nb:=0;

% In order to refresh a |numeric| n: |n:=whatever;|
% (suggested by Bogus\l aw Jackowski on Jan 15, 2001 on the metafont list
%  in answer to a question I had asked)

def refresh_(text v)=
  if numeric v: v:=whatever;
  elseif pair v: v:=whateverpair;
    else: message "refresh_ is not defined for this type";
  fi;
enddef;

def refreshObjVars_(suffix n)(text v)=
  forsuffixes $=v:refresh_(n$);endfor;
enddef;

% This function makes it possible to declare pictures in an object.
% There can be several |ObjPicture| declarations in an object.
% (this is similar to |ObjPoint|)
vardef ObjPicture text l=
  forsuffixes $=l:
    if not isOfType("picture",currentObjname & "." & str $):
      sc_ ("picture " & generisize_(currentObjname) & "." & str $);
    fi;
  endfor;
  forsuffixes $=l:
    if sco_(".picturelist_")="":
      sco_(".picturelist_"):=str $;
    else:
      sco_(".picturelist_"):=sco_(".picturelist_") & "," & str $;
    fi;
  endfor;
enddef;

% Give a value to a picture variable and center the picture
% around the origin. All pictures will be centered around the origin
% and everytime we draw one (see |drawPicture|), we transform it.
% Pictures cannot be floating.
def setPicture(text v)(expr val)=
  sco_("." & str v)=val;
  sco_("." & str v):=
    sco_("." & str v) shifted -.5[urcorner(val),llcorner(val)];
enddef;

vardef drawPicture@#(suffix p) text options=
  draw @#p transformed @#ctransform_ shifted @#p.off options
           withcolor OptionValue.@#("picturecolor");
enddef;

% |ObjNumeric|, |ObjPair|, |ObjColor|, |ObjString| and |ObjTransform|
% are all created on the same model, using |defineObjType_|.

vardef defineObjType_(expr type,name)=
  sc_(
    "vardef Obj" & name & " text l=" &
      "forsuffixes $=l:" &
        "if not isOfType(" & quote(type) &
            ",currentObjname & " & quote(".") & "& str $):" &
          "sc_ (" & quote(type&" ") & " & generisize_(currentObjname) & " &
            quote(".") & " & str $);" &
        "fi;" &
      "endfor;" &
      "forsuffixes $=l:" &
        "if sco_(" & quote("." & type &"list_") & ")=" & quote("") & ":" &
          "sco_(" & quote("." & type &"list_") & "):=str $;" &
        "else:" &
          "sco_(" & quote("." & type &"list_") & "):=sco_(" &
            quote("." & type &"list_") & ") & " & quote(",") & " & str $;" &
        "fi;" &
      "endfor;" &
    "enddef;"
  );
  sc_(
    "def set" & name & "(text v)(expr val)=sco_(" &
        quote(".") & " & str v):=val;enddef;"
  );
enddef;

% |defineObjType_("numeric","Numeric");|

% This function makes it possible to declare numerical values
% as part of an object.
% There can be several |ObjNumeric| declarations in an object.
% (this is similar to |ObjPoint|)
% It defines both |ObjNumeric| and |setNumeric|.
defineObjType_("numeric","Numeric");

% This function makes it possible to declare pairs in an object.
% There can be several |ObjPair| declarations in an object
% Contrary to the points of |ObjPoint|, these are points
% that will not move with the object.
% They can be used for special purposes, for instance to store path data.
defineObjType_("pair","Pair");

defineObjType_("color","Color");
defineObjType_("boolean","Boolean");
defineObjType_("string","String");
defineObjType_("transform","Transform");

def BpathObj(suffix n)=
  sc_ ("Bpath" & objClassName_(n))(n)
enddef;

def StandardBpath(suffix n)= (n.inw--n.isw--n.ise--n.ine--cycle) enddef;

def BboxObj(suffix n)=(bbox(BpathObj(n))) enddef;

% Computes the real bounding box, without looking at the Bpath.
% The object must be attached.
% |bboxmargin| is used by |bbox|.
def rBboxObj(suffix n)=
  bbox(image(drawObj(n)))
enddef;

% This is like |decimal| but adds a "+" if the number is positive
def signeddecimal expr d=
  (if d>=0: "+" & decimal d else: decimal d fi)
enddef;

% min/max xpart/ypart of a list of points
def minmaxval(text f)(text xy)(expr pa,pb,pc,pd,pe,pf,pg,ph)=
  f(xy(pa),xy(pb),xy(pc),xy(pd),xy(pe),xy(pf),xy(pg),xy(ph))
enddef;

% Minimum xval of points |pa|, |pb|, ...
def xminval(expr pa,pb,pc,pd,pe,pf,pg,ph)=
  minmaxval(min)(xpart)(pa,pb,pc,pd,pe,pf,pg,ph) enddef;
% Maximum xval of points |pa|, |pb|, ...
def xmaxval(expr pa,pb,pc,pd,pe,pf,pg,ph)=
  minmaxval(max)(xpart)(pa,pb,pc,pd,pe,pf,pg,ph) enddef;
% Minimum yval of points |pa|, |pb|, ...
def yminval(expr pa,pb,pc,pd,pe,pf,pg,ph)=
  minmaxval(min)(ypart)(pa,pb,pc,pd,pe,pf,pg,ph) enddef;
% Maximum yval of points |pa|, |pb|, ...
def ymaxval(expr pa,pb,pc,pd,pe,pf,pg,ph)=
  minmaxval(max)(ypart)(pa,pb,pc,pd,pe,pf,pg,ph) enddef;

% Combines two real bounding boxes: both |bba| and |bbb|
% are paths. Only points 0 through 3 of each path are examined.
% This function is currently not used.
vardef combineTwoBBs(expr bba,bbb)=
  save xm,ym,xM,yM;
  hide(
    xm=xminval(point 0 of bba,point 1 of bba,point 2 of bba,point 3 of bba,
               point 0 of bbb,point 1 of bbb,point 2 of bbb,point 3 of bbb);
    ym=yminval(point 0 of bba,point 1 of bba,point 2 of bba,point 3 of bba,
               point 0 of bbb,point 1 of bbb,point 2 of bbb,point 3 of bbb);
    xM=xmaxval(point 0 of bba,point 1 of bba,point 2 of bba,point 3 of bba,
               point 0 of bbb,point 1 of bbb,point 2 of bbb,point 3 of bbb);
    yM=ymaxval(point 0 of bba,point 1 of bba,point 2 of bba,point 3 of bba,
               point 0 of bbb,point 1 of bbb,point 2 of bbb,point 3 of bbb);
  )
  ((xm,ym)--(xM,ym)--(xM,yM)--(xm,yM)--cycle)
enddef;

% |drawObj| takes a list of suffixes as parameters
def drawObj(text l)=
  forsuffixes $:=l:
    if show_object_names:
      % the name of the object is displayed at the upper right corner
      label(str $,$ne);
    fi;
    if show_corners:
      label("ne",$ne);label("se",$se);label("nw",$nw);label("sw",$sw);
    fi;
    % we must check if there is a specialized version of |drawObj|
    % for the current object, and call it if necessary.
    % We do it in such a way that it doesn't force a default
    % declaration on the object.
    if known sc_(str $).option_drawObj_:
      sc_ (OptionValue$("drawObj"))($);
    else:
      sc_ ("draw" & objClassName_($))($);
    fi;
    drawLabels$;
  endfor;
enddef;

% streamlined version: |n| is a number representing an object;
% contrary to other streamlined functions, this one does not return
% an object identification.
% |n| can also be a string shortcut for an object.
vardef draw_Obj(expr n)=
  if string n:
    drawObj(O_(n));
  else:
    drawObj(obj(iname_[n]));
  fi;
enddef;

% This function can only be used when the bounding path is continuous;
% if it is not the case, the |draw...| function for the object must be adapted.
def drawFramedOrFilledObject_(suffix n)=
  if OptionValue.n("framed"):
    % the shadow is the shadow of the frame, and we only show a shadow
    % if there is a frame
    if OptionValue.n("shadow"):
      fill (BpathObj(n) shifted (1mm,-1mm))
           withcolor OptionValue.n("shadowcolor");
    fi;
    % this removes most of the shadow 
    unfill BpathObj(n);
  fi;
  if OptionValue.n("filled"):
    fill BpathObj(n) withcolor OptionValue.n("fillcolor");
  fi;
  if OptionValue.n("framed"):
    pickup pencircle scaled OptionValue.n("framewidth");
    draw BpathObj(n) withcolor OptionValue.n("framecolor")
                     sc_(OptionValue.n("framestyle"));
    pickup defaultpen;
  fi;
enddef;

% This returns a picture corresponding to the drawing of object |n|
def pictureObj(suffix n)=
  image(drawObj(n))
enddef;

vardef memorizePoints_(suffix n)(expr $$)=
  save i,tmp,varlist_;string tmp,varlist_;
  % The array |p_[]| is not declared here, because it is also used elsewhere
  % (when the |.subobjties_| string is evaluated in |transformObj|)
  % We memorize all the points declared with |ObjPoint| and those
  % that are part of arrays. At this point, we have two strings and
  % we merely concatenate them:
  if n.pointlist_="":varlist_=n.points_in_arrayslist_;
  else:
    if n.points_in_arrayslist_<>"":
      varlist_=n.pointlist_ & "," & n.points_in_arrayslist_;
      else: varlist_=n.pointlist_;
    fi;
  fi;
  i=0;
  if varlist_<>"":
    forsuffixes $=sc_(varlist_):
      i:=i+1;p_[i]=n$;
    endfor;
  fi;
  refreshObjVars_(n)(sc_(varlist_));
  i:=0;
  if varlist_<>"":
    forsuffixes $=sc_(varlist_):i:=i+1;
      if i>1: % equation |$-tmp=(p_[i]-p_1) transformed $$|
        sc_ (str n & "." & str $ & "-" & tmp)=
             (p_[i]-p_1) transformed $$;
      else: tmp=str n & "." & str $;
      fi;  
    endfor;
  fi;
enddef;

% This function makes it possible to declare points in an object.
% There can be several |ObjPoint| declarations in an object
% These are points that will move with the object.
% Pairs that do not move can be declared with |ObjPair|.
vardef ObjPoint text l=
  forsuffixes $=l:
    if not isOfType("pair",currentObjname & "." & str $):
      sc_ ("pair " & generisize_(currentObjname) & "." & str $);
    fi;
  endfor;
  forsuffixes $=l:
    if sco_(".pointlist_")="":
      sco_(".pointlist_"):=str $;
    else:
      sco_(".pointlist_"):=sco_(".pointlist_") & "," & str $;
    fi;
  endfor;
enddef;

% We take as a convention that all objects have a minimal interface
% similar to the one given by |boxes.mp|. This does considerably
% facilitate reusability. In is not mandatory though.
% If you want the standard points, add |StandardPoints| as part of your object
% points (before the |ObjCode| section). You still have to use them in the
% equations, but it is also a good idea to include a few standard
% equations with |StandardEquations| (this is a string).
% Better though, is to write |StandardInterface| at the
% beginning of your object and use only inner points in the equations
% and drawing functions.
%
% The standard interface has the points ne,nw,se,sw,n,s,e,w,c;

def StandardPoints=
  ne,nw,sw,se,n,s,e,w,c
enddef;

% Drawings should not refer to the ``Standard Points,'' because it makes
% the drawings sensitive to bounding box changes.
% Instead, they should refer
% to their Inner variants, which are initially equal to them,
% as per the StandardInnerEquations
def StandardInnerPoints=
  ine,inw,isw,ise,in,is,ie,iw,ic
enddef;

vardef isStandardPoint@#=
  (
    (str @#="ne") or (str @#="nw") or (str @#="sw") or (str @#="se") or
    (str @#="n") or (str @#="s") or (str @#="e") or (str @#="w") or
    (str @#="c")
  )
enddef;

vardef StandardEquationsRaw@#=
  @#se-@#sw=@#ne-@#nw;  % parallelogram equation
  @#n=.5[@#ne,@#nw];    % North
  @#s=.5[@#se,@#sw];    % South
  @#e=.5[@#ne,@#se];    % East
  @#w=.5[@#nw,@#sw];    % West
  @#c=.5[@#n,@#s];      % Center
enddef;

% These are the equations connecting the outer bounding box
% (i.e. the interface) to the inner bounding box (the interface
% as seen from the inside)
def StandardInnerEquations=
  ("@#ine=@#ne;@#inw=@#nw;@#isw=@#sw;@#ise=@#se;@#in=@#n;@#is=@#s;" &
   "@#ie=@#e;@#iw=@#w;@#ic=@#c;")
enddef;


% It is important that this be a string, because there is a
% |sc_(PureStandardEquations)| somewhere.
def PureStandardEquations=
  ("@#se-@#sw=@#ne-@#nw;" & % parallelogram equation
   "xpart(@#se-@#ne)=0;" &
   "ypart(@#se-@#sw)=0;" &
   "@#n=.5[@#ne,@#nw];" &    % North
   "@#s=.5[@#se,@#sw];" &    % South
   "@#e=.5[@#ne,@#se];" &    % East
   "@#w=.5[@#nw,@#sw];" &    % West
   "@#c=.5[@#n,@#s];" )      % Center
enddef;

def StandardEquations=
  (PureStandardEquations & StandardInnerEquations)
enddef;

% This is the minimum set of equations for standard points,
% assuming only the middle relations. It is convenient if
% you want to control completely where the corners of the
% object are. This is for instance used in the |RandomBox| class.
def MinimumStandardEquations=
 ("@#n=.5[@#ne,@#nw];" &    % North
  "@#s=.5[@#se,@#sw];" &    % South
  "@#e=.5[@#ne,@#se];" &    % East
  "@#w=.5[@#nw,@#sw];" &    % West
  "@#c=.5[@#n,@#s];"        % Center
  & StandardInnerEquations)
enddef;

def StandardNumerics=
  dx,dy
enddef;

def StandardInterface=
  ObjPoint StandardPoints,StandardInnerPoints;
  ObjNumeric StandardNumerics;
enddef;

% Normally, the user can specify that a certain point in
% a certain subobject is tied (that is, is bound to it
% linearly, modulo the linear transformations) to
% a certain point in the main object.
% This is done with |tiePointToSubpoint(sw,sub,A)|
% for instance. If we assume that the first point of the
% main object (first in the point declarations)
% is always defined, and that this is the same for
% the subobjects, we can automatically tie all those
% pairs of points. The user will actually seldom
% need more. And what would that be anyway?
% If there are no subobjects, this function does nothing.
vardef StandardTies=
  save mainfirst,subfirst,co;
  string mainfirst,subfirst,co;
  co=currentObjname;
  mainfirst=firstPointOf_(co);
  % we loop over all subobjects
  % first, regular subobjects:
  if sc_(co).sublist_<>"":
    forsuffixes $:=sc_(sc_(co).sublist_):
      subfirst:=firstPointOf_(sc_(co)$);
      sc_("tiePointToSubpoint(" & mainfirst & "," &
          str $ & "," & subfirst & ")"); % ties |$subfirst| to |mainfirst|
    endfor;
  fi;
  % then arrays of subobjects:
  if sc_(co).subarraylist_<>"":
    forsuffixes $:=sc_(sc_(co).subarraylist_):
      for i:=1 upto sc_(co)$n_:
        % we check that the subobject is defined (in certain case,
        % such as matrices, there can be holes)
        if known sc_(co)$[i]:
          subfirst:=firstPointOf_(sc_(co)$[i]);
          sc_("tiePointToSubpoint(" & mainfirst & "," &
              str $ & decimal i & "," & subfirst & ")");
                % ties |$subfirst| to |mainfirst|
        fi;
      endfor;
    endfor;
  fi;
enddef;

% In order to extract the first point of an object,
% we go through its |pointlist_| string, and exit
% as soon as we have a suffix. In case this string is empty
% (that's very unlikely), we go through |points_in_arrayslist_|.
% If both are empty, there is no first point and we return an empty string.
% |n| is a suffix in string form.
vardef firstPointOf_(expr n)=
  save first_;string first_;
  hide(
  forsuffixes $:=sc_(sc_(n).pointlist_):
    first_:=str $;
    exitif first_<>"";
  endfor;
  if first_="":
    forsuffixes $:=sc_(sc_(n).points_in_arrayslist_):
      first_:=str $;
      exitif first_<>"";
    endfor;
  fi;)
  first_
enddef;

% This function finds the internal index of a point, where
% the |ObjPoint|s come first, then the points defined in an |ObjPointArray|.
% For instance, if |ObjPoint a,b,c| and |ObjPointArray(po)(7)|,
% the index of |a| is 1, the index of |b| is 2, the index of |c| is 3,
% the index of |po1| is 4, the index of |po2| is 5, etc.
% |n| is the object.
vardef indexOfPoint(suffix n)(text v)=
  save i_,j_,found_; % |v| can't be |i_| or |j_|
  hide(
  boolean found_;found_=false;
  j_:=0;
  if n.pointlist_<>"":
    forsuffixes i_:=sc_(n.pointlist_):
      j_:=j_+1;
      if str i_=str v:found_:=true;fi;
      exitif found_;
    endfor;
  fi;
  if not found_:
    if n.points_in_arrayslist_<>"":
      for i_:=sc_(n.points_in_arrayslist_):
        j_:=j_+1;
        if str i_=str v:found_:=true;fi;
        exitif found_;
      endfor;
    fi;
  fi;
  if not found_:j_:=0;fi;
  ) j_
enddef;

% This function needs to be called when points are added to an array
vardef addPointToPointArray@#(suffix a)=
  save co;string co;co=str @#;
  @#a.n_:=@#a.n_+1;
  if sco_(".points_in_arrayslist_")="":
    sco_(".points_in_arrayslist_"):=str a & decimal @#a.n_;
  else:
    sco_(".points_in_arrayslist_"):=
            sco_(".points_in_arrayslist_") & "," & str a & decimal @#a.n_;
  fi;  
enddef;

% These are points that will move with the object.
% Pairs that do not move can be declared with |ObjPairArray|.
vardef ObjPointArray(suffix a)(expr n)=
  save co;string co;co=currentObjname;
  if not isOfType("pair",co & "." & str a & "1"):
    sc_ ("pair " & generisize_(co) & "." & str a & "[]");
  fi;
  sco_("." & str a & ".n_"):=n;
  if sco_(".pointarraylist_")="":
    sco_(".pointarraylist_"):= str a;
  else:
    sco_(".pointarraylist_"):=sco_(".pointarraylist_") &","& str a;
  fi;
  for i:=1 upto n:
    if sco_(".points_in_arrayslist_")="":
      sco_(".points_in_arrayslist_"):=str a & decimal i;
    else:
      sco_(".points_in_arrayslist_"):=
            sco_(".points_in_arrayslist_") & "," & str a & decimal i;
    fi;
  endfor;
enddef;


% For pairs:
%   |name| can be |"Pair"|
%   |type|        |"pair"|
%   |var|         |"pairarraylist_"|
% This creates a function |ObjPairArray| storing the pairs
% in the |"pairarraylist_"| variable of the current object.
% The first parameter of |ObjPairArray| is the name of the array
% and the second parameter is its size. The function created memorizes
% the size of the array.
% The size can be modified afterwards, but only as many elements
% as were announced will be manipulated in automatic operations
% such as |duplicateObj|.
vardef defineArrayFunction(expr name)(expr type)(expr var)=
  save tmp;string tmp;
  tmp="vardef Obj" & name & "Array(suffix a)(expr n)=" &
        "save co;string co;co=currentObjname;" &
        "if not isOfType(" & quote(type) &",co & " & quote(".") &
            " & str a & " & quote("1") & "):" &
          "sc_ (" & quote(type & " ") & " & generisize_(co) & " &
            quote(".") & " & str a & " & quote("[]") & ");" &
        "fi;" &
        "sco_(" & quote(".") & " & str a & " &
            quote(".n_") & "):=n;" &
        "if sco_(" & quote("." & var) & ")=" & quote("") & ":" &
          "sco_(" & quote("." & var) & "):= str a;" &
        "else:" &
          "sco_(" & quote("." & var) & "):=" &
             "sco_(" & quote("." & var) & ") & " &
                  quote(",") & " & str a;" &
        "fi;" &
      "enddef;";
  sc_ tmp;
enddef;

defineArrayFunction("Numeric")("numeric")("numericarraylist_");
defineArrayFunction("String")("string")("stringarraylist_");
defineArrayFunction("Sub")("string")("subarraylist_");
defineArrayFunction("Pair")("pair")("pairarraylist_");
defineArrayFunction("Color")("color")("colorarraylist_");
defineArrayFunction("Picture")("picture")("picturearraylist_");
defineArrayFunction("Transform")("transform")("transformarraylist_");
defineArrayFunction("Boolean")("boolean")("booleanarraylist_");

% |t| is a list of strings, representing the object code,
% including equations (see examples)
vardef ObjCode text l=
  save s_,mac_,i_; % notice that we don't have to say that |s_| is a string!
  string mac_;mac_="";
  % The problem with object code and the equations it contains
  % is that they contain the name of the object,
  % but as given in the new... macro.
  % We only have the formal parameter name!
  % We must assume that it is `|@#|'. Maybe in the future, we will
  % guess it from the equations. Hope is not lost!
  % We now define locally (just in this |ObjCode| macro)
  % a macro having `|@#|' as a suffix parameter:
  % The macro looks like:
  %  |vardef code_function_@#= <the equations> enddef;|

  for s_:=l:mac_:=mac_&s_ & ";"; endfor;
  % we store the equations in the object; this is useful when an
  % object gets duplicated:
  sco_(".code_"):=mac_;
  begingroup; % we want the |vardef| macro only defined locally;
              % we don't need it later
    save code_function_;
    mac_:="vardef code_function_@#=" & mac_ & " enddef;";
    sc_ mac_; % this defines the macro
    % we call it with
    sc_ ("code_function_." & currentObjname);
  endgroup;
enddef;

% This function adds equations to an already existing object.
% These equations should only define new points, not alter
% previously defined points. 
vardef addObjCode@# text l=
  save mac;string mac;mac="";
  for s:=l:mac:=mac&s & ";"; endfor;
  @#code_:=@#code_ & mac;
enddef;

vardef addObjExtraCode@# text l=
  save mac;string mac;mac="";
  for s:=l:mac:=mac&s & ";"; endfor;
  @#extra_code_:=@#extra_code_ & mac;
enddef;

% |sub| is a field name and |t| is the subobject name
% we could even use the same name for boths
def SubObject(suffix sub)(suffix t)=
  if expandafter not expandafter string sco_("." & str sub):
    sc_ ("string " & generisize_(currentObjname) & "." & str sub);
  fi;
  sco_("." & str sub)=str t;
  if sco_(".sublist_")="":
    sco_(".sublist_"):=str sub;
  else:
    sco_(".sublist_"):=sco_(".sublist_") & "," & str sub;
  fi;
enddef;

def SubObjectOfArray(suffix sub)(suffix t)=
  sco_("." & str sub)=str t;
enddef;

% Point |b| of subobject |sub| (of the current object)
% is tied to point |a| of the current object.
% This means that we memorize an equation.
vardef tiePointToSubpoint(suffix a,sub,b)=
  save co,n,j;string co;co=currentObjname;
  obj(co).nsubobjties_:=obj(co).nsubobjties_+1;
  n=obj(co).nsubobjties_;
  % We must memorize the following code:
  %   |q_[n]=obj(co.sub).b;|
  %   |transformObj(obj(currentObjname.sub))($);|
  %   |co.a-obj(co.sub).b=(p_[j]-q_[n]) transformed $;|
  % (where |p_[j]| is the memorized value of the current objects' "a" point)
  % We have to find `|j|':
  j=indexOfPoint(obj(co))(a);
  % we store everything in a |vardef|, using |@#| instead of co
  % (this is necessary for matters of duplication)
  obj(co).subobjties_[n]:=
   "vardef tie_function_@#(expr $)=" &
     "q_" & decimal n & "=obj(@#" & str sub & ")." & str b &";" &
     "transformObj(obj(@#" & str sub & "))($);" &
     "@#" & str a & "-obj(@#" & str sub & ")." & str b &
     "=(p_" & decimal j & "-q_" & decimal n & ") transformed $;" &
    "enddef;";
enddef;

% Generation of new names (suffixes):
% All the names will start with |"_______"|.
% This initial string can be changed but it must end with |_|.
% The suffixes are generated in that order:
% |_______a|, |_______b|, |_______c|, ..., |_______z|,
% |_______aa|, |_______ab|, |_______ac|, ..., |_______az|,
% |_______ba|, ..., |_______bz|, |_______ca|, ...,
% |_______zz|, |_______aaa|, |_______aab|, etc.  
% All we need to is remember the last created suffix.
% We store it in a string:
string last_obj_;last_obj_="_______";

vardef newobjstring_=
  save l,prefix,lastchar,lastpos,lastposchar;
  hide(
    numeric lastpos;
    string prefix,lastchar,lastposchar;
    l=length(last_obj_);
    lastchar=substring (l-1,l) of last_obj_;
    if lastchar="_":
      last_obj_:=last_obj_ & "a";
    elseif lastchar="z":
      % in this case, we find the last character different from "z";
      % it is either a letter, or `|_|'
      lastpos=l;
      for i:=l-1 downto 1:
        lastpos:=i;
        lastposchar:=substring (i-1,i) of last_obj_;
        exitif (lastposchar<>"z");
      endfor;
      if lastposchar="_": % in this case, we have only z's
        last_obj_:=last_obj_ & "a";
      else:
        last_obj_:=(substring (0,lastpos-1) of last_obj_) &
           char(ASCII lastposchar +1)
           for i:=lastpos+1 upto l: & "a" endfor;
      fi;
    else:
      last_obj_:=
        (substring (0,l-1) of last_obj_) & char(ASCII lastchar +1);
    fi;
    )
  last_obj_
enddef;


% We can call this function for instance with
% |duplicateArray_(n,m)("ObjStringArray")(stringarraylist_)|
vardef duplicateArray_(suffix n,m)(expr f)(suffix var)=
  if m.var<>"":
    forsuffixes $:=sc_(m.var):
      sc_(f & "(" & str $ & ")(" & decimal m$n_ & ");");
      % we can do the previous |Obj...Array| because |assignObj|
      % defined the current object
      % we also fill the array:
      for i:=1 upto m$n_:
        n$[i]:=m$[i];
      endfor;
    endfor;
  fi;
enddef;

% This creates a copy of object |m| in object |n|
% If |n| contained something, it gets either overriden (if the fields
% were common with those of |m|, or meaningless (if the fields
% were not common with those of |m|)
% The various strings are copied, and the object code is executed
% (this recreates the equations, as when the object is created by
% a constructor). The difference with the constructor is that
% no parameter is given and that we make a deep copy.
% We also copy the subobjects.
% Problem: we need new names for the subobjects.
% We solve that problem by using the ``name generator'' |newobjstring_|
%
vardef duplicateObj(suffix n,m)=
  assignObj(n)(objClassName_(m)); % new number, but same type
  % |n.pointlist_:=m.pointlist_;| % (see below)
  % |n.pointarraylist_:=m.pointarraylist_;| % (see below)
  % |n.points_in_arrayslist_:=m.points_in_arrayslist_;| % (see below)
  n.code_:=m.code_;
  n.extra_code_:=m.extra_code_;
  % |n.picturelist_:=m.picturelist_;| % (see below)
  n.nsubobjties_:=m.nsubobjties_;
  for i:=1 upto n.nsubobjties_:
    n.subobjties_[i]:=m.subobjties_[i];
  endfor;

  n.sublist_:=m.sublist_; % list of subobjects (this doesn't change,
                          % but the values of the subobjects will be new)
  % create the types:
  if m.pointlist_<>"":
    % this also fills |n.pointlist_|
    sc_ ("ObjPoint " & m.pointlist_); 
  fi;
  if m.picturelist_<>"":
    % this also fills |n.picturelist_| and creates all appropriate variables
    sc_ ("ObjPicture " & m.picturelist_); 
  fi;

  % Duplication of numerical values:
  if m.numericlist_<>"":
    sc_ ("ObjNumeric " & m.numericlist_); % this also fills |n.numericlist_|
  fi;
  
  % Duplication of boolean values:
  if m.booleanlist_<>"":
    sc_ ("ObjBoolean " & m.booleanlist_); % this also fills |n.booleanlist_|
  fi;
  
  % Duplication of color values:
  if m.colorlist_<>"":
    sc_ ("ObjColor " & m.colorlist_); % this also fills |n.colorlist_|
  fi;
  
  % Duplication of string values:
  if m.stringlist_<>"":
    sc_ ("ObjString " & m.stringlist_); % this also fills |n.stringlist_|
  fi;
  
  % Duplication of transform values:
  if m.transformlist_<>"":
    sc_ ("ObjTransform " & m.transformlist_); % fills also |n.transformlist_|
  fi;
  
  % Duplication of pairs:
  if m.pairlist_<>"":
    sc_ ("ObjPair " & m.pairlist_); % this also fills |n.pairlist_|
  fi;
  
  % copy the current transformation of the object:
  n.ctransform_:=m.ctransform_;

  save gen_n_;string gen_n_;gen_n_=generisize_(str n);
  % we copy the options and their values:
  if known m.options_:
    %if (gen_n_=str n): % UNSURE IF THIS SHOULD ALWAYS BE COMMENTED (October 23, 2005)
      if unknown n.options_:
        expandafter string sc_(gen_n_).options_;
      fi;
    %fi
    n.options_=m.options_;
    forsuffixes $:=sc_(n.options_):
      % each |$| suffix starts with a |_|
      %if gen_n_=str n: % UNSURE IF THIS SHOULD ALWAYS BE COMMENTED (October 23, 2005)
        if expandafter unknown sc_(str n & ".option" & str $ & "_"):
          sc_(TypeOf(sc_(str m & ".option" & str $ & "_")) & " " &
            gen_n_ & ".option" & str $ & "_");
        fi;
      %fi;
      n.sc_("option" & str $ & "_")=m.sc_("option" & str $ & "_");
    endfor;
  fi;

  % we copy the numerical, pair and picture values if there are any
  forsuffixes $$=numericlist_,booleanlist_,colorlist_,stringlist_,
                 transformlist_,pairlist_,picturelist_:
    if n$$<>"":
      forsuffixes $:=sc_(n$$):n$:=m$;endfor;
    fi;
  endfor;

  % the following fills |n.pointarraylist_|
  % as well as |n.points_in_arrayslist_|
  if m.pointarraylist_<>"":
    forsuffixes $:=sc_(m.pointarraylist_):
      sc_("ObjPointArray(" & str $ & ")(" & decimal m$n_ & ");");
      % we can do the previous |ObjPointArray| because |assignObj|
      % defined the current object
    endfor;
  fi;
  
  % We duplicate the numeric arrays:
  duplicateArray_(n,m)("ObjNumericArray")(numericarraylist_);
  
  % We duplicate the pair arrays (non movable points);
  % this includes the structures memorizing paths:
  duplicateArray_(n,m)("ObjPairArray")(pairarraylist_);
  
  % We duplicate the string arrays:
  % it also fills |n.stringarraylist_|
  duplicateArray_(n,m)("ObjStringArray")(stringarraylist_);

  % We duplicate the color, picture, transform and boolean arrays:
  duplicateArray_(n,m)("ObjColorArray")(colorarraylist_);
  duplicateArray_(n,m)("ObjPictureArray")(picturearraylist_);
  duplicateArray_(n,m)("ObjTransformArray")(transformarraylist_);
  duplicateArray_(n,m)("ObjBooleanArray")(booleanarraylist_);
  
  % this is similar, but for Object arrays
  % it also fills |n.subarraylist_|
  if m.subarraylist_<>"":
    forsuffixes $:=sc_(m.subarraylist_):
      sc_("ObjSubArray(" & str $ & ")(" & decimal m$n_ & ");");
      % we can do the previous |ObjSubArray| because |assignObj|
      % defined the current object
      % Here, we do not copy the strings, because we are doing a deep copy
    endfor;
  fi;
  
  % Copy the information on subobjects (variables) and
  % call |duplicateObj| appropriately

  % First, the subobjects that are not part of arrays of subobjects:
  % we go through all suffixes corresponding to subobjects
  % of object |m|, and for each, we create a new name
  save newsub_;string newsub_;
  if n.sublist_<>"":
    forsuffixes $:=sc_(n.sublist_):
      newsub_:=newobjstring_;
      % first, create the type:
      if not string n$:
        sc_("string " & generisize_(str n & "." & str $));
      fi;
      n$:=newsub_;
      % we must now duplicate |obj(m$)| as |obj(n$)|; this will
      % also choose a value for |obj(m$)|
      duplicateObj(obj(n$),obj(m$));
    endfor;
  fi;
  % Second, the subobjects that are part of arrays of subobjects:
  % we go through all arrays of subobjects
  % of object |m|, and for each, we create a new name
  if n.subarraylist_<>"":
    forsuffixes $:=sc_(n.subarraylist_):
      % and now, we go through each element of the array:
      for i:=1 upto m$n_:
        % we only duplicate if there is something
        % (in matrices, for instance, certain objects can be null)
        if known m$[i]:
          newsub_:=newobjstring_;
          n$[i]:=newsub_;
          duplicateObj(obj(n$[i]),obj(m$[i]));
        fi;
      endfor;
    endfor;
  fi;

  % relink everything: we take the first point of this object,
  % and recreate all equations; we cannot take the code stored,
  % because it is the initial code, and the duplication of a
  % rotated object would then not be a rotated object
  % (except if we store all transformations, but this would
  % restrict us anyway to linear transformations)
  save mainfirst;string mainfirst;
  mainfirst=firstPointOf_(str n);
  
  % go through all points except the first, and relink
  forsuffixes $$=pointlist_,points_in_arrayslist_:
    if n$$<>"":
      forsuffixes $:=sc_(n$$):
        if str $<>mainfirst:
          n.sc_(mainfirst)-n$=m.sc_(mainfirst)-m$;
        fi;
      endfor;
    fi;
  endfor;

  % go to all regular subobjects, and relink

  if n.sublist_<>"":
    forsuffixes $:=sc_(n.sublist_):
      n.sc_(mainfirst)-obj(n$).obj(firstPointOf_(n$))=
        m.sc_(mainfirst)-obj(m$).obj(firstPointOf_(m$));
    endfor;
  fi;

  % go through all array subobjects, and relink;
  % we go through all arrays of subobjects
  % of object |m|, and for each, we create a new name
  if n.subarraylist_<>"":
    forsuffixes $:=sc_(n.subarraylist_):
      % and now, we go through each element of the array:
      for i:=1 upto n$n_:
        if known n$[i]:
          n.sc_(mainfirst)-obj(n$[i]).obj(firstPointOf_(n$[i]))=
            m.sc_(mainfirst)-obj(m$[i]).obj(firstPointOf_(m$[i]));
        fi;
      endfor;
    endfor;
  fi;
enddef;

% Streamlined version of |duplicateObj|: |n| is a number representing an object
% This function takes a number representing an object,
% duplicates it and returns a number representing its duplication.
vardef duplicate_Obj(expr n)=
  save newname_;string newname_;
  hide(
    % we do not set |streamlined_| to true, because it should be
    % used only before a constructor is called, which is not the case here.
    % first, choose a new name for the duplication:
    newname_:=newobjstring_;
    duplicateObj(obj(newname_),obj(iname_[n]));
  ) sc_(newname_)
enddef;

% This function merely unties all points of an object,
% but keeps the equations. Also, the subobjects remain attached
% to the main object. What it does is part of what
% |duplicateObj| does.
% |untieObj| is applied recursively.
%
% This function makes it possible to draw an object somewhere,
% to untie it and move it elsewhere, to draw it there, etc.
% We could achieve the same effect with duplication, but it would
% consume more memory.
vardef untieObj(suffix n)=
  save fp,p_,q_,i;
  string fp;pair p_[],q_[];
  % we first extract a point
  fp=firstPointOf_(str n);
  % we now go through all the points and store the differences
  % with the point |fp|
  i:=0;
  forsuffixes $$=pointlist_,points_in_arrayslist_:
    if n$$<>"":
      forsuffixes $:=sc_(n$$):i:=i+1;
        p_[i]=n$-n.sc_(fp);
      endfor;
    fi;
  endfor;

  % we also store the positions of the first points of all subobjects
  i:=0;
  
  if n.sublist_<>"":
    forsuffixes $:=sc_(n.sublist_):i:=i+1;
      q_[i]=obj(n$).obj(firstPointOf_(n$))-n.sc_(fp);
    endfor;
  fi;
  if n.subarraylist_<>"":
    forsuffixes $:=sc_(n.subarraylist_):
      for j:=1 upto n$n_:
        if known n$[j]:
          i:=i+1;
          q_[i]=obj(n$[j]).obj(firstPointOf_(n$[j]))-n.sc_(fp);
        fi;
      endfor;
    endfor;
  fi;
  
  % we refresh all points:

  save varlist_;string varlist_;
  if n.pointlist_="":varlist_=n.points_in_arrayslist_;
  else:
    if n.points_in_arrayslist_<>"":
      varlist_=n.pointlist_ & "," & n.points_in_arrayslist_;
      else: varlist_=n.pointlist_;
    fi;
  fi;
  refreshObjVars_(n)(sc_(varlist_));

  % we untie the subobjects

  if n.sublist_<>"":
    forsuffixes $:=sc_(n.sublist_):
      untieObj(obj(n$));
    endfor;
  fi;
  if n.subarraylist_<>"":
    forsuffixes $:=sc_(n.subarraylist_):
      for j:=1 upto n$n_:
        if known n$[j]:
          untieObj(obj(n$[j]));
        fi;
      endfor;
    endfor;
  fi;
  
  % and we recreate the differences from the ones stored:
  % (exactly the same code as above!)
  i:=0;
  forsuffixes $$=pointlist_,points_in_arrayslist_:
    if n$$<>"":
      forsuffixes $:=sc_(n$$):i:=i+1;
        p_[i]=n$-n.sc_(fp);
      endfor;
    fi;
  endfor;

  % we also attach again the subobjects
  % (also exactly the same code as above!)
  i:=0;
  if n.sublist_<>"":
    forsuffixes $:=sc_(n.sublist_):i:=i+1;
      q_[i]=obj(n$).obj(firstPointOf_(n$))-n.sc_(fp);
    endfor;
  fi;
  if n.subarraylist_<>"":
    forsuffixes $:=sc_(n.subarraylist_):
      for j:=1 upto n$n_:
        if known n$[j]:
          i:=i+1;
          q_[i]=obj(n$[j]).obj(firstPointOf_(n$[j]))-n.sc_(fp);
        fi;
      endfor;
    endfor;
  fi;  
enddef;

% Draw an array of objects. |n| is the object, |a| is the array,
% and the number of elements are assumed to be |a.n_|
% If you don't want to draw all the subobjects, make your own function.

def drawObjArray(suffix n)(suffix a)=
  for i:=1 upto n.a.n_:
    if known n.a[i]: % in certain cases (for instances matrices),
                     % we can have holes in the array
      drawObj(obj(n.a[i]));
    fi;
  endfor;
enddef;

% One idea for implementing |resetObj.expl| is to have the object
% constructor behave in a certain way when a flag is set. This way
% would be to refresh the variables, and to call again the equations.
% The problem with this approach is that subobjects have also to
% be reset, and this makes it necessary to give again the
% parameters of the constructor, since we don't save them,
% and since there is no constructor overloading in metapost.
% Hence, we decided to merely use the code in |ObjCode| sections.
% We first refresh the variables (only points), then call
% reset on the subobjects, then execute the memorized code.
% This constrains the user to put his code in |ObjCode|.
% (Otherwise, if |resetObj.expl| is never used, the code can just
% be given outside |ObjCode|, and not in strings.)

vardef resetObj.expl@#=
  save varlist_;string varlist_;
  % refresh the points (also those in arrays)
  if @#pointlist_="":varlist_=@#points_in_arrayslist_;
  else:
    if @#points_in_arrayslist_<>"":
      varlist_=@#pointlist_ & "," & @#points_in_arrayslist_;
      else: varlist_=@#pointlist_;
    fi;
  fi;
  refreshObjVars_(@#)(sc_(varlist_));
  
  % reset the current transformation:
  @#ctransform_:=identity;

  % reset the label transformations
  % (as can be observed, this does not place us back in the
  % initial state, if labels were only added after the application
  % of a transformation to an object)
  if known @#ipic_.n_:
    for i:=1 upto @#ipic_.n_:
      @#ipic_.transf_[i]:=identity;
    endfor;
  fi;
  
  % reset all subobjects

  if @#sublist_<>"":
    forsuffixes $:=sc_(@#sublist_):
      resetObj.expl.obj(@#.$);
    endfor;
  fi;
  if @#subarraylist_<>"":
    forsuffixes $:=sc_(@#subarraylist_):
      % and now, we go through each element of the array:
      for i:=1 upto @#.$n_:
        if known @#.$[i]:
          resetObj.expl.obj(@#.$[i]);
        fi;
      endfor;
    endfor;
  fi;

  % call the code
  begingroup; % we want the |vardef| macro only defined locally;
              % we don't need it later
    save code_function_;
    % define the function
    sc_("vardef code_function_@#=" & @#code_ & @#extra_code_ &
                   " enddef;");
    % call it
    code_function_@#;
  endgroup;
  
enddef;

% In order to find which point of an object is the most
% to the left, we search which of the four corners is such that
% all others are to its right. We return a string corresponding
% to the corner. |"sw"| for |sw|, etc.
% This function does not assume the corners to be determined,
% but it assumes that the vector between two points is known.
% |f| is |xpart| or |ypart|
% |g| is |<| or |>|
vardef findmost@#(text f)(text g)=
  save found_,i,corner;
  hide(
  string corner;boolean found_;found_=false;
  forsuffixes $:=nw,ne,sw,se:
    i:=0;
    forsuffixes $$:=nw,ne,sw,se:
      exitif f (@#.$$-@#.$) g 0;
      i:=i+1;
    endfor;
    if i=4:found_:=true;corner:=str $;fi;
    exitif found_;
  endfor;
  )
  corner
enddef;

% Recursive version of |findmost|. This function returns a numeric
% corresponding to the x or y part of a point.
% |f| is |xpart| or |ypart| and |g| is |<| or |>|
vardef findrecmost@#(text f)(text g)=
  save found_,i,corner,currentsub;
  hide(
    numeric corner,currentsub;boolean found_;found_=false;
    % first, we check the four corners of the object
    forsuffixes $:=nw,ne,sw,se:
      i:=0;
      forsuffixes $$:=nw,ne,sw,se:
        exitif f (@#.$$-@#.$) g 0;
        i:=i+1;
      endfor;
      if i=4:found_:=true;corner:=f(@#.$);fi;
      exitif found_;
    endfor;
    % then, we check each subobject recursively:
    % and first, the regular subobjects:
    if @#sublist_<>"":
      forsuffixes $:=sc_(@#sublist_):
        % check |obj(@#.$)|:
        currentsub:=findrecmost.obj(@#.$)(f)(g);
        if not (corner-currentsub g 0):
          corner:=currentsub;
        fi;
      endfor;
    fi;
    % and second, the subobjects that are part of arrays of subobjects:
    % we go through all arrays of subobjects  of object |@#|:
    if @#subarraylist_<>"":
      forsuffixes $:=sc_(@#subarraylist_):
        % and now, we go through each element of the array:
        for i:=1 upto @#.$n_:
          % check |obj(@#.$[i])|:
          if known @#.$[i]:
            currentsub:=findrecmost.obj(@#.$[i])(f)(g);
            if not (corner-currentsub g 0):
              corner:=currentsub;
            fi;
          fi;
        endfor;
      endfor;
    fi;
    )
  corner
enddef;

% These functions return a string corresponding to a suffix:
vardef find_lft_most@#= findmost@#(xpart)(<) enddef;
vardef find_rt_most@#=  findmost@#(xpart)(>) enddef;
vardef find_top_most@#= findmost@#(ypart)(>) enddef;
vardef find_bot_most@#= findmost@#(ypart)(<) enddef;

% The following are recursive versions of the previous functions.
% These functions return a numeric.
vardef findrec_lft_most@#= findrecmost@#(xpart)(<) enddef;
vardef findrec_rt_most@#=  findrecmost@#(xpart)(>) enddef;
vardef findrec_top_most@#= findrecmost@#(ypart)(>) enddef;
vardef findrec_bot_most@#= findrecmost@#(ypart)(<) enddef;

%========================================================================
% Streamlining

% We use a boolean to keep distinguish a streamlined function, from
% a non-streamlined one. This is needed to find out if a name has been
% given explicitely to an object.
boolean streamlined_;streamlined_=false;
% This boolean is set to true, which means that every time
% an object is defined with an explicit name, the string version
% of the name can be used as a shortcut. This is sometimes useful.
% Setting the boolean to false saves some space.
boolean memorizeShortcuts;memorizeShortcuts=true;

% Called with something like |streamline("BB")("(expr t)","suffixpar(t)");|
% where |t| represents the {\it number\/} of an object,
% the streamline function creates two variants of a constructor:
% 1) a first variant without options:
%|vardef new_BB(expr t)=|
%|  save newname_;string newname_;|
%|  hide(|
%|    streamlined_:=true;|
%|    newname_:=newobjstring_;|
%|    newBB.sc_(newname_) suffixpar(t);|
%|  )|
%|  sc_(newname_)|
%|enddef;|

% 2) a second variant with options:
%|vardef new_BB_(expr t)(text options)=|
%|  save newname_;string newname_;|
%|  hide(|
%|    streamlined_:=true;|
%|    newname_:=newobjstring_;|
%|    newBB.sc_(newname_) suffixpar(t) options;|
%|  )|
%|  sc_(newname_)|
%|enddef;|

% Called with something like
% |streamline("Tree")("(expr theroot)(text subtrees)",|
%                    |"suffixpar(theroot) suffixlist(subtrees)");|
% the streamline function creates the two variants:
%|vardef new_Tree(expr theroot)(text subtrees)=|
%|  save newname_;string newname_;|
%|  hide(|
%|    streamlined_:=true;|
%|    newname_:=newobjstring_;|
%|    newTree.sc_(newname_) suffixpar(theroot) suffixlist(subtrees);|
%|  )|
%|  sc_(newname_)|
%|enddef;|
%
% and
%
%|vardef new_Tree_(expr theroot)(text subtrees)(text options)=|
%|  save newname_;string newname_;|
%|  hide(|
%|    streamlined_:=true;|
%|    newname_:=newobjstring_;|
%|    newTree.sc_(newname_) suffixpar(theroot) suffixlist(subtrees)|
%|                                  options;|
%|  )|
%|  sc_(newname_)|
%|enddef;|
%

% In the above variants, |theroot| is not a suffix, but a string representing
% a suffix, as possibly returned by another |new_| call.
% Similarly, |subtree| is not a list of suffixes, but a list
% of strings representing suffixes. In one case, |suffixpar| must be specified
% in the parameters of |streamline|. In the other case, one has to write
% |suffixlist|.
% |suffixlist| transforms a list of strings into a list of suffixes.


% These ``streamlined'' variants do not take 
% an object name; instead, they provide one by themselves; then they
% call the regular constructor, and the name of the object
% is returned as a string
% The three parameters are strings.

vardef streamline(expr class,formalparameters,actualparameters)=
  save mac;string mac;
  mac="vardef new_" & class & formalparameters &
    "=save newname_;string newname_;" &
    "hide(streamlined_:=true;newname_:=newobjstring_;new" &
      class & ".sc_(newname_)" &
        actualparameters & ";)sc_(newname_) enddef;";
  sc_ mac;
  % variant with options:  
  mac:="vardef new_" & class & "_" & formalparameters &
    "(text options)=save newname_;string newname_;" &
    "hide(streamlined_:=true;newname_:=newobjstring_;new" &
      class & ".sc_(newname_)" &
        actualparameters & " options;)sc_(newname_) enddef;";
  sc_ mac;
  % we also create the "is" function:
  createClassTest(class);
enddef;

% A few definitions used above:

def suffixpar(expr s)=(obj(iname_[s])) enddef;

vardef concatsuffixlist_(text t)=
  save tmp;string tmp;
  hide(
    tmp="";
    for $:=t:
      if tmp<>"":
        tmp:=tmp & "," & iname_[$];
      else:
        tmp:=iname_[$];
      fi;
    endfor;
    )
  tmp
enddef;

% From a list of numbers, produces the concatenation of the
% associated suffixes, ready for a |text| parameter
def suffixlist(text t)=
  expandafter (sc_ concatsuffixlist_(t))
enddef;

% This function tries to find an inner point among the points of object |@#|
% It returns the point name as a string, and an empty string if there
% is no inner point.
vardef find_inner_point@#=
  save inn;string inn;
  hide(
    inn="";
    % we first loop over the |pointlist_| array:
    if @#pointlist_<>"":
      forsuffixes $:=sc_(@#pointlist_):
        if not isStandardPoint$:inn:=str $;fi;
        exitif inn<>"";
      endfor;
    fi;
    if inn="":
      % we then loop over all points of arrays,
      % that is, the |points_in_arrayslist_|:
      if @#points_in_arrayslist_<>"":
        forsuffixes $:=sc_(@#points_in_arrayslist_):
          if not isStandardPoint$:inn:=str $;fi;
          exitif inn<>"";
        endfor;
      fi;
    fi;
    )
  inn
enddef;

% |rebindrelativeObj|:
% This function is in a certain way similar to |newBB| in that
% it provides a regular bounding box to an object. That means that
% the four corners will be where they should be: |.nw| at the top left,
% |.sw| at the bottom left, etc. 
% The difference with |newBB| is that it does not create
% a new object, it only modifies the one given in parameter.
% No object layer is added.
% It should be emphasized however that there is no guarantee
% that the new bounds will contain the whole object, because
% neither the drawing instructions 
% nor the subobjects are taken into account. We do not take
% the subobjects into account, because if we did, it would make it
% difficult to cheat on the bounding box.
% The new bounding box is only guaranteed to be the tightest
% containing the former corners of the current object,
% plus the shifts given in parameters.
% This function is useful when you want to pretend that
% the bounding box is different from what it is, because
% the bounding box is used to decide how much space an object
% takes when used within another object.
% This function looks complex because it is! The object we want
% to recompute may be floating and we have to preserve that;
% we have to move some points in a floating object.
% The four additionnal parameters are four dimensions,
% representing changes in size in the four directions.
% The values can be positive or negative. Positive values
% move up or towards the right, and negative values move
% down or towards the left.
vardef rebindrelativeObj(suffix n)(expr dyn,dys,dxe,dxw)=
  save innerpoint,xleft,xright,ytop,ybot,i,nwi,swi,nei,sei,mac;
  string innerpoint,mac;
  % we define arrays of points, which will be useful below:
  save p_,q_,r_;pair p_[],q_[],r_[];
%  message "*** Rebinding with parameters " &
%    decimal(dyn) & "," & decimal(dys) & "," &
%    decimal(dxe) & "," & decimal(dxw);
  % first, we find the bounds (left, right, bottom, top) of object |n|:
  % we only look at the current object and not its subobjects
  % (if one wants the real bounding box, taking into account all
  % visible parts, use |rebindvisibleObj|)
  xleft= xpart(n.sc_(find_lft_most.n)); 
  xright=xpart(n.sc_(find_rt_most.n));
  ytop=  ypart(n.sc_(find_top_most.n));
  ybot=  ypart(n.sc_(find_bot_most.n));
  
  % We distinguish two cases: either there is an inner point
  % (i.e., different from the standard points of the bounding box + .c
  % which we also consider part of the bounding box),
  % or there is no such point.
  % The standard points are those we are going to change.
  innerpoint=find_inner_point.n;
  if innerpoint="": % easy (but rare) case
    % (It is not compulsorily an error if the object has no other points,
    % it could well be a filling or space object.)
    % IN THIS CASE, WE IGNORE POSSIBLE SUBOBJECTS, SINCE WE ASSUME
    % THAT THEY ARE TIED TO INNER POINTS.
    % Here, we have only to give new values to the standard points.
    % We first compute the value of the top left corner (|p_1|)
    % and the differences:
    p_1=(xleft,ytop)+(dxw,dyn);
    p_2=(xleft,ybot)+(dxw,dys)-p_1;
    p_3=(xright,ytop)+(dxe,dyn)-p_1;
    p_4=(xright,ybot)+(dxe,dys)-p_1;
    % Then, we refresh the original bounding box
    refreshObjVars_(n)(ne,nw,se,sw,n,s,e,w,c);
    % and we could recreate the three differences:
    % |n.sw-n.nw=p_2-p_1;n.ne-n.nw=p_3-p_1;n.se-n.nw=p_4-p_1;|
    % however, because of the StandardEquations, we can just define
    % two opposite corners:
    n.se-n.nw=p_4-p_1;
    % Now, either |p_1| is known, or it is not. If it is known,
    % we give its value to |n.nw|:
    if known p_1: n.nw:=p_1;fi;
  else: % common case, more work
    % first we memorize (computed (nw) - n.nw), (computed (sw) - n.sw), etc.,
    % that is, how much each corner is going to move to reach its
    % standard position:
    q_1=(xleft,ytop)-n.nw+(dxw,dyn);
    q_2=(xleft,ybot)-n.sw+(dxw,dys);
    q_3=(xright,ytop)-n.ne+(dxe,dyn);
    q_4=(xright,ybot)-n.se+(dxe,dys);
    % these four differences will be used later
             
    % We now memorize the differences between all points and the
    % inner point; only those differences which are fully known
    % will be considered (IS THIS TRUE?);
    % this will allow us to accept a few non
    % known (and non used) points
    % WE HAVE ASSUMED THAT THE INNERPOINT IS ATTACHED INSIDE THE OBJECT
    i:=0;
    % First, go through the regular points:
    if n.pointlist_<>"":
      forsuffixes $:=sc_(n.pointlist_):i:=i+1;
        p_[i]=n$-n.sc_(innerpoint);
        % memorize the indexes of the points |nw|,|sw|,|ne|,|se| when they pass
        if str $="nw":nwi=i;elseif str $="sw":swi=i;
        elseif str $="ne":nei=i;elseif str $="se":sei=i;fi;
      endfor;
    fi;
    % then through all other points:
    if n.points_in_arrayslist_<>"":
      forsuffixes $:=sc_(n.points_in_arrayslist_):i:=i+1;
        p_[i]=n$-n.sc_(innerpoint);
      endfor;
    fi;
    % we also save the value of the inner point,
    % in case it is well in place:
    if known n.sc_(innerpoint):p_0=n.sc_(innerpoint);fi;

    % we save the differences between the innerpoint and the first
    % points of the subobjects, if there are any:

    i:=0;
    if n.sublist_<>"":
      forsuffixes $:=sc_(n.sublist_):i:=i+1;
        r_[i]=n.sc_(innerpoint)-obj(n$).obj(firstPointOf_(n$));
      endfor;
    fi;
    if n.subarraylist_<>"":
      forsuffixes $:=sc_(n.subarraylist_):
        % and now, we go through each element of the array:
        for j:=1 upto n$n_:
          if known n$[j]:
            i:=i+1;
            r_[i]=n.sc_(innerpoint)-
                    obj(n$[j]).obj(firstPointOf_(n$[j]));
          fi;
        endfor;
      endfor;
    fi;

    % we refresh everything:
    forsuffixes $$=pointlist_,points_in_arrayslist_:
      if n$$<>"":
        forsuffixes $:=sc_(n$$):refreshObjVars_(n)($);endfor;
      fi;
    endfor;
    
    % we also untie the subobjects:

    i:=0;
    if n.sublist_<>"":
      forsuffixes $:=sc_(n.sublist_):i:=i+1;
        untieObj(obj(n$));
      endfor;
    fi;
    if n.subarraylist_<>"":
      forsuffixes $:=sc_(n.subarraylist_):
        % and now, we go through each element of the array:
        for j:=1 upto n$n_:
          if known n$[j]:
            i:=i+1;
            untieObj(obj(n$[j]));
          fi;
        endfor;
      endfor;
    fi;

    % and we redefine everything except the standard points:
    i:=0;
    forsuffixes $$=pointlist_,points_in_arrayslist_:
      if n$$<>"":
        forsuffixes $:=sc_(n$$):i:=i+1;
          if not isStandardPoint$:
            n$-n.sc_(innerpoint)=p_[i];
          fi;
        endfor;
      fi;
    endfor;
    
    % and finally, we attach the subobjects (same code as above):

    i:=0;
    if n.sublist_<>"":
      forsuffixes $:=sc_(n.sublist_):i:=i+1;
        r_[i]=n.sc_(innerpoint)-obj(n$).obj(firstPointOf_(n$));
      endfor;
    fi;
    if n.subarraylist_<>"":
      forsuffixes $:=sc_(n.subarraylist_):
        % and now, we go through each element of the array:
        for j:=1 upto n$n_:
          if known n$[j]:
            i:=i+1;
            r_[i]=n.sc_(innerpoint)-
                 obj(n$[j]).obj(firstPointOf_(n$[j]));
          fi;
        endfor;
      endfor;
    fi;

    % Now, all non standard points are bound to the inner point.
    % Finally, we attach the standard points properly;
    % we know where the new corners are located in the old system
    % points, for instance
    %  |(xpart(n.sc_(lftmost)),ypart(n.sc_(topmost)))|
    % corresponds to the new |n.nw|; however, if the object is floating,
    % we cannot write |n.nw=(xpart(n.sc_(lftmost)),...)|
    % because the latter refers to variables that do no longer exist.
    % What we can do is to say 
    %   |new(n.nw)-new(n.innerpoint)=(old(n.nw)-old(n.innerpoint))|
    %                    |+ (old(computed nw)-old(n.nw))|
    % The value of |(old(n.nw)-old(n.innerpoint))| is in the |p_| array
    % The value of |old(computed nw)-old(n.nw)| has been computed above,
    % before the variables were refreshed. We can just add them.
    %
    % Of the four following equations, we define only two,
    % corresponding to opposite corners. Otherwise, there are redundant
    % equations.
    n.nw-n.sc_(innerpoint)=p_[nwi]+q_1; 
    %|n.sw-n.sc_(innerpoint)=p_[swi]+q_2;|
    %|n.ne-n.sc_(innerpoint)=p_[nei]+q_3;|
    n.se-n.sc_(innerpoint)=p_[sei]+q_4;
    
    % And finally, we define the innerpoint |p_0| if necessary
    if known p_0:n.sc_(innerpoint)=p_0;fi;
  fi;

  mac:="vardef code_function_@#= " & PureStandardEquations & "enddef;";
  % we want the |vardef| macro only defined locally;we don't need it later
  begingroup; 
    save code_function_;
    sc_(mac);
    % determine |.n|, |.s|, etc.:
    sc_ ("code_function_." & str n); 
  endgroup;
enddef;

% streamlined version: |n| is a number representing an object
vardef rebindrelative_Obj(expr n)(expr dyn,dys,dxe,dxw)=
  hide(rebindrelativeObj(obj(iname_[n]))(dyn,dys,dxe,dxw)) n
enddef;

def rebindObj(suffix n)=
  rebindrelativeObj(n)(0,0,0,0);
enddef;

% streamlined version: |n| is a number representing an object
vardef rebind_Obj(expr n)=
  hide(rebindObj(obj(iname_[n]))) n
enddef;

% This function does an exact rebind, unlike the previous functions.
% It takes into account everything that is visible
vardef rebindVisibleObj(suffix n_)=
  save untied,p;boolean untied;path p;untied=true;
  if known n_.c:untied:=false;fi;
  if untied:n_.c=origin;fi;
  % first, we do a simple |rebindObj| to make sure
  % that the bounding box is parallel to the axes
  rebindObj(n_);
  save bboxmargin;
  bboxmargin:=0;
  p=rBboxObj(n_);
  rebindrelativeObj(n_)(
    ypart((point 2 of p)-n_.n),
    ypart((point 1 of p)-n_.s),
    xpart((point 1 of p)-n_.e),
    xpart((point 0 of p)-n_.w));
  if untied:untieObj(n_);fi;
enddef;

% It is often useful to set the size of an object, in order
% to get proper alignments. We provide several functions.
% These functions take a length and extend in one of the four
% directions until reaching this length. It is a straightforward
% application of |rebindrelativeObj|:

vardef extendObjRight@#(expr wd)=
  rebindrelativeObj(@#)(0,0,wd-xpart(@#e-@#w),0);
enddef;

vardef extendObjLeft@#(expr wd)=
  rebindrelativeObj(@#)(0,0,0,xpart(@#e-@#w)-wd);
enddef;

vardef extendObjUp@#(expr ht)=
  rebindrelativeObj(@#)(ht-ypart(@#n-@#s),0,0,0);
enddef;

vardef extendObjDown@#(expr ht)=
  rebindrelativeObj(@#)(0,ypart(@#n-@#s)-ht,0,0);
enddef;

% Handling of options in constructors:

% Options are added as optional text parameters at the end of constructors.
% The options are normally strings representing function calls
% with parameters. Several options can be separated by commas.
% Each object honors its own options.
% Non honored options produce errors.

% It is up to the object to decide if it takes options and if it
% handles them. Options are handled by a generic |ExecuteOptions| call.
% This function defines variables according to the options given.
% Later, these variables can be used to achieve various effects.

% The |ExecuteOptions| definition must not be a |vardef|
% because some of the options
% (for instance |o_treemode|) do |save|s and the scope of
% these |save|s must be the whole constructor.
% |$$| is the object; we need it in order to define |currentObjname|
% which is used by certain options. However, local options
% (the ones only used in the constructor) do not use the object name.
def ExecuteOptions(suffix $$)(text options)=
  % we don't need a |vardef| here,
  % because |ExecuteOptions| is called within a |vardef|
  setcurrentobjname_(str $$);
  for $:=options:
    % each option is a function call, so we just call it;
    % if the function called does not exist, it will of course
    % produce an error, but this error can clearly be diagnosed.
    % We call the function |correctOption_| in order to add
    % quotes in certain cases.
    sc_ (correctOption_("o_" & $));
  endfor;
enddef;

% Here are the functions that can be called; new functions can
% easily be added to handle more parameters.

def set_local_type(expr type,name,val)=
  sc_("save o_" & name & "_val;" &
             type & " o_" & name & "_val;o_" & name & "_val")=val;
enddef;

% For every option name |s|, this function defines a function |o_s|
% and calls |addOptionFunction| if the type is |"string"|.
% This call registers the option so that
% its arguments is protected.

vardef define_local_type_option(expr type,s)=
  save tmp;
  string tmp;
  tmp="def o_" & s & "(expr s)=";
  if s="arrows":
    tmp:=tmp & "set_local_type(" & quote(type) & "," & quote(s) &
               ",arrows_function_(s));enddef;";
  else:   
    tmp:=tmp &
      "set_local_type(" & quote(type) & "," & quote(s) & ",s);enddef;";
  fi;
  if type="string":
    tmp:=tmp & "addOptionFunction(" & quote("o_" & s) & ");";
  fi;
  sc_ tmp;
enddef;

def define_local_string_option(expr s)=
  define_local_type_option("string",s);
enddef;

def define_local_numeric_option(expr s)=
  define_local_type_option("numeric",s);
enddef;

def define_local_pair_option(expr s)=
  define_local_type_option("pair",s);
enddef;

def define_local_color_option(expr s)=
  define_local_type_option("color",s);
enddef;

def define_local_boolean_option(expr s)=
  define_local_type_option("boolean",s);
enddef;

def define_local_picture_option(expr s)=
  define_local_type_option("picture",s);
enddef;

def settodefaultifnotknown_(expr opname)(text type)(expr default)=
  if expandafter unknown sc_("o_" & opname & "_val"):
    expandafter save sc_("o_" & opname & "_val");
    expandafter type sc_("o_" & opname & "_val");
    sc_("o_" & opname & "_val")=default;
  fi;
enddef;
  
% Alignment option; the string version of the parameter is put
% into the current object |option_align_| field.
% This definition must not be a |vardef| because
% the scope of the |save| is the whole constructor.
define_local_string_option("align");

define_local_string_option("Dalign");
define_local_string_option("Ualign");
define_local_string_option("Lalign");
define_local_string_option("Ralign");

vardef define_global_type_option(expr type,opname)=
  save tmp;string tmp;
  tmp="def o_" & opname & "(expr s)=" &
          "global_" & type & "_option_(" & ditto & opname & ditto &
            ")(s);enddef;";
  if type="string":
    tmp:=tmp &
       "addOptionFunction(" & ditto & "o_" & opname & ditto & ");";
  fi;
  sc_(tmp);
enddef;

def define_global_string_option(expr opname)=
  define_global_type_option("string",opname);
enddef;

def define_global_boolean_option(expr opname)=
  define_global_type_option("boolean",opname);
enddef;

def define_global_color_option(expr opname)=
  define_global_type_option("color",opname);
enddef;

def define_global_numeric_option(expr opname)=
  define_global_type_option("numeric",opname);
enddef;

def define_global_pair_option(expr opname)=
  define_global_type_option("pair",opname);
enddef;

% The parameter of |halign| or |valign|
% is a list of alignment options, for instance |"clrccl"|
% It is used for matrix columns.

define_global_string_option("halign");
define_global_string_option("valign");

% Filling option; the parameter is put
% into the current object |option_filled_| field for later use.
define_global_boolean_option("filled");

% Color filling option
define_global_color_option("fillcolor");

% Framing options.
define_global_boolean_option("framed");
define_global_color_option("framecolor");
define_global_string_option("framestyle");

% Picture option
define_global_color_option("picturecolor");

% Shadow options
define_global_boolean_option("shadow");
define_global_color_option("shadowcolor");

% Fitting option. Usually, the default is for a frame to fit
% its contents. This options makes it possible to have regular frames
% around objects that have different widths and heights.
define_global_boolean_option("fit");

% Tree direction option.
% This definition must not be a |vardef| because
% the scope of the |save| is the whole constructor.
% The name |treemode| was chosen for compatibility with PSTricks.
define_global_string_option("treemode");

% PSTricks compatibility:
% This corresponds to PSTricks |treenodesize|;
% we took a different name, because we have two variants:
define_local_numeric_option("treenodehsize");
define_local_numeric_option("treenodevsize");

define_local_numeric_option("matrixnodehsize");
define_local_numeric_option("matrixnodevsize");

% |HBox| and |VBox| versions of the |"treenodehsize"|/|"treenodevsize"| option:
define_local_numeric_option("elementsize");

define_local_boolean_option("flip");
define_local_boolean_option("treeflip");

define_local_boolean_option("hideleaves");

% draw functions for connections
define_local_string_option("cdraw");

% label for connections
define_local_picture_option("labpic");
define_local_numeric_option("labdist");



% This is a list of all the stored options of a path.
% This list is defined so that it is easy to loop
% over all options.
def pathoptions_=
  _draw_,_connect_,posA,posB,armA,armB,offsetA,offsetB,
  name,linecolor,border,bordercolor,linestyle,doubleline,doublesep,
  arrows,angleA,angleB,arcangleA,arcangleB,curvemax,
  linewidth,nodesepA,nodesepB,
  loopsize,linearc,linetensionA,linetensionB,
  visible,boxsize,boxheight,boxdepth,pathfilled,pathfillcolor,
  coilarmA,coilarmB,coilheight,coilwidth,coilaspect,coilinc
enddef;
      
% default values for curves:
numeric curve_linewidth_default,
        curve_arcangleA_default,curve_arcangleB_default,
        curve_curvemax_default,
        curve_armA_default,curve_armB_default,curve_loopsize_default,
        curve_linetensionA_default,curve_linetensionB_default,
        curve_linearc_default,
        curve_border_default,curve_nodesepA_default,curve_nodesepB_default,
        curve_boxsize_default,curve_boxheight_default,curve_boxdepth_default,
        curve_doublesep_default,
        curve_coilarmA_default,curve_coilarmB_default,
        curve_coilheight_default,curve_coilwidth_default,
        curve_coilaspect_default,curve_coilinc_default;
% default values for curves (non stored options)
numeric curve_labpos_default,curve_labangle_default,curve_labdist_default;


curve_linewidth_default=.5bp;
curve_arcangleA_default=10;
curve_arcangleB_default=10;
curve_curvemax_default=1;
curve_armA_default=5mm;
curve_armB_default=5mm;
curve_loopsize_default=0.25cm;
curve_linearc_default=0cm;
curve_linetensionA_default=1;
curve_linetensionB_default=1;
curve_border_default=0pt;
curve_nodesepA_default=0pt;
curve_nodesepB_default=0pt;
curve_boxsize_default=5mm;
curve_boxheight_default=-1pt; % means that there is no default
curve_boxdepth_default=-1pt;  % means that there is no default
curve_doublesep_default=1pt;
curve_coilarmA_default=5mm;  % same as in PSTricks
curve_coilarmB_default=5mm;  % same as in PSTricks
curve_coilheight_default=1;  % same as in PSTricks
curve_coilwidth_default=1cm; % same as in PSTricks
curve_coilaspect_default=45; % same as in PSTricks
curve_coilinc_default=90; % 20 is better when |coilaspect|=0
 % (the PSTricks default is 10, but it seems unnecessary in most cases)

curve_labpos_default=0.5;
curve_labangle_default=0.0;
curve_labdist_default=1; % ratio

boolean curve_visible_default,curve_doubleline_default,
        curve_pathfilled_default;
curve_visible_default=true;
curve_doubleline_default=false;
curve_pathfilled_default=false;


color curve_linecolor_default,curve_bordercolor_default,
      curve_pathfillcolor_default;
curve_linecolor_default=black;
curve_bordercolor_default=white;
curve_pathfillcolor_default=black;

string curve_linestyle_default,curve_arrows_default,
       curve_posA_default,curve_posB_default;
pair curve_offsetA_default,curve_offsetB_default;       
curve_linestyle_default="";
curve_arrows_default="drawarrow";
curve_posA_default="ic";
curve_posB_default="ic";
curve_offsetA_default=(0,0);
curve_offsetB_default=(0,0);

% curve options shortcuts table
string curve_options_shortcuts_[];
numeric ncurve_options_shortcuts_;
ncurve_options_shortcuts_=0;

vardef isCurveOptionShortcut(expr opname)=
  save r;boolean r;r=false;
  hide(
    for i:=0 upto ncurve_options_shortcuts_-1:
      if curve_options_shortcuts_[i]=opname:r:=true;fi;
      exitif r;
    endfor;
    )
  r
enddef;

def setCurveDefaultOption(expr name,value)=
  if isCurveOptionShortcut(name):
    sc_("curve_" & name & "A_default"):=value;
    sc_("curve_" & name & "B_default"):=value;
  elseif name="arrows":
    sc_("curve_" & name & "_default"):=arrows_function_(value);
  else:
    sc_("curve_" & name & "_default"):=value;
  fi;
enddef;

% For all options for which there are two versions (A and B),
% we define special shortcuts, as does PSTricks.
% We also memorize the shortcuts, because they are needed in
% |setCurveDefaultOption|.

def define_path_option_shortcut(expr s)=
  scantokens("def o_" & s &
      "( expr l)=o_" & s & "A(l);o_" & s & "B(l);enddef;");
  curve_options_shortcuts_[ncurve_options_shortcuts_]=s;
  ncurve_options_shortcuts_:=ncurve_options_shortcuts_+1;
enddef;

define_path_option_shortcut("linetension");
define_path_option_shortcut("coilarm");
define_path_option_shortcut("pos");
define_path_option_shortcut("offset");
define_path_option_shortcut("arm");
define_path_option_shortcut("angle");
define_path_option_shortcut("arcangle");
define_path_option_shortcut("nodesep");

% Arrows functions: these functions should be similar to |draw|.
% They can be parameters to the |"arrows"| option.

def rdrawarrow = drawarrow reverse enddef;

% This is the default value for connections.
% |p| is a path to be drawn.
% |n| is a suffix for an array of stored parameters
% |i| is the index in this array
% If the suffix is empty, we use locally stored values.
vardef cdraw_default(suffix n)(expr i)(expr p)=
  save colorcmd,p_;string colorcmd;path p_;colorcmd="";
  p_=p;
  p_:=cutpathends_(p_,if known o_nodesepB_val: o_nodesepB_val
                      else: curve_nodesepB_default fi,
                      if known o_nodesepA_val: o_nodesepA_val
                      else: curve_nodesepA_default fi);
  if str n="":
    if CLOV_("border")>0:
      pickup pencircle scaled CLOV_("border");
      % we cut the ends of the path in order to avoid
      % the end nodes to be erased; the standard setting
      % should work in most cases, except when the path
      % reaches the node under a small angle; we should then
      % add options to define how much of the path we cut.
      draw cutpathends_(p,2*CLOV_("border"),2*CLOV_("border"))
              withcolor CLOV_("bordercolor");
    fi;
    pickup pencircle scaled CLOV_("linewidth");
    if CLOV_("linecolor")<>black:
      colorcmd:="withcolor " & colortostring(CLOV_("linecolor"));
    fi;
    if CLOV_("doubleline"):
      sc_(CLOV_("arrows") & "_double")
      (p_)(CLOV_("doublesep"))(CLOV_("linewidth"))
      sc_(CLOV_("linestyle"))
      sc_(colorcmd);
    else:
      sc_(CLOV_("arrows"))
      (p_)
      sc_(CLOV_("linestyle"))
      sc_(colorcmd);
    fi;
  else:
    if n.border[i]>0:
      pickup pencircle scaled n.border[i];
      % we cut the ends of the path in order to avoid
      % the end nodes to be erased; the standard setting
      % should work in most cases, except when the path
      % reaches the node under a small angle; we should then
      % add options to define how much of the path we cut.
      draw cutpathends_(p,2*n.border[i],2*n.border[i])
              withcolor n.bordercolor[i];
    fi;
    pickup pencircle scaled n.linewidth[i];
    if n.linecolor[i]<>black:
      colorcmd:="withcolor " & colortostring(n.linecolor[i]);
    fi;
    if n.doubleline[i]:
      sc_(n.arrows[i] & "_double")
      (p_)(n.doublesep[i])(n.linewidth[i])
      sc_(n.linestyle[i])
      sc_(colorcmd);
    else:
      sc_(n.arrows[i])
      (p_)
      sc_(n.linestyle[i])
      sc_(colorcmd);
    fi;
  fi;
  pickup pencircle scaled curve_linewidth_default;
enddef;

% color for connections
% We don't name it |color|, because at some point we would need
% to do a |sc_("color")| which would fail.
define_local_color_option("linecolor");

% border color (PSTricks compatibility)
define_local_color_option("bordercolor");

% size of border (PSTricks compatibility)
define_local_numeric_option("border");

% option for the path array |_path_|; this option makes
% it possible to use a different array with |nccurve| and similar
% functions.
define_local_string_option("patharray");

% connections within trees
define_global_string_option("edge");

% fan options:
define_global_string_option("fanlinestyle");

define_global_boolean_option("pointedfan");
define_global_numeric_option("fanlinearc");

% angles for connections (PSTricks compatibility)
define_local_numeric_option("angleA");
define_local_numeric_option("angleB");
define_local_numeric_option("arcangleA");
define_local_numeric_option("arcangleB");

% separations for connections (PSTricks compatibility)
define_local_numeric_option("nodesepA");
define_local_numeric_option("nodesepB");

% parameters for |ncbox| and |ncarcbox|: size of boxes (PSTricks compatibility)
define_local_numeric_option("boxsize");
define_local_numeric_option("boxheight");
define_local_numeric_option("boxdepth");

% parameter for |ncloop|
define_local_numeric_option("loopsize");

% smoothness of connections
define_local_numeric_option("linearc");

% coil/zigzag connections:
define_local_numeric_option("coilarmA");
define_local_numeric_option("coilarmB");
define_local_numeric_option("coilheight");
define_local_numeric_option("coilwidth");
define_local_numeric_option("coilaspect");
define_local_numeric_option("coilinc");

% visibility of connections
% (a connection can be invisible and be used for other purposes,
% such as label positionning or computation of intersections)
define_local_boolean_option("visible");

define_local_boolean_option("pathfilled");
define_local_color_option("pathfillcolor");

% tensions of connection (only |nccurve|)
define_local_numeric_option("linetensionA");
define_local_numeric_option("linetensionB");

% maximum distance for loops produced by nccurve
define_local_numeric_option("curvemax"); % added Nov 10, 2006

% thickness for connections
define_local_numeric_option("linewidth");

% style for connections 
define_local_string_option("linestyle");

% double lines:
define_local_boolean_option("doubleline");
define_local_numeric_option("doublesep");


% positions for connections
define_local_string_option("posA");
define_local_string_option("posB");

% offsets for connections
define_local_pair_option("offsetA");
define_local_pair_option("offsetB");

% arms for connections
define_local_numeric_option("armA");
define_local_numeric_option("armB");

% names for connections
define_local_string_option("name");

% Label options:
define_local_numeric_option("labrotate");
define_local_numeric_option("labangle");
define_local_numeric_option("labpos");
define_local_pair_option("labshift");
% this is like the labshift option, but will use the
% |laboff| definition used by |label|
define_local_string_option("labdir");
define_local_color_option("labcolor");
define_local_boolean_option("laberase");
define_local_string_option("labpoint");
define_local_string_option("labcard");
define_local_string_option("labpathname");
define_local_numeric_option("labpathid");


% Internal horizontal separation.
define_local_numeric_option("hsep");

% Internal vertical separation.
define_local_numeric_option("vsep");

define_local_numeric_option("hbsep");
define_local_numeric_option("vbsep");

% External horizontal separation
define_local_numeric_option("dx");

% External vertical separation
define_local_numeric_option("dy");

% Rotation angle
define_local_numeric_option("rotangle");

% How much the start of a line is shifted right
define_local_numeric_option("lstartdx");

% How much the end of a line is shifted right
define_local_numeric_option("lenddx");

define_global_numeric_option("rule");
define_local_numeric_option("lrsep");
define_local_numeric_option("rrsep");

% Line width for draws
define_global_numeric_option("framewidth");

% radius for corners of rounded corners
define_global_numeric_option("rbox_radius");

% Circle margin
define_local_numeric_option("circmargin");

% Polygon margin
define_local_numeric_option("polymargin");

define_local_numeric_option("angle");

% Draw arrow function option;
% the parameter is a string representing a draw function
% We first define a conversion function:

def arrows_function_(expr s)=
  if ((substring(0,1) of s >= "A") and (substring(0,1) of s <= "Z")) or
    ((substring(0,1) of s >= "a") and (substring(0,1) of s <= "z")):
    s
  elseif s="-": "draw"
  elseif s="->": "drawarrow"
  elseif s="<-": "rdrawarrow"
    % other cases can easily be added here
  else: "draw" % default
  fi
enddef;

define_local_string_option("arrows");

% This is an option to locally redefine the main drawing function
% of the object.
define_global_string_option("drawObj");

def global_option_(expr name)(expr s)=
  global_string_option_(name)(s);
enddef;

def global_boolean_option_(expr name)(expr s)=
  global_type_option_("boolean")(name)(s);
enddef;

def global_string_option_(expr name)(expr s)=
  global_type_option_("string")(name)(s);
enddef;

def global_numeric_option_(expr name)(expr s)=
  global_type_option_("numeric")(name)(s);
enddef;

def global_color_option_(expr name)(expr s)=
  global_type_option_("color")(name)(s);
enddef;

% This is for options that are attached to an object,
% and that are not local only to its constructor.
def global_type_option_(expr type)(expr name)(expr s)=
  if not isOfType(type,currentObjname & ".option_" & name & "_"):
    sc_(type)
       obj(generisize_(currentObjname)).sc_("option_" & name & "_");
  fi;
  if not string obj(currentObjname).options_:
    expandafter string obj(generisize_(currentObjname)).options_;
  fi;
  if unknown obj(currentObjname).options_:
    obj(currentObjname).options_="_" & name;
         % we added a |_| so that the tag becomes unknown
         % for we can then traverse the |options_| with a |forsuffixes|
         % in |duplicateObj|
         % (we should make this more robust)
  else:
    obj(currentObjname).options_:=obj(currentObjname).options_& ",_" & name;
  fi;
  obj(currentObjname).sc_("option_" & name & "_")=s;
enddef;

% This is a general function to test options:
% |@#| is the object name. |opname| is the option name
% and |opvalue| is the option value.

vardef Option@#(expr opname,opvalue)=
  (OptionValue@#(opname)=opvalue)
enddef;

% This function finds the value of a parameter for an object.
% An option is either stored in the object (when it is local, but meant
% to be used later, not in the constructor),
% or local in the object, but for an immediate use (i.e., it won't be
% available after the creation), or global to the class.
% In the first case, we check the variable
%   |@#sc_("option_" & opname & "_")|
%    (the type of the option is irrelevant here)
% In the second case, we check |sc_("o_" & opname & "_val")|
%    (the type of the option is irrelevant here)
% In the third case, we check the global value
%   |sc_(clname & "_" opname)|
%    (the type of the option is irrelevant here)
vardef OptionValue@#(expr opname)=
  (if known (@#sc_("option_" & opname & "_")):
      (@#sc_("option_" & opname & "_"))
   elseif known (sc_("o_" & opname & "_val")):
     (sc_("o_" & opname & "_val"))
   elseif known (sc_(objClassName_(@#) & "_" & opname)):
     (sc_(objClassName_(@#) & "_" & opname))
   else:
     whatever
   fi
  )
enddef;

% This function only looks at local options and does not
% take an object into account. It is suitable for the options
% of a draw command. Moreover, the last parameter is a default
% value.
vardef LocalOptionValue(expr opname,default)=
  (if known (sc_("o_" & opname & "_val")):
    (sc_("o_" & opname & "_val"))
   else:
     default
   fi
  )
enddef;

% Constructions such as |LocalOptionValue("posA",curve_posA_default)|
% are quite common. We therefore introduce a shortcut:
def CLOV_(expr opname)=
  sc_("LocalOptionValue(" &
       quote(opname) & ",curve_" & opname & "_default)")
enddef;

% This function defines default global values for classes.
% This works for numerical, string or color values.
% |setObjectDefaultOption("HBox")("hsep")(5mm)|
def setObjectDefaultOption(expr clname)(expr var)(expr val)=
  if numeric val:
    sc_(clname & "_" & var):=val;
  elseif string val:
    sc_("string " & clname & "_" & var & ";");
    sc_(clname & "_" & var):=val;
  elseif color val:
    sc_("color " & clname & "_" & var & ";");
    sc_(clname & "_" & var):=val;
  elseif boolean val:
    sc_("boolean " & clname & "_" & var & ";");
    sc_(clname & "_" & var):=val;
  fi;
enddef;

% |clearObj a,b| makes it possible to reuse the objects |a| and |b|
% If this function is called within |beginfig|/|endfig|, it only
% clears the object until the end of the environment.
let clearObj=save;

let showObj=showvariable;

% n is the number of an object
def show_Obj(expr n)=
  sc_("showObj " & iname_[n]);
enddef;


% Handling of paths in objects:

% This function adds a point to an object's point array.
% |p| is the point and |a| is the array of object |@#|.
% This function is used when a path is attached to an object.
vardef addPointToArray@#(expr p)(suffix a)=
  @#a.n_:=@#a.n_+1;
  @#a[@#a.n_]:=p;
  % The relative position of the point is memorized as an equation,
  % so that we can conveniently reset the object later, and not loose
  % the points.
  addObjExtraCode@# "@#" & str a & decimal(@#a.n_) & "-@#c=(" &
    decimal(xpart(p-@#c)) & "," & decimal(ypart(p-@#c)) & ");";
  if @#points_in_arrayslist_="":
    @#points_in_arrayslist_:=str a & decimal(@#a.n_);
  else:
    @#points_in_arrayslist_:=@#points_in_arrayslist_ & "," & str a & decimal(@#a.n_);
  fi;
enddef;

def cutpathends_(expr p,a,b)=
  if (a=0) and (b=0):p
  else:
    p cutafter (p intersectionpoint
                  (fullcircle scaled a shifted (point (length(p)) of p)))
      cutbefore (p intersectionpoint
        (fullcircle scaled b shifted (point 0 of p)))
  fi
enddef;


% This function adds a path to an object.
% The path is |p| and the object is |@#|.
% |n| is the name of the path within the object.
% It must have been defined with |addPathArray|.
vardef addPath@#(suffix n)(expr i)(text p)=
  save p_,untied;path p_;boolean untied;untied=true;
  % n is _spath_ or _upath_
  if known @#c:untied:=false;fi;
  % we temporarily tie the object if necessary
  if untied:@#c=origin;fi;
  % only then can we store the path:
  p_=p;
  % Now, we slightly modify the path in order to take the |nodesepA|
  % and |nodesepB| parameters into account:
  p_:=cutpathends_(p_,if known o_nodesepB_val: o_nodesepB_val
                      else: curve_nodesepB_default fi,
                      if known o_nodesepA_val: o_nodesepA_val
                      else: curve_nodesepA_default fi);
  setcurrentobjname_(str @#);
  % if the |ip_| array does not yet exist, create it:
  if not pair @#n.ip_1:       
    ObjPointArray(n.ip_)(0);
  else:
    % if it does already exist, we only initialize it once:
    if unknown @#n.ip_.n_:
      ObjPointArray(n.ip_)(0);
    fi;    
  fi;
  xpart(@#n[i])=@#n.ip_.n_+1; % path number
  % we add each point of the path |p_| to the |ip_| array:
  for j:=0 upto length p_-1:
    addPointToArray@#(point j of p_)(n.ip_);
    addPointToArray@#(postcontrol j of p_)(n.ip_);
    addPointToArray@#(precontrol (j+1) of p_)(n.ip_);
  endfor;
  addPointToArray@#(point (length(p_)) of p_)(n.ip_);
  ypart(@#n[i])=length p_;
  % if the object was initially untied, we untie it
  if untied:untieObj(@#);fi;
enddef;

% This function removes the paths from an array:
vardef deletePaths@#(suffix n)=
  @#extra_code_:="";
  for i:=1 upto @#n.ip_.n_:
    @#n[i]:=(whatever,whatever);
  endfor;
  % reset |ip_|
  @#n.ip_.n_:=0;
  % remove |ip_1|, ... from |points_in_arrayslist|:
  save newpoints_in_arrayslist_;
  string newpoints_in_arrayslist_;newpoints_in_arrayslist_:="";
  forsuffixes $:=sc_(@#points_in_arrayslist_):
    if (substring(0,length(str n & ".ip_")) of (str$))<>(str n & ".ip_"):
      if newpoints_in_arrayslist_="":
        newpoints_in_arrayslist_:=str$;
      else:
        newpoints_in_arrayslist_:=newpoints_in_arrayslist_ & "," & str$;
      fi;
    fi;
  endfor;
  @#points_in_arrayslist_:=newpoints_in_arrayslist_;
  message "@#points_in_arrayslist_=" & @#points_in_arrayslist_;
enddef;

% This function defines an array of paths within an object.
% |p| is the array name, |n| the size of the array
% and |@#| is the object.
vardef addPathArray@#(suffix p)(expr n)=
  setcurrentobjname_(str @#);
  ObjPairArray(p)(n);
enddef;

vardef addPathVariables@#(suffix p)=
  setcurrentobjname_(str @#);
  addPathArray@#(p)(0); % this is a standard array for paths added to
                        % an object
  forsuffixes $=_draw_,_connect_,posA,posB,name,linestyle,arrows:
    ObjStringArray(p$)(0);
  endfor;
  forsuffixes $=angleA,angleB,arcangleA,arcangleB,nodesepA,nodesepB,
    loopsize,linearc,linetensionA,linetensionB,linewidth,
    armA,armB,border,boxsize,boxheight,boxdepth,
    doublesep,coilarmA,coilarmB,coilheight,coilwidth,coilaspect,coilinc:
    ObjNumericArray(p$)(0);
  endfor;
  ObjBooleanArray(p.visible)(0);
  ObjBooleanArray(p.pathfilled)(0);
  ObjColorArray(p.pathfillcolor)(0);
  ObjBooleanArray(p.doubleline)(0);
  ObjPairArray(p.offsetA)(0);
  ObjPairArray(p.offsetB)(0);
  ObjColorArray(p.linecolor)(0);
  ObjColorArray(p.bordercolor)(0);
enddef;

def increment_pathparameters_(suffix p)(suffix $)=
  $p.n_:=$p.n_+1;
  $p._draw_[$p.n_]:=LocalOptionValue("cdraw","cdraw_default");
  $p.visible[$p.n_]:=CLOV_("visible");
  $p.pathfilled[$p.n_]:=CLOV_("pathfilled");
  $p.pathfillcolor[$p.n_]:=CLOV_("pathfillcolor");
  $p.border[$p.n_]:=CLOV_("border");
  $p.bordercolor[$p.n_]:=CLOV_("bordercolor");
  $p.linewidth[$p.n_]:=CLOV_("linewidth");
  $p.linecolor[$p.n_]:=CLOV_("linecolor");
  $p.nodesepA[$p.n_]:=CLOV_("nodesepA");
  $p.nodesepB[$p.n_]:=CLOV_("nodesepA");
  $p.arrows[$p.n_]:=CLOV_("arrows");
  $p.linestyle[$p.n_]:=CLOV_("linestyle");
  $p.doubleline[$p.n_]:=CLOV_("doubleline");
  forsuffixes $$=_draw_,visible,border,bordercolor,linewidth,linecolor,
    arrows,linestyle,nodesepA,nodesepB,doubleline,pathfilled,pathfillcolor:
    $p$$n_:=$p.n_;
  endfor;
enddef;
  
% This is a function simplifying the use of |addPath|
vardef addUserPath@#(text p) text options=
  ExecuteOptions()(options);
  if unknown @#_upath_.n_:
    addPathVariables@#(_upath_);
  fi;
  increment_pathparameters_(_upath_)(@#);
  addPath@#(_upath_,@#_upath_.n_,p);
enddef;

vardef addStandardPath@#(text p) text options=
  ExecuteOptions()(options);
  if unknown @#_spath_.n_:
    addPathVariables@#(_spath_);
  fi;
  increment_pathparameters_(_spath_)(@#);
  addPath@#(_spath_,@#_spath_.n_,p);
enddef;

def ObjPath(text p) text options=
  addStandardPath.sc_(currentObjname)(p) options;
enddef;
  
% The |Path| function reconstructs a path from a path |p[j]|
% and an object reference |@#|.
vardef Path@#(suffix p)(expr j)=
  (
    for i:=0 upto ypart(@#p[j])-1:
      @#p.ip_[xpart(@#p[j])+i*3]..
          controls @#p.ip_[xpart(@#p[j])+i*3+1] and
                   @#p.ip_[xpart(@#p[j])+i*3+2]..
      endfor
      @#p.ip_[xpart(@#p[j])+ypart(@#p[j])*3]
  )
enddef;

% The |drawMemorizedPaths_| function draws paths that have been memorized.
% It must be called explicitely in the draw function of an object.
% It uses the value of the |cdraw| option to draw the memorized path.
% This makes it possible to change the color, the style, etc.
% There are two kinds of paths attached to an object: the standard ones,
% in the |_spath_| array, and the user ones in the |_upath_| array.
% For instance, the standard paths of a tree are the connections between
% the root and the subtrees.
def drawMemorizedPaths_(suffix n)=
  forsuffixes $=_spath_,_upath_:
    if known n$n_:
      for i:=1 upto n$n_:
        % fans are not drawn here
        if n$arrows[i]<>"fandraw":
          if n$visible[i]:
            if n$pathfilled[i]:
              fill Path.n($,i)--cycle withcolor n$pathfillcolor[i];
            fi;
            sc_(n$_draw_[i])(n$)(i)(Path.n($,i));
          fi;
        fi;
      endfor;
    fi;
  endfor;
enddef;

% The following function is useful for classes which contain
% an object or a picture:
def StandardObjectOrPictureContainerSetup(expr v)=
  if (picture v) or (string v):
    ObjPoint p.off;
    ObjPicture p;
    if picture v:
      setPicture(p)(v);  % initialize the picture
    elseif string v:
      if v="":
        setPicture(p)(nullpicture);
      else:
        % borrowed from |boxes.mp|
        setPicture(p)(v infont defaultfont scaled defaultscale);
      fi;
    fi;
  elseif numeric v:
    SubObject(sub,Obj(v));
  else:
    errmessage "Parameter of StandardObjectOrPictureContainerSetup should be picture, a string or an object.";
  fi;
  ObjNumeric a,b;
  (obj(currentObjname)a,obj(currentObjname)b) =
    if numeric v: % object
        .5*(obj(obj(currentObjname)sub)ne-obj(obj(currentObjname)sub)sw)
    elseif (picture v) or (string v): 
       .5*(urcorner obj(currentObjname)p - llcorner obj(currentObjname)p)
    fi;
enddef;

def drawPictureOrObject(suffix n)=
  if known n.p:
    if urcorner(n.p)-llcorner(n.p)<>(0,0):
      drawPicture.n(p);
    fi;
  else:
    drawObj(obj(n.sub));
  fi;
enddef;

% Node connections:

def patharray_suffix_=
  sc_(LocalOptionValue("patharray","_upath_"))
enddef;

def sign_(expr n)=
  if n>=0:1 else:-1 fi
enddef;

% This function is used when certain paths have to be smoothed
% |p| is the path and |r| is the radius used where a sharp edge
% is rounded.
vardef smoothen(expr p,r)=
  save q,qq,anglechange;path q;pair qq[];
  hide(
    if r>0:
      q=point 0 of p;
      for i:=1 upto length(p)-1:
        qq0:=(whatever,whatever);qq1:=(whatever,whatever);
        qq2:=(whatever,whatever);qq3:=(whatever,whatever);
        if (point (i+1) of p=point i of p) or
           (point (i-1) of p=point i of p):
          anglechange:=0;
        else:
          anglechange:=angle(point (i+1) of p-point i of p)
                      -angle(point i of p-point (i-1) of p);
        fi;
        if anglechange>180: anglechange:=anglechange-360;fi;
        if anglechange<-180: anglechange:=anglechange+360;fi;
        if abs(anglechange)>1:
          % first, we compute the center of the arc
          qq0=whatever[point (i-1) of p,point i of p]
              +r*dir(angle(point i of p-point (i-1) of p)
                     +sign_(anglechange)*90)
             =whatever[point i of p,point (i+1) of p]
              +r*dir(angle(point (i+1) of p-point i of p)
                +sign_(anglechange)*90);
          % |qq1| and |qq2| are the points where the arc touches
          % the original curve
          qq1=whatever[point (i-1) of p,point i of p]
             =whatever[qq0,qq0+(point i of p-point (i-1) of p) rotated 90];
          qq2=whatever[point i of p,point (i+1) of p]
             =whatever[qq0,qq0+(point (i+1) of p-point i of p) rotated 90];
          qq3=qq0+r*unitvector(qq1+qq2-2qq0);
          q:=q & ((point (length(q)) of q)--qq1..
                   qq3..{point (i+1) of p-point i of p}qq2);
        else:
          q:=q & (point (length(q)) of q--point i of p);
        fi;
      endfor;
      q:=q & (point (length(q)) of q--point (length(p)) of p);
    else:
      q:=p;
    fi;
  )
  q
enddef;

% Generic part in the handling of node connections.
% |vardef| can't be used
% The object is |$| (if there is no object, |$| is empty)
% |n| and |m| are either objects (if they are numerics) or points
% (if they are pairs)
def nc_(suffix $)(suffix n,m)(expr f) text options =
  % this next line is actually only relevant when |$| is non-empty;
  % but if it is empty, the line is harmless.
  o_patharray("_upath_");
  % The first parameter is not used, because we have only local options
  % (non-local options have only a meaning for object constructors)
  ExecuteOptions()(options);
  nc__($)(n,m)(f)(patharray_suffix_);
enddef;

% The object is |$|
% |n| and |m| are either objects (if they are numerics) or points
% (if they are pairs)
def nc__(suffix $)(suffix n,m)(expr f)(suffix p)=
  if str $ <> "":
    if unknown $p.n_:
      addPathVariables$(p);
    fi;
    $p.n_:=$p.n_+1;
    % the next four lines must occur before the variables get a value,
    % because we want to memorize the initial state
    $p.angleA[$p.n_]:=o_angleA_val;
    $p.angleB[$p.n_]:=o_angleB_val;
    $p.nodesepA[$p.n_]:=o_nodesepA_val;
    $p.nodesepB[$p.n_]:=o_nodesepB_val;
  fi;
  if unknown o_angleA_val:
    save o_angleA_val;numeric o_angleA_val;
    if known curve_angleA_default: % added 18 June 2006
      o_angleA_val=curve_angleA_default;
    else:     
      if numeric n:
	if m.sc_(CLOV_("posB"))-n.sc_(CLOV_("posA"))<>(0,0):
          o_angleA_val=
	    angle(m.sc_(CLOV_("posB"))-n.sc_(CLOV_("posA")));
	else:
	  o_angleA_val=0;
	fi;	
      else:
	if m-n<>(0,0):
          o_angleA_val=angle(m-n);
	else:
	  o_angleA_val=0;
	fi;	
      fi;
    fi;
  fi;
  if unknown o_angleB_val:
    save o_angleB_val;numeric o_angleB_val;
    if known curve_angleB_default: % added 18 June 2006
      o_angleB_val=curve_angleB_default;
    else:     
      if numeric n:
	if m.sc_(CLOV_("posB"))-n.sc_(CLOV_("posA"))<>(0,0):
          o_angleB_val=
	    angle(m.sc_(CLOV_("posB"))-n.sc_(CLOV_("posA")));
	else:
          o_angleB_val=0;
	fi;    
      else:
	if m-n<>(0,0):
          o_angleB_val=angle(m-n);
	else:
	  o_angleB_val=0;
	fi;	
      fi;
    fi;
  fi;

  settodefaultifnotknown_("nodesepA")(numeric)(curve_nodesepA_default);
  settodefaultifnotknown_("nodesepB")(numeric)(curve_nodesepB_default);
  if str $ <> "":
    $p._draw_[$p.n_]:=LocalOptionValue("cdraw","cdraw_default");
    $p._connect_[$p.n_]:=f;
    forsuffixes $$=posA,posB,armA,armB,loopsize,visible,
      linetensionA,linetensionB,
      arcangleA,arcangleB,offsetA,offsetB,linewidth,linecolor,border,
      bordercolor,linestyle,arrows,boxsize,boxheight,boxdepth,
      doubleline,doublesep,pathfilled,pathfillcolor:
      $p$$[$p.n_]:=CLOV_(str $$);
    endfor;
    $p.name[$p.n_]:=LocalOptionValue("name","");
    nc_inc_$(p);
  fi;
enddef;


% Increment the size of the option arrays
vardef nc_inc_@#(suffix p)=
  forsuffixes $:=pathoptions_:
    @#p$n_:=@#p$n_+1;
  endfor;
enddef;

% This macro draws a label on an immediate curve % ZZZZZZZZ
% (created Sep. 28, 2006)
vardef nc_label_(expr p)=
  if known o_labpic_val:
    if known o_labangle_val:
      o_labangle_val:=o_labangle_val
	+angle(direction (o_labpos_val*length(p)) of p);
      o_labpic_val:=o_labpic_val rotated o_labangle_val;
    fi;
    save shift_;pair shift_;
    shift_:=(0,0); % default
    if known o_labdir_val:
      shift_:=clabshift_*CLOV_("labdist");
    fi;
    label(o_labpic_val,
        (point (CLOV_("labpos")*length(p)) of p) shifted shift_);
  fi;	  
enddef;

% This is the main function that distinguishes if a curve is in
% or out of an object (that is, if it will follow the object or not),
% and if it links two objects or two points.
% (That makes four different combinations.)
% |pa| is the path connecting two objects
% |pb| is the path connecting two points
% |n| can be either an object (numeric) or a point (pair).
vardef nc_core_@#(suffix n)(suffix p)(text pa)(text pb)=

  if str @# <> "":
    % we are in an object (deferred curve)
    if numeric n:
      % @#p.n_ = path number
      addPath@#(p,@#p.n_,pa);
      if known o_labpic_val:
        ObjLabel@#(o_labpic_val) "labpathid(" & decimal(-@#p.n_) & ")"; %AAAAAA
	% in the above, labpos is already taken into account if set
      fi;
      
    else:
      addPath@#(p,@#p.n_,pb);
      if known o_labpic_val:
        ObjLabel@#(o_labpic_val) "labpathid(" & decimal(-@#p.n_) & ")"; %AAAAAA
	% in the above, labpos is already taken into account if set
      fi;      
    fi;
  else:
    % we are not in an object (immediate curve)
    % we draw the curve only if it is visible:
    if CLOV_("visible"):
      if numeric n:
        sc_(LocalOptionValue("cdraw","cdraw_default"))
          ()(0) % value irrelevant, but first parameter empty
          (pa);
	% if necessary, a label is drawn
	nc_label_(pa); % added Sep. 28, 2006
      else:
        sc_(LocalOptionValue("cdraw","cdraw_default"))
          ()(0) % value irrelevant, but first parameter empty
          (pb);
        % if necessary, a label is drawn 
	nc_label_(pb); % added Sep. 28, 2006
      fi;
    fi;
  fi;
enddef;

% This is like |nc_core_|, but the last two parameters of
% |nc_core_| are identical.
vardef nc_core_double_@#(suffix n)(suffix p)(text pa)=
  nc_core_@#(n)(p)(pa)(pa);
enddef;

vardef ncshort_@#(expr a,b)(text n)(text m)(text options)=
  if string n:
    save tmp;string tmp;
    tmp="(" & str @# & ")(" & nameToSuffixString_(n) & "," &
                              nameToSuffixString_(m) & ")";
    sc_(a & "_" & tmp)(b) options;
    sc_(b & "_" & tmp)(patharray_suffix_);
  else:
    sc_(a & "_")(@#)(n,m)(b) options;
    sc_(b & "_")(@#)(n,m)(patharray_suffix_);
  fi;
enddef;

def object_(suffix n)(expr s)=
  (n.sc_(CLOV_("pos" &s))+CLOV_("offset" & s))
enddef;

def objectpoint_(suffix n)(expr s)=
  (n+CLOV_("offset" & s))
enddef;

% This function is useful for matrices. It returns the object at
% a given coordinate pair in a matrix. It is used by functions such
% as |mcline|.
def matpos(suffix $)(expr p)=
  obj($sb[(xpart(p)-1)*$ny+ypart(p)])
enddef;

let mpos=matpos;

% This function is useful for trees. It returns the object at
% a given rank in a tree.
def treepos(suffix $)(expr n)=
  obj(obj($subt).sb[n])
enddef;

let tpos=treepos;

% |ntreepos| is a shorthand for embedded |treepos| calls
vardef ntreepos_(suffix O)(text l)=
  save list,first,result;string list,result;
  hide(
  first=0;list="";
  forsuffixes $=l:
    if first=0: first:=$;
    else:
      if list="":list:=str $;
      else:
        list:=list & "," & str $;
      fi;
    fi;    
  endfor;
  if list="":
    result="treepos(" & str O & ")(" & decimal(first) & ")";
  else:
    result="ntreepos(treepos(" & str O & ")(" & decimal(first) &
        "))(" & list & ")";
  fi;
  )
  result
enddef;

% we can't use a |vardef| where a suffix appears, so we split
% the |ntreepos| function in two parts.
def ntreepos(suffix O)(text l)=
  scantokens(ntreepos_(O)(l))
enddef;

def treeroot(suffix $)(text l)=
  if isTree(ntreepos($)(l)):
    obj(ntreepos($)(l)root)
  else:
    ntreepos($)(l)
  fi
enddef;

def setupobjectfunction(suffix n)=
  save f;
  if numeric n:
    let f=object_;
  else:
    let f=objectpoint_;
  fi;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs)
vardef nccurve@#(text n)(text m) text options =
  ncshort_@#("nc","nccurve")(n)(m)(options);
enddef;

% ``reverse'' |nccurve|
vardef rnccurve@#(text n)(text m) text options =
  ncshort_@#("nc","nccurve")(m)(n)(options);
enddef;

vardef nccurve_(suffix $)(suffix n,m)(suffix p)=
  if n=m: % case added Nov. 10, 2006
    nc_core_$(n)(p)
      (object_(n)("A"){dir(o_angleA_val)}
	..{dir(180+o_angleB_val)-dir(o_angleA_val)}
	   (object_(n)("A")+CLOV_("curvemax")*1cm
	      *dir(.5[o_angleA_val,180+o_angleB_val]))
        ..{dir(o_angleB_val)}object_(m)("B")
	cutbefore BpathObj(n) cutafter BpathObj(m))
      (objectpoint_(n)("A"){dir(o_angleA_val)}
        ..{dir(180+o_angleB_val)-dir(o_angleA_val)}
	   (object_(n)("A")+CLOV_("curvemax")*1cm
	      *dir(.5[o_angleA_val,180+o_angleB_val]))
        ..{dir(o_angleB_val)}objectpoint_(m)("B"));
  else:    
    nc_core_$(n)(p)
      (object_(n)("A"){dir(o_angleA_val)}
        ..tension CLOV_("linetensionA") and CLOV_("linetensionB")
        ..{dir(o_angleB_val)}object_(m)("B")
         cutbefore BpathObj(n) cutafter BpathObj(m))
      (objectpoint_(n)("A"){dir(o_angleA_val)}
        ..tension CLOV_("linetensionA") and CLOV_("linetensionB")
        ..{dir(o_angleB_val)}objectpoint_(m)("B"));
  fi;  
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mccurve@#(expr ai,aj,bi,bj) text options=
  nccurve@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tccurve@#(text ai)(text bi) text options=
  nccurve@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs)
vardef ncline@#(text n)(text m) text options =
  ncshort_@#("nc","ncline")(n)(m)(options);
enddef;

% ``reverse'' |ncline|
vardef rncline@#(text n)(text m) text options =
  ncshort_@#("nc","ncline")(m)(n)(options);
enddef;

vardef ncline_(suffix $)(suffix n,m)(suffix p)=
  nc_core_$(n)(p)
    (object_(n)("A")..object_(m)("B")
        cutbefore BpathObj(n) cutafter BpathObj(m))
    (objectpoint_(n)("A")..objectpoint_(m)("B"));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcline@#(expr ai,aj,bi,bj) text options=
  ncline@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcline@#(text ai)(text bi) text options=
  ncline@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs)
vardef ncarc@#(text n)(text m) text options =
  ncshort_@#("nc","ncarc")(n)(m)(options);
enddef;

% ``reverse'' |ncarc|
vardef rncarc@#(text n)(text m) text options =
  ncshort_@#("nc","ncarc")(m)(n)(options);
enddef;

vardef ncarc_(suffix $)(suffix n,m)(suffix p)=
  nc_core_$(n)(p)
    (object_(n)("A"){dir(o_angleA_val+CLOV_("arcangleA"))}
      ..{dir(o_angleB_val-CLOV_("arcangleB"))}object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m))
    (objectpoint_(n)("A"){dir(o_angleA_val+CLOV_("arcangleA"))}
        ..{dir(o_angleB_val-CLOV_("arcangleB"))}objectpoint_(m)("B"));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcarc@#(expr ai,aj,bi,bj) text options=
  ncarc@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcarc@#(text ai)(text bi) text options=
  ncarc@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncangle@#(text n)(text m) text options =
  ncshort_@#("nc","ncangle")(n)(m)(options);
enddef;

% ``reverse'' |ncangle|
vardef rncangle@#(text n)(text m) text options =
  ncshort_@#("nc","ncangle")(m)(n)(options);
enddef;

vardef ncangle_(suffix $)(suffix n,m)(suffix p)=
  % we have to find two additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap;pair ap[];
  setupobjectfunction(n);
  f(m)("B")-ap1=CLOV_("armB")*dir(CLOV_("angleB"));
  ap2=f(n)("A")+whatever*dir(CLOV_("angleA"));
  ap1=ap2+whatever*dir(CLOV_("angleA")+90);    
  nc_core_$(n)(p)
    (smoothen(object_(n)("A")--ap2--ap1--object_(m)("B")
           cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
    (smoothen(objectpoint_(n)("A")--ap2--ap1--objectpoint_(m)("B"))
         (CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcangle@#(expr ai,aj,bi,bj) text options=
  ncangle@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcangle@#(text ai)(text bi) text options=
  ncangle@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncangles@#(text n)(text m) text options =
  ncshort_@#("nc","ncangles")(n)(m)(options);
enddef;

% ``reverse'' |ncangles|
vardef rncangles@#(text n)(text m) text options =
  ncshort_@#("nc","ncangles")(m)(n)(options);
enddef;

vardef ncangles_(suffix $)(suffix n,m)(suffix p)=
  % we have to find additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap;pair ap[];
  setupobjectfunction(n);
  ap1-f(n)("A")=CLOV_("armA")*dir(CLOV_("angleA"));
  f(m)("B")-ap2=CLOV_("armB")*dir(CLOV_("angleB"));
  ap3=ap1+whatever*dir(CLOV_("angleA")+90);
  ap2=ap3+whatever*dir(CLOV_("angleA"));    
  nc_core_$(n)(p)
    (smoothen(object_(n)("A")--ap1--ap3--ap2--object_(m)("B")
           cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
    (smoothen(objectpoint_(n)("A")--ap1--ap3--ap2--objectpoint_(m)("B"))
         (CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcangles@#(expr ai,aj,bi,bj) text options=
  ncangles@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcangles@#(text ai)(text bi) text options=
  ncangles@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncdiag@#(text n)(text m) text options =
  ncshort_@#("nc","ncdiag")(n)(m)(options);
enddef;

% ``reverse'' |ncdiag|
vardef rncdiag@#(text n)(text m) text options =
  ncshort_@#("nc","ncdiag")(m)(n)(options);
enddef;

vardef ncdiag_(suffix $)(suffix n,m)(suffix p)=
  % we have to find two additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap;pair ap[];
  setupobjectfunction(n);
  ap1-f(n)("A")=CLOV_("armA")*dir(CLOV_("angleA"));
  f(m)("B")-ap2=CLOV_("armB")*dir(CLOV_("angleB"));
  nc_core_$(n)(p)
    (smoothen(object_(n)("A")--ap1--ap2--object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
    (smoothen(objectpoint_(n)("A")--ap1--ap2--objectpoint_(m)("B"))
       (CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcdiag@#(expr ai,aj,bi,bj) text options=
  ncdiag@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcdiag@#(text ai)(text bi) text options=
  ncdiag@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncdiagg@#(text n)(text m) text options =
  ncshort_@#("nc","ncdiagg")(n)(m)(options);
enddef;

% ``reverse'' |ncdiagg|
vardef rncdiagg@#(text n)(text m) text options =
  ncshort_@#("nc","ncdiagg")(m)(n)(options);
enddef;

vardef ncdiagg_(suffix $)(suffix n,m)(suffix p)=
  % we have to find an additional point; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap;pair ap;
  setupobjectfunction(n);
  ap-f(n)("A")=CLOV_("armA")*dir(CLOV_("angleA"));
  nc_core_$(n)(p)
    (smoothen(object_(n)("A")--ap--object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
    (smoothen(objectpoint_(n)("A")--ap--objectpoint_(m)("B"))
       (CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcdiagg@#(expr ai,aj,bi,bj) text options=
  ncdiagg@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcdiagg@#(text ai)(text bi) text options=
  ncdiagg@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncbar@#(text n)(text m) text options =
  ncshort_@#("nc","ncbar")(n)(m)(options);
enddef;

% ``reverse'' |ncbar|
vardef rncbar@#(text n)(text m) text options =
  ncshort_@#("nc","ncbar")(m)(n)(options);
enddef;

vardef ncbar_(suffix $)(suffix n,m)(suffix p)=
  % we have to find additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap,posap;pair ap[];numeric posap;
  setupobjectfunction(n);
  % we use different arms, but the same angles (see PSTricks documentation):
  ap1-f(n)("A")=CLOV_("armA")*dir(CLOV_("angleA"));
  ap2-f(m)("B")=CLOV_("armB")*dir(CLOV_("angleA")); 
  ap3=posap[f(n)("A"),ap1]=whatever[ap2,ap2+(ap2-f(m)("B")) rotated 90];
  ap4=whatever[f(m)("B"),ap2]=whatever[ap1,ap1+(ap1-f(n)("A")) rotated 90];
  if posap<1:
    ap5=ap1;ap6=ap4;
  else:
    ap5=ap3;ap6=ap2;
  fi;  
  nc_core_$(n)(p)
    (smoothen(object_(n)("A")--ap5--ap6--object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
    (smoothen(objectpoint_(n)("A")--ap5--ap6--objectpoint_(m)("B"))
       (CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcbar@#(expr ai,aj,bi,bj) text options=
  ncbar@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcbar@#(text ai)(text bi) text options=
  ncbar@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncloop@#(text n)(text m) text options =
  ncshort_@#("nc","ncloop")(n)(m)(options);
enddef;

% ``reverse'' |ncloop|
vardef rncloop@#(text n)(text m) text options =
  ncshort_@#("nc","ncloop")(m)(n)(options);
enddef;

vardef ncloop_(suffix $)(suffix n,m)(suffix p)=
  % we have to find additionnal points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap,posap;pair ap[];numeric posap;
  setupobjectfunction(n);
  ap1-f(n)("A")=CLOV_("armA")*dir(CLOV_("angleA"));
  f(m)("B")-ap2=CLOV_("armB")*dir(CLOV_("angleB")); 
  ap3-ap1=CLOV_("loopsize")*unitvector((ap1-f(n)("A")) rotated 90);
  ap4=whatever[ap3,ap3+(ap2-f(m)("B"))]
     =whatever[ap2,ap2+(ap2-f(m)("B")) rotated 90];
  nc_core_$(n)(p)
    (smoothen(object_(n)("A")--ap1--ap3--ap4--ap2--object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m))(CLOV_("linearc")))
    (smoothen(objectpoint_(n)("A")--ap1--ap3--ap4--ap2--objectpoint_(m)("B"))
       (CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcloop@#(expr ai,aj,bi,bj) text options=
  ncloop@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcloop@#(text ai)(text bi) text options=
  ncloop@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |firstpart| returns the time elapsed between the beginning of |p|
% and the point where the distance to the origin (on |p|) is |d|

def firstpart_(expr d,p)=
  arctime_(d/arclength(p),p)
enddef;

% Cut a path |p| in pieces of approximate arclength |d|
% (this is actually a macro I wrote in April 1995)
vardef divide_equally_(expr p,d)=
  save a,q,v;
  numeric a;
  path q,v;
  hide(
    v=p;
    q=point 0 of v;
    forever:
      a:=firstpart_(d,v);
      q:=q{direction 0 of v}..{direction a of v}(point a of v);
      exitif abs(a-length(v))<.1mm;
      v:=subpath(a,length(v)) of v;
    endfor;
  )
  q
enddef;

vardef zigzagit__(expr p)=
  save n,q,r,zz;path q,r;pair zz[];
  hide(
    n=floor(arclength(p)/(CLOV_("coilwidth")*CLOV_("coilheight"))+0.5);
    % we now divide |p| in |n| pieces  
    q=divide_equally_(p,arclength(p)/n);
    % here, we must now introduce additional points
    for i:=0 upto length(q)-1:
      zz[i*3]=point i of q;
      zz[i*3+1]=.25[point i of q,point (i+1) of q]
        +CLOV_("coilwidth")/2
         *(unitvector((point (i+1) of q)-(point i of q)) rotated 90);
      zz[i*3+2]=.75[point i of q,point (i+1) of q]
        +CLOV_("coilwidth")/2
         *(unitvector(point (i+1) of q-point i of q) rotated -90);
    endfor;
    zz[length(q)*3]=point (length(q)) of q;
    % when joining the points, we must take care not to introduce
    % additional angles, in case |p| was not a straight line
    r=zz[0]--zz[1] for i:=1 upto length(q)-1: -- zz[3*i-1]--zz[3*i+1] endfor
      --zz[3*(length(q)-1)+2]--zz[3*length(q)];
    )
  r
enddef;

% coil function
def coilf_(expr q,i)=
  (
  if i>0:
    (arcpoint (i/n,q)
      +((.5CLOV_("coilwidth")
            *(sind(frac(i)*360),
              2*newcoilheight*i
              +cosd(frac(i)*360)*sind(CLOV_("coilaspect"))))
        -(0,.5CLOV_("coilwidth")*sind(CLOV_("coilaspect"))+(i/n)*arclength(q)))
        rotated (angle(arcdirection (i/n,q))-90)
        )
  else:
      (arcpoint (0,q)
      +((.5CLOV_("coilwidth")
            *(0,sind(CLOV_("coilaspect"))))
        -(0,.5CLOV_("coilwidth")*sind(CLOV_("coilaspect"))))
        rotated (angle(arcdirection (0,q))-90)
        )  
  fi
  )
enddef;

vardef coilit__(expr p)=
  save n,q,newcoilheight;path q;
  hide(
    n=round(arclength(p)/(CLOV_("coilheight")*CLOV_("coilwidth")));
    % we slightly change the coilheight so that the coil
    % turns an integer number of times
    if n>0:
      newcoilheight=arclength(p)/n/CLOV_("coilwidth");
    fi;
    q=coilf_(p,0)
    for i:=1 upto n*(360/CLOV_("coilinc")):
      ..coilf_(p,i*(CLOV_("coilinc")/360))
    endfor;
  )
  q
enddef;

% This function takes two paths where the last point
% of the first path is the first point of the second path;
% it creates a path looking like |p--q|, but where the
% common point is not duplicated.
def combinepaths_(expr p,q)=
  ((subpath(0,length(p)-1) of p)..
    controls (postcontrol (length(p)-1) of p) and
    (precontrol length(p) of p) ..q)
enddef;

vardef zigcoil_(expr type,p)=
  save na,nb;
  hide(
    % first, we cut two ends at lengths |coilarmA| and |coilarmB|
    na=firstpart_(CLOV_("coilarmA"),p);
    nb=firstpart_(CLOV_("coilarmB"),reverse p);
  )
  % we merge three paths, but we take care that no double points are added;
  % the double points would make it difficult to smooth the curve afterwards
  combinepaths_(
    combinepaths_(subpath (0,na) of p,
                  scantokens(type)(subpath (na,length(p)-nb) of p)),
                  subpath (length(p)-nb,length(p)) of p)
enddef;

vardef zigzagit(expr p)=
  zigcoil_("zigzagit__",p)
enddef;

vardef coilit(expr p)=
  zigcoil_("coilit__",p)
enddef;

def frac(expr i)=
  (i-floor(i))
enddef;

% function giving the time with respect to arclength:
% arctime_ 0 of p=beginning
% arctime_ 1 of p=end
% 
vardef arctime_(expr i,p)=
  save t;
  hide(
    if i=0: t=0;
    elseif i=1: t=length(p);
    else:
      save d,min,max;
      d=i*arclength(p);
      min=0;max=length(p);
      forever:
        t:=(min+max)/2;
        if arclength(subpath(0,t) of p)<d:
          min:=t;
        else:
          max:=t;
        fi;
        exitif arclength(subpath(min,max) of p)<.1mm;
      endfor;
    fi;
    )
  t
enddef;

def arcpoint(expr i,p)=
  (point arctime_(i,p) of p)
enddef;

def arcdirection(expr i,p)=
  (direction arctime_(i,p) of p)
enddef;


% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef nccoil@#(text n)(text m) text options =
  ncshort_@#("nc","nccoil")(n)(m)(options);
enddef;

% ``reverse'' |nccoil|
vardef rnccoil@#(text n)(text m) text options =
  ncshort_@#("nc","nccoil")(m)(n)(options);
enddef;

vardef nccoil_(suffix $)(suffix n,m)(suffix p)=
  setupobjectfunction(n);
  nc_core_$(n)(p)
    (coilit(object_(n)("A"){dir(o_angleA_val)}
      ..tension CLOV_("linetensionA") and CLOV_("linetensionB")
      ..{dir(o_angleB_val)}object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m)))
    (coilit(objectpoint_(n)("A"){dir(o_angleA_val)}
      ..tension CLOV_("linetensionA") and CLOV_("linetensionB")
      ..{dir(o_angleB_val)}objectpoint_(m)("B")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mccoil@#(expr ai,aj,bi,bj) text options=
  nccoil@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tccoil@#(text ai)(text bi) text options=
  nccoil@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;


% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef nczigzag@#(text n)(text m) text options =
  ncshort_@#("nc","nczigzag")(n)(m)(options);
enddef;

% ``reverse'' |nczigzag|
vardef rnczigzag@#(text n)(text m) text options =
  ncshort_@#("nc","nczigzag")(m)(n)(options);
enddef;

vardef nczigzag_(suffix $)(suffix n,m)(suffix p)=
  setupobjectfunction(n);
  nc_core_$(n)(p)
    (smoothen(zigzagit(object_(n)("A"){dir(o_angleA_val)}
      ..tension CLOV_("linetensionA") and CLOV_("linetensionB")
      ..{dir(o_angleB_val)}object_(m)("B")
       cutbefore BpathObj(n) cutafter BpathObj(m)))(CLOV_("linearc")))
    (smoothen(zigzagit(objectpoint_(n)("A"){dir(o_angleA_val)}
      ..tension CLOV_("linetensionA") and CLOV_("linetensionB")
      ..{dir(o_angleB_val)}objectpoint_(m)("B")))(CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mczigzag@#(expr ai,aj,bi,bj) text options=
  nczigzag@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tczigzag@#(text ai)(text bi) text options=
  nczigzag@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;


% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncbox@#(text n)(text m) text options =
  ncshort_@#("nc","ncbox")(n)(m)("arrows(draw)",options);
enddef;

% ``reverse'' |ncbox|
vardef rncbox@#(text n)(text m) text options =
  ncshort_@#("nc","ncbox")(m)(n)("arrows(draw)",options);
enddef;

% Compute the |boxheight| parameter
def compute_boxh(expr boxs,boxh,boxd)=
  if boxh>=0: boxh
  elseif boxd>=0: (2*boxs-boxd) % boxsize is half the width,
                                % according to PSTricks' documentation
  else: boxs
  fi  
enddef;

% Compute the |boxdepth| parameter
def compute_boxd(expr boxs,boxh,boxd)=
  if boxd>=0: boxd
  elseif boxh>=0: (2*boxs-boxh) % boxsize is half the width,
                                % according to PSTricks' documentation
  else: boxs
  fi  
enddef;

vardef ncbox_(suffix $)(suffix n,m)(suffix p)=
  % we have to find additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap,boxh,boxd;pair ap[];
  setupobjectfunction(n);
  boxh=compute_boxh(CLOV_("boxsize"),CLOV_("boxheight"),CLOV_("boxdepth"));
  boxd=compute_boxd(CLOV_("boxsize"),CLOV_("boxheight"),CLOV_("boxdepth"));
  f(n)("A")-ap1=CLOV_("nodesepA")*unitvector(f(m)("B")-f(n)("A"));
  ap5-ap1=boxh*unitvector(dir(90+angle(f(m)("B")-f(n)("A"))));
  ap1-ap2=boxd*unitvector(dir(90+angle(f(m)("B")-f(n)("A"))));
  ap4-ap3=ap5-ap2;
  ap4-ap5=(CLOV_("nodesepA")
    +CLOV_("nodesepB")
    +arclength(f(n)("A")--f(m)("B")))*unitvector(f(m)("B")-f(n)("A"));
  % we set nodesepA and nodesepB to 0 because they are used with another
  % meaning in |addPath| (I am just following what PSTricks does.)
  o_nodesepA_val:=0;
  o_nodesepB_val:=0;
  nc_core_double_$(n)(p)
    (smoothen(ap1--ap2--ap3--ap4--ap5--ap1)(CLOV_("linearc")));
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcbox@#(expr ai,aj,bi,bj) text options=
  ncbox@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcbox@#(text ai)(text bi) text options=
  ncbox@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source subobject, |m| is the target.
% We also distinguish the case when |n| and |m| are objects
% and when they are points (numerics vs pairs).
vardef ncarcbox@#(text n)(text m) text options =
  ncshort_@#("nc","ncarcbox")(n)(m)("arrows(draw)",options);
enddef;

% ``reverse'' |ncarcbox|
vardef rncarcbox@#(text n)(text m) text options =
  ncshort_@#("nc","ncarcbox")(m)(n)("arrows(draw)",options);
enddef;

vardef ncarcbox_(suffix $)(suffix n,m)(suffix p)=
  % we have to find additional points; we must be careful
  % not to use assignments, because |n.c| and |m.c|
  % may be floating:
  save ap,boxh,boxd;pair ap[];
  setupobjectfunction(n);
  boxh=compute_boxh(CLOV_("boxsize"),CLOV_("boxheight"),CLOV_("boxdepth"));
  boxd=compute_boxd(CLOV_("boxsize"),CLOV_("boxheight"),CLOV_("boxdepth"));
  ap20=unitvector(dir(90+angle(f(m)("B")-f(n)("A"))+CLOV_("arcangleA")));
  ap21=-ap24=ap20 rotated -90;
  ap22=-ap25=ap21 rotated (-2*CLOV_("arcangleA"));
  ap23=ap20 rotated (-2*CLOV_("arcangleA"));
  ap1-f(n)("A")=boxh*ap20;
  f(n)("A")-ap2=boxd*ap20;
  ap5-f(m)("B")=boxh*ap23;
  f(m)("B")-ap4=boxd*ap23;
  ap1-ap11=ap2-ap12=ap21*CLOV_("nodesepA");
  ap15-ap5=ap14-ap4=ap22*CLOV_("nodesepB");
  if CLOV_("arcangleA")=0:
    % normally, one would use |ncbox| instead of |ncarcbox| in this case,
    % but we make sure it works anyway
    ap6=.5[ap1,ap5];
    ap3=.5[ap2,ap4];
  else:
    if abs(CLOV_("arcangleA"))=90:
      ap0=.5[ap1,ap5];
    else:
      ap0=whatever[ap1,ap2]=whatever[ap5,ap4];
    fi;
    ap6-ap0=(ap1-ap0) rotated (.5*(angle(ap5-ap0)-angle(ap1-ap0)));
    ap3-ap0=(ap2-ap0) rotated (.5*(angle(ap5-ap0)-angle(ap1-ap0)));
  fi;
  % we set nodesepA and nodesepB to 0 because they are used with another
  % meaning in |addPath| (I am just following what PSTricks does.)
  o_nodesepA_val:=0;
  o_nodesepB_val:=0;
  nc_core_double_$(n)(p)
    (ap11{ap21}..ap1{ap21}..ap6..{ap22}ap5..ap15{ap22}..{ap25}ap14..
     {ap25}ap4..ap3..{ap24}ap2{ap24}..{ap24}ap12..{ap21}ap11);
enddef;

% variant for matrices:
% We connect two nodes of the matrix |@#|.
% This cannot be used to connect nodes that are not in the same
% matrix. It is simpler to name the nodes in order to achieve
% trans-connections.
vardef mcarcbox@#(expr ai,aj,bi,bj) text options=
  ncarcbox@#(matpos(@#)((ai,aj)))(matpos(@#)((bi,bj))) options;
enddef;

% variant for trees:
% We connect two nodes of the tree |@#|.
% This cannot be used to connect nodes that are not in the same tree.
% It is simpler to name the nodes in order to achieve trans-connections.
vardef tcarcbox@#(text ai)(text bi) text options=
  ncarcbox@#(treeroot(@#)(ai))(treeroot(@#)(bi)) options;
enddef;

% |@#| is the object to which a line is added
% |n| is the source and target subobject
% we could also distinguish the case when |n| is an object
% and when it is a point (numerics vs pairs)
vardef nccircle@#(text n) text options =
  o_patharray("_upath_");
  % The first parameter is not relevant since we have only local options
  ExecuteOptions()(options);
  if string n:
    save tmp;string tmp;
    tmp="(" & str @# & ")(" & nameToSuffixString_(n) & ")";
    sc_("nccircle_" & tmp)(patharray_suffix_);
  else:
    nccircle_(@#)(n)(patharray_suffix_);
  fi;
enddef;

% |n| is either an object (if numeric) or a point (if it is a pair)
vardef nccircle_(suffix $)(suffix n)(suffix p)=
  if str $<>"":
    if unknown $p.n_:
      addPathVariables$(p); 
    fi;
  fi;
  settodefaultifnotknown_("angleA")(numeric)(0);
  settodefaultifnotknown_("linewidth")(numeric)(curve_linewidth_default);
  settodefaultifnotknown_("nodesepA")(numeric)(0);
  settodefaultifnotknown_("nodesepB")(numeric)(0);
  if str $ <>"":
    $p.n_:=$p.n_+1;
    $p._draw_[$p.n_]:=LocalOptionValue("cdraw","cdraw_default");
    $p.name[$p.n_]:=LocalOptionValue("name","");
    $p._connect_[$p.n_]:="nccircle";
    $p.arrows[$p.n_]:=CLOV_("arrows");
    $p.visible[$p.n_]:=CLOV_("visible");
    $p.pathfilled[$p.n_]:=false;
    $p.pathfillcolor[$p.n_]:=black;
    $p.angleA[$p.n_]:=o_angleA_val;
    $p.angleB[$p.n_]:=o_angleB_val;
    $p.linewidth[$p.n_]:=o_linewidth_val;
    $p.nodesepA[$p.n_]:=o_nodesepA_val;
    $p.nodesepB[$p.n_]:=o_nodesepB_val;
    nc_inc_$(p);
  fi;
  
  % we have to find one additional point; we must be careful
  % not to use assignments, because |n.c| may be floating:
  save ap;pair ap;
  if numeric n:
    ap=n.c+2cm*dir(90+o_angleA_val); % 2cm should be a parameter
  else:
    ap=n+2cm*dir(90+o_angleA_val);   % 2cm should be a parameter
  fi;
  nc_core_$(n)(p)
    (n.c{dir(o_angleA_val)}..ap..n.c
      cutbefore BpathObj(n) cutafter BpathObj(n))
    (n{dir(o_angleA_val)}..ap..n);
enddef;

% variant for matrices:
vardef mccircle@#(expr ai,aj) text options=
  nccircle@#(matpos(@#)((ai,aj))) options;
enddef;

%====================================================================
% Labels

% Labels are pictures. We use an internal array |ipic_| in order
% to store the labels that are not the standard labels (such
% as the contents of a circle, etc.)

% This should be common to all labels
def objlabel_(suffix $)(expr p) text options =
  ExecuteOptions($)(options);
  if unknown $ipic_1:
    ObjPictureArray(ipic_)(0);
    ObjPointArray(ipic_.off_)(0);
    ObjTransformArray(ipic_.transf_)(0);
    ObjColorArray(ipic_.col_)(0);
    ObjBooleanArray(ipic_.erase_)(0);
  fi;
  $ipic_.n_:=$ipic_.n_+1;
  % we give default values to the options, in case they don't have any
  settodefaultifnotknown_("labrotate")(numeric)(0);
  settodefaultifnotknown_("labpos")(numeric)(0.5);
  settodefaultifnotknown_("labcolor")(color)(black);
  settodefaultifnotknown_("labpoint")(string)("ic");
  settodefaultifnotknown_("laberase")(boolean)(false);
  % picture:
  $ipic_[$ipic_.n_]=p;
  $ipic_[$ipic_.n_]:=$ipic_[$ipic_.n_]
    shifted -.5[urcorner(p),llcorner(p)] rotated o_labrotate_val;
  % transformation
  $ipic_.transf_.n_:=$ipic_.transf_.n_+1;
  $ipic_.transf_[$ipic_.transf_.n_]=identity;
  % we also store the color:
  $ipic_.col_.n_:=$ipic_.col_.n_+1;
  $ipic_.col_[$ipic_.col_.n_]=o_labcolor_val;
  $ipic_.erase_.n_:=$ipic_.erase_.n_+1;
  $ipic_.erase_[$ipic_.erase_.n_]=o_laberase_val;
enddef;

% This is used in |ObjLabel|
% the shift uses values defined in |plain.mp|
%  (labeloffset, laboff, etc.); see the code for |thelabel|.
def labshift_(suffix $)=
  (2 % 2 instead of 1 in the original code
    *labeloffset*laboff.sc_(o_labdir_val)
   -
   (labxf.sc_(o_labdir_val)*(lrcorner $ipic_[$ipic_.off_.n_])
      + labyf.sc_(o_labdir_val)*(ulcorner $ipic_[$ipic_.off_.n_])
      + (1-labxf.sc_(o_labdir_val)-labyf.sc_(o_labdir_val))
         *(llcorner $ipic_[$ipic_.off_.n_])
        )
  )
enddef;

% variant for curve labels:
def clabshift_=
  (2 % 2 instead of 1 in the original code
    *labeloffset*laboff.sc_(o_labdir_val)
   -
   (labxf.sc_(o_labdir_val)*(lrcorner o_labpic_val)
      + labyf.sc_(o_labdir_val)*(ulcorner o_labpic_val)
      + (1-labxf.sc_(o_labdir_val)-labyf.sc_(o_labdir_val))
         *(llcorner o_labpic_val)
        )
  )
enddef;

% not used
def opposite_(expr c)=
  if c="n": "s"
  elseif c="s": "n"
  elseif c="e": "w"
  elseif c="w": "e"
  elseif c="ne": "sw"
  elseif c="nw": "se"
  elseif c="sw": "ne"
  else: "nw"
  fi
enddef;

%
def cardtodir_(expr c)=
  if     c="n":  "top"
  elseif c="s":  "bot"
  elseif c="e":  "rt"
  elseif c="w":  "lft"
  elseif c="ne": "urt"
  elseif c="nw": "ulft"
  elseif c="sw": "llft"
  else:          "lrt"
  fi
enddef;

% This adds the picture |p| on point |a| of object |@#|.
% Two options are recognized: |labshift| and |labrotate|.
vardef ObjLabel@#(expr p) text options =
  objlabel_(@#)(p) options;
  % offset:
  addPointToPointArray@#(ipic_.off_);
  save tmpoff;pair tmpoff;
  if unknown o_labpathname_val and unknown o_labpathid_val:
    if unknown o_labcard_val:
      settodefaultifnotknown_("labshift")(pair)((0,0));
      tmpoff=@#sc_(o_labpoint_val)+o_labshift_val;
    else:
      % The |labcard| option is handled like the |labdir| option,
      % but from the |labcard| point of the object. For instance,
      % |labcard(s)| will be handled like a |labdir(bot)| on point |s|
      % of the object. We use |cardtodir_| to transform a cardinal point
      % into a direction.
      settodefaultifnotknown_("labdir")(string)(cardtodir_(o_labcard_val));
      tmpoff=@#sc_(o_labcard_val);
    fi;
  else:
    settodefaultifnotknown_("labshift")(pair)((0,0)); % added June 1, 2004
    tmpoff=objpathlabel_(@#)+@#c+o_labshift_val; % o_labshift_val added June 1, 2004
                                                 % and @#c on May 1, 2006
    if known o_labangle_val:
      @#ipic_[@#ipic_.n_]:=@#ipic_[@#ipic_.n_] rotated o_labangle_val;
    fi;
  fi;
  if known o_labdir_val:
    @#ipic_.off_[@#ipic_.off_.n_]=tmpoff+labshift_(@#)*CLOV_("labdist");
  else:
    @#ipic_.off_[@#ipic_.off_.n_]=tmpoff;
  fi;
enddef;

% This function places a label at a place
% that is the value of the expression |t|.
vardef ObjComputedLabel@#(expr p)(text t) text options =
  objlabel_(@#)(p) options;
  % offset:
  addPointToPointArray@#(ipic_.off_);
  @#ipic_.off_[@#ipic_.off_.n_]=t;
enddef;

% |pathid| is a path index in the standard or user path arrays.
% We distinguish the two cases with the sign of |pathid|.
% The |labpos| option will be the parameter of the path.
vardef objpathlabel_(suffix $)=
  save pathn,tmpoff;numeric pathn;pair tmpoff;
  hide(
  if known o_labpathid_val: pathn=o_labpathid_val;
  else:
    % we search in the path arrays for a path of that name;
    % this will give us its index:
    forsuffixes $$=_upath_,_spath_:
      if known $.$$n_:
        for i:=1 upto $.$$n_:
          if $.$$name[i]=o_labpathname_val:
            if str $$="_upath_":
              pathn=-i;
            else:
              pathn=i;
            fi;
          fi;
          exitif $.$$name[i]=o_labpathname_val;
        endfor;
      fi;
    endfor;
  fi;  
  save untied;boolean untied;untied=true;
  if known $c:untied:=false;
    save obj_pos;pair obj_pos;
    obj_pos=$c;
    untieObj($);
  fi;
  % we temporarily retie the object to the origin if necessary
  % (before Oct. 3, 2006, this was only done when the object
  %  was not tied, but it produced wrong results when
  %  the center of the object was not the origin)
  $c=origin;
  if pathn>0:
    tmpoff=point (o_labpos_val*length(Path$(_spath_,pathn)))
                 of Path$(_spath_,pathn);
    if known o_labangle_val: 
      o_labangle_val:=o_labangle_val
          +angle(direction (o_labpos_val*length(Path$(_spath_,pathn)))
                           of Path$(_spath_,pathn));
    fi;      
  else:
    tmpoff=point (o_labpos_val*length(Path$(_upath_,-pathn)))
                 of Path$(_upath_,-pathn);
    if known o_labangle_val: 
      o_labangle_val:=o_labangle_val
          +angle(direction (o_labpos_val*length(Path$(_upath_,-pathn)))
                           of Path$(_upath_,-pathn));
    fi;     
  fi;
  % if the object was initially untied, we untie it
  if untied:untieObj($);
  else: % retie it correctly:
    untieObj($);
    $c=obj_pos;
  fi;
  ) tmpoff
enddef;

% Draw the non-standard labels of object |@#|:
vardef drawLabels@#=
  if known @#ipic_.n_:
    for i:=1 upto @#ipic_.n_:
      if @#ipic_.erase_[i]:
        unfill bbox(@#ipic_[i] transformed @#ipic_.transf_[i]
                               shifted @#ipic_.off_[i]);
      fi;      
      draw @#ipic_[i] transformed @#ipic_.transf_[i] shifted @#ipic_.off_[i]
           withcolor @#ipic_.col_[i];
    endfor;
  fi;
enddef;

%====================================================================
% Line styles

% This is adapted from the definition of |double| in |feynmp.mp|:
def draw_double(expr p)(expr sep)(expr lwidth) text s =
  save oldpen;
  pen oldpen;
  oldpen := currentpen;
  pickup pencircle scaled (2lwidth+sep);
  % we use |cutdraw|, otherwise the ends are closed because
  % |undraw| will only remove some inner part
  cutdraw(p) s;
  pickup pencircle scaled sep;
  undraw p;
  pickup oldpen;
enddef;

def drawarrow_double(expr p)(expr sep)(expr lwidth) text s =
  save oldpen;
  pen oldpen;
  oldpen := currentpen;
  pickup pencircle scaled (2lwidth+sep); 
  drawarrow(p) s;
  pickup pencircle scaled sep;
  undraw p;
  pickup oldpen;
enddef;

def rdrawarrow_double(expr p)(expr sep)(expr lwidth) text s =
  drawarrow_double(reverse p)(sep)(lwidth) s;
enddef;

%====================================================================
% Trees

% A tree can be thought of as a root and a (possibly empty) list of subtrees.
% One could think of creating an object for the root and putting
% subobjects for all subtrees. However, doing so is not a good thing,
% because one has at the same place the shape of the root and
% the links to subtrees. So, if one wants to change the shape of
% the root (and possibly other nodes), one has either
%  - to make a copy of the function defining the object
%      and to change the shape (points, equations, paths), or
%  - to make a copy of another function defining the desired shape
%      and add what is relevant to subtrees
% But, there is a better way: one can define a generic ``tree node''
% object, having not only the usual subtrees as its subobjects,
% but also the root. Then, changing the shape of the root becomes
% independent of the rest of tree (assuming the interface conventions
% are respected, of course). The tree node object can even be
% parameterized more, for instance by a function deciding the layout
% of the subtrees (packed or not, considering only the bounding box,
% or looking inside, etc.)

% Tree: Generic Trees
% |@#| is a name for an object (must be a suffix)
% |@#| will be the number of the object, but will also be used
% as a prefix for other variables.
vardef newTree@#(suffix theroot)(text subtrees) text options=
  ExecuteOptions(@#)(options);
  assignObj(@#,"Tree");
  StandardInterface;
  save n,eq;numeric n;string eq;
  n=0;
  forsuffixes $:=subtrees:n:=n+1;endfor;
  ObjNumeric nst;
  setNumeric(nst)(n);
  % The |_spath_| variables are for connections
  % between the root and the subtrees
  addPathVariables@#(_spath_);
  SubObject(subt,obj(newobjstring_));
  if Option@#("treemode","L"):
    % We put the subtrees in an |VBox| object
    % and we use this non-documented construction to pass an option,
    % because we can't pass the option the usual way, at least not simply:
    begingroup;
      o_flip(OptionValue@#("treeflip"));
      o_align(OptionValue@#("Lalign"));
      o_vbsep(OptionValue@#("vbsep"));
      o_elementsize(OptionValue@#("treenodevsize"));
      newVBox.obj(@#subt)(subtrees);
    endgroup;
  elseif Option@#("treemode","R"):
    % We put the subtrees in an |VBox| object:
    begingroup; 
      o_flip(OptionValue@#("treeflip"));
      o_align(OptionValue@#("Ralign"));
      o_vbsep(OptionValue@#("vbsep"));
      o_elementsize(OptionValue@#("treenodevsize"));
      newVBox.obj(@#subt)(subtrees);
    endgroup;
  elseif Option@#("treemode","U"):
    % We put the subtrees in an |HBox| object:
    begingroup; 
      o_flip(OptionValue@#("treeflip"));
      o_align(OptionValue@#("Ualign"));
      o_hbsep(OptionValue@#("hbsep"));
      o_elementsize(OptionValue@#("treenodehsize"));
      newHBox.obj(@#subt)(subtrees);
    endgroup;
  else: % default case
    % We put the subtrees in an |HBox| object:
    begingroup; 
      o_flip(OptionValue@#("treeflip"));
      o_align(OptionValue@#("Dalign"));
      o_hbsep(OptionValue@#("hbsep"));
      o_elementsize(OptionValue@#("treenodehsize"));
      newHBox.obj(@#subt)(subtrees);
    endgroup;
  fi;

  % The root is also a subobject:
  SubObject(root,theroot);
  % we now build the equations:
  % CURRENTLY, WE ASSUME THAT THE SUBTREES ARE LARGER THAN THE ROOT,
  % BUT IT SHOULD BE MADE MORE GENERAL
  %  (right now, nothing here depends on the width of the root)
  %  (the tree can still be built, but it can happen that the root
  %   protrudes)
  % 1 horizontal equation: the root is in the middle of the tree
  % |xpart(root.c)=xpart(subt.c)|
  % 2 horizontal equation: horizontal space at the edges
  % |xpart(subt.w-@#w)=xpart(@#e-subt.e)=0mm;|
  % 3 vertical equation: vertical distance between root and subtrees
  % |ypart(root.s-subt.n)=1cm;|
  % 4 vertical equation: vertical space at the top
  % |ypart(@#n-root.n)=0mm;|
  % 5 vertical equation: vertical space at the bottom
  % |ypart(subt.s-@#s)=0mm;|
  if Option@#("treemode","L") or Option@#("treemode","R"):
    % 1: |ypart(root.c)=ypart(subt.c)|
    eq:="ypart(obj(@#root).c)=ypart(obj(@#subt).c);";
    % 2: |ypart(subt.s-@#s)=ypart(@#n-subt.n)=5mm;|
    eq:=eq & "ypart(obj(@#subt).s-@#s)=ypart(@#n-obj(@#subt).n)=" &
                               decimal (OptionValue@#("dy")) & ";";
    if Option@#("treemode","L"):
      % 3: |xpart(root.w-subt.e)=1cm;|
      if OptionValue@#("treenodehsize")>0:
        eq:=eq & "xpart(obj(@#root).e-obj(@#subt).e)=" &
          decimal
            (OptionValue@#("hsep")+OptionValue@#("treenodehsize")) & ";";
      else:
        eq:=eq & "xpart(obj(@#root).w-obj(@#subt).e)=" &
             decimal (OptionValue@#("hsep")) & ";";
      fi;
      % 4: |xpart(@#e-root.e)=0mm;|
      eq:=eq & "xpart(@#e-obj(@#root).e)=" &
                               decimal (OptionValue@#("dx")) & ";"; 
      % 5: |xpart(subt.w-@#w)=0mm;|
      eq:=eq & "xpart(obj(@#subt).w-@#w)=" &
                               decimal (OptionValue@#("dx")) & ";";
    else: % R
      % 3: |xpart(subt.w-root.e)=1cm;|
      if OptionValue@#("treenodehsize")>0:
        eq:=eq & "xpart(obj(@#subt).w-obj(@#root).w)=" &
          decimal
            (OptionValue@#("hsep")+OptionValue@#("treenodehsize")) & ";";
      else:
        eq:=eq & "xpart(obj(@#subt).w-obj(@#root).e)=" &
             decimal (OptionValue@#("hsep")) & ";";
      fi;
      % 4: |xpart(root.w-@#w)=0mm;|
      eq:=eq & "xpart(obj(@#root).w-@#w)=" &
                               decimal (OptionValue@#("dx")) & ";"; 
      % 5: |xpart(@#e-subt.e)=0mm;|
      eq:=eq & "xpart(@#e-obj(@#subt).e)=" &
                               decimal (OptionValue@#("dx")) & ";"; 
    fi;
  else: % includes default case
    % 1: |xpart(root.c)=xpart(subt.c)|
    eq:="xpart(obj(@#root).c)=xpart(obj(@#subt).c);";
    % 2: |xpart(subt.w-@#w)=xpart(@#e-subt.e)=5mm;|
    eq:=eq & "xpart(obj(@#subt).w-@#w)=xpart(@#e-obj(@#subt).e)=" &
                               decimal (OptionValue@#("dx")) & ";";
    if Option@#("treemode","U"):
      % 3: |ypart(subt.s-root.n)=1cm;|
      if OptionValue@#("treenodevsize")>0:
        eq:=eq & "ypart(obj(@#subt).s-obj(@#root).s)=" &
          decimal
            (OptionValue@#("vsep")+OptionValue@#("treenodevsize")) & ";";
      else:
        eq:=eq & "ypart(obj(@#subt).s-obj(@#root).n)=" &
                  decimal (OptionValue@#("vsep")) & ";";
      fi;
      % 4: |ypart(root.s-@#s)=0mm;|
      eq:=eq & "ypart(obj(@#root).s-@#s)=" &
                               decimal (OptionValue@#("dy")) & ";"; 
      % 5: |ypart(@#n-subt.n)=0mm;|
      eq:=eq & "ypart(@#n-obj(@#subt).n)=" &
                               decimal (OptionValue@#("dy")) & ";"; 
    else: % default case
      % 3: |ypart(root.s-subt.n)=1cm;|
      if OptionValue@#("treenodevsize")>0:
        eq:=eq & "ypart(obj(@#root).n-obj(@#subt).n)=" &
          decimal
            (OptionValue@#("vsep")+OptionValue@#("treenodevsize")) & ";";
      else:
        eq:=eq & "ypart(obj(@#root).s-obj(@#subt).n)=" &
                  decimal (OptionValue@#("vsep")) & ";";
      fi;
      % 4: |ypart(@#n-root.n)=0mm;|
      eq:=eq & "ypart(@#n-obj(@#root).n)=" &
                               decimal (OptionValue@#("dy")) & ";"; 
      % 5: |ypart(subt.s-@#s)=0mm;|
      eq:=eq & "ypart(obj(@#subt).s-@#s)=" &
                               decimal (OptionValue@#("dy")) & ";"; 

    fi;
  fi;  

  ObjCode StandardEquations,eq;
%    |"xpart(@#n)=xpart(@#s);ypart(@#ne)=ypart(@#nw);";|
  StandardTies;
 
  if OptionValue@#("hideleaves"):
    hideTreeLeaves(@#);
  fi;

  memorizeConnections_@#(true);
enddef;

% |t| is the tree, |n| is the child number, |par| is the parameter
% |val| is the new value
def setTreeEdge(suffix t)(expr n)(suffix par)(expr val)=
  t._spath_.par[n]:=val;
enddef;

% This function memorizes the connections between the root and the
% subtrees; it is also used when a subtree is replaced by another one,
% or when the number of subtrees changes.
% The value of |fromoptions| determines
% whether we take the connection information
% from the options, or from a memorized structure
vardef memorizeConnections_@#(expr fromoptions)=
  % we memorize the connection paths:
  for i:=1 upto @#nst:
    % only connections to non empty boxes
    if not isEmptyBox(obj(obj(@#subt).sb[i])): 
      if not(isHFan(Obj(TreeRootObj_(obj(obj(@#subt).sb[i]))))) and
        not(isVFan(Obj(TreeRootObj_(obj(obj(@#subt).sb[i]))))):
        % the next call will inherit the options of |Tree| that are
        % relevant to the |edge| argument, such as |cdraw|:
        if OptionValue@#("edge")<>"none":
          if fromoptions:
            sc_(connectionCommand_@#(i,true));
          else:
            % we use the |pp| variable which is defined in
            % |replaceTreeElement.expl|:
            sc_(connectionCommand_@#(i,false));
          fi;
        fi;
      else:
        ncfan@#(obj(@#root))(Obj(TreeRootObj_(obj(obj(@#subt).sb[i]))))(i);
      fi;
    fi;
  endfor;
enddef;

% |n| is the fan object and |i| is the rank in the subtrees
vardef fanconnection_@#(suffix root,n,a,b)(expr i)=
  if OptionValue.n("pointedfan"):
    addPath@#(_spath_,i,
      smoothen(((.5[n.a,n.b]--root.ic) intersectionpoint BpathObj(root))
        --n.a--.5[n.a,n.b],
        OptionValue.n("fanlinearc"))
      & smoothen(.5[n.a,n.b]--n.b--
        ((.5[n.a,n.b]--root.ic) intersectionpoint BpathObj(root)),
        OptionValue.n("fanlinearc")));
  else:
    addPath@#(_spath_,i,
        smoothen(((n.a--root.ic) intersectionpoint BpathObj(root))--n.a
                  --.5[n.a,n.b],
          OptionValue.n("fanlinearc"))
      & smoothen(.5[n.a,n.b]--n.b--
                  ((n.b--root.ic) intersectionpoint BpathObj(root)),
          OptionValue.n("fanlinearc")));
  fi;
  @#_spath_.n_:=@#_spath_.n_+1;
  % the value |"fandraw"| allows us to detect that the memorized path
  % corresponds to a fan
  @#_spath_.arrows[@#_spath_.n_]:="fandraw"; 
enddef;


vardef ncfan@#(suffix n)(suffix m)(expr i)=
  if isHFan(m):
    fanconnection_@#(n,m,ie,iw)(i);
  elseif isVFan(m):
    fanconnection_@#(n,m,in,is)(i);
  fi;    
enddef;
  
% temporary
def fandraw = draw enddef;

% This function builds a complex connection command from options.
% The result is a string.
vardef connectionCommand_@#(expr i,fromoptions)=
  save cmd;string cmd;
  hide(
    if fromoptions:
      cmd=OptionValue@#("edge");
    else:
      cmd=pp._connect_[i];
    fi;
    cmd:=cmd & "." & str @# & "(obj(" &
        str @# & ".root))(Obj(TreeRootObj_(obj(obj(" & str @# & ".subt).sb[" &
            decimal i & "]))))" &
         " " & quote("patharray(_spath_)")
    optionCase_("angleA",i,fromoptions)(decimal)(@#)
    optionCase_("angleB",i,fromoptions)(decimal)(@#)
    optionCase_("arcangleA",i,fromoptions)(decimal)(@#)
    optionCase_("arcangleB",i,fromoptions)(decimal)(@#)
    optionCase_("linewidth",i,fromoptions)(decimal)(@#)
    optionCase_("nodesepA",i,fromoptions)(decimal)(@#)
    optionCase_("nodesepB",i,fromoptions)(decimal)(@#)
    optionCase_("loopsize",i,fromoptions)(decimal)(@#)
    optionCase_("boxsize",i,fromoptions)(decimal)(@#)
    optionCase_("boxheight",i,fromoptions)(decimal)(@#)
    optionCase_("boxdepth",i,fromoptions)(decimal)(@#)
    optionCase_("visible",i,fromoptions)(booleantostring)(@#)
    optionCase_("pathfilled",i,fromoptions)(booleantostring)(@#)
    optionCase_("pathfillcolor",i,fromoptions)(colortostring)(@#)
    optionCase_("linearc",i,fromoptions)(decimal)(@#)
    optionCase_("linetensionA",i,fromoptions)(decimal)(@#)
    optionCase_("linetensionB",i,fromoptions)(decimal)(@#)
    optionCase_("coilarmA",i,fromoptions)(decimal)(@#)
    optionCase_("coilarmB",i,fromoptions)(decimal)(@#)
    optionCase_("coilheight",i,fromoptions)(decimal)(@#)
    optionCase_("coilwidth",i,fromoptions)(decimal)(@#)
    optionCase_("coilaspect",i,fromoptions)(decimal)(@#)
    optionCase_("coilinc",i,fromoptions)(decimal)(@#)
    optionCase_("posA",i,fromoptions)()(@#)
    optionCase_("posB",i,fromoptions)()(@#)
    optionCase_("armA",i,fromoptions)(decimal)(@#)
    optionCase_("armB",i,fromoptions)(decimal)(@#)
    optionCase_("offsetA",i,fromoptions)(pairtostring)(@#)
    optionCase_("offsetB",i,fromoptions)(pairtostring)(@#)
    optionCase_("name",i,fromoptions)()(@#)
    optionCase_("linecolor",i,fromoptions)(colortostring)(@#)
    optionCase_("border",i,fromoptions)(decimal)(@#)
    optionCase_("bordercolor",i,fromoptions)(colortostring)(@#)
    optionCase_("linestyle",i,fromoptions)()(@#)
    optionCase_("doubleline",i,fromoptions)(booleantostring)(@#)
    optionCase_("doublesep",i,fromoptions)(decimal)(@#)
    optionCase_("arrows",i,fromoptions)()(@#);
    )
  cmd
enddef;

def pairtostring(expr p)=
  "(" & decimal (xpart(p)) & "," & decimal(ypart(p)) & ")"
enddef;

def booleantostring(expr b)=
  if b:"true" else: "false" fi
enddef;

def colortostring(expr p)=
  "(" & decimal(redpart(p)) & "," & decimal(greenpart(p)) & "," &
        decimal(bluepart(p)) & ")"
enddef;

def optionCase_(expr opname,i,fromoptions)(text type)(suffix $)=
  if fromoptions:
        if expandafter known sc_("o_" & opname & "_val"):
          & "," & quote(opname &"(" & type (OptionValue$(opname)) & ")")
        fi
    else:
        if known pp.sc_(opname)[i]:
          & "," & quote(opname & "(" & type (pp.sc_(opname)[i]) & ")")
        fi
    fi
enddef;

streamline("Tree")("(expr theroot)(text subtrees)",
                   "suffixpar(theroot)suffixlist(subtrees)");

% useful shortcuts:
def  T =newTree enddef;
def _T =new_Tree enddef;
def  T_=new_Tree_ enddef;
                 
def BpathTree(suffix n)= StandardBpath(n) enddef;

% This returns the internal number of the root object
% In order to get the appropriate suffix, one should apply |Obj|
% to the result.
def TreeRootObj_(suffix sb)=
  (if isBB(sb): TreeRootObj_(obj(sb.sub))
   elseif isTree(sb): TreeRootObj_(obj(sb.root))
   else: sb
   fi
  )
enddef;

% CHOOSE A BETTER NAME
% This returns the center of the root object
def TreeRoot_(suffix sb)=
  Obj(TreeRootObj_(sb)).ic
enddef;

% This returns the bounding path of the root object
def TreeRootPath_(suffix sb)=
  BpathObj(Obj(TreeRootObj_(sb)))
enddef;

vardef drawTree(suffix n)=
  save fanchildren;
  boolean fanchildren;
  fanchildren=false;
  drawFramedOrFilledObject_(n);
%  pickup pencircle scaled 2pt;
%  draw n.nw--n.ne--n.se--n.sw--cycle withcolor red;
%  pickup pencircle scaled .4pt;
  drawMemorizedPaths_(n);
  drawObj(obj(n.subt));
  % and draw connections (this should be parameterized too)
  for i:=1 upto n.nst:
    % only connections to non empty boxes:
    if not isEmptyBox(obj(obj(n.subt).sb[i])): 
      if isHFan(Obj(TreeRootObj_(obj(obj(n.subt).sb[i])))) or
	  isVFan(Obj(TreeRootObj_(obj(obj(n.subt).sb[i])))):
	fanchildren:=true;
        drawfan_(n,Obj(TreeRootObj_(obj(obj(n.subt).sb[i]))))(i,false);
      else:
        % drawn by |drawMemorizedPaths_|
      fi;
    fi;
  endfor;
  % |unfill| is necessary to cut points of fans
  if fanchildren:
    unfill BpathObj(obj(n.root));
  fi;
  drawObj(obj(n.root));
enddef;

setObjectDefaultOption("Tree")("treemode")("D"); % default is top-down
setObjectDefaultOption("Tree")("treeflip")(false);
setObjectDefaultOption("Tree")("treenodehsize")(-1pt); % like PSTricks
setObjectDefaultOption("Tree")("treenodevsize")(-1pt); % like PSTricks
setObjectDefaultOption("Tree")("dx")(0mm); % left/right margins
setObjectDefaultOption("Tree")("dy")(0mm); % top/down margins
% internal horizontal separation between root and subtrees
setObjectDefaultOption("Tree")("hsep")(1cm);
% internal vertical separation between root and subtrees
setObjectDefaultOption("Tree")("vsep")(1cm);
% the next two options are passed to |newHBox| or |newVBox|
% and concern the separation between subtrees:
setObjectDefaultOption("Tree")("hbsep")(1cm);
setObjectDefaultOption("Tree")("vbsep")(1cm);
setObjectDefaultOption("Tree")("hideleaves")(false); % leaves are in the bb
setObjectDefaultOption("Tree")("edge")("ncline");
% we don't have a default for |cdraw|, which means |ncline|, |ncangle|, ...'s
% default will be used
setObjectDefaultOption("Tree")("framed")(false);
setObjectDefaultOption("Tree")("filled")(false);
setObjectDefaultOption("Tree")("fillcolor")(black);
setObjectDefaultOption("Tree")("framewidth")(.5bp);
setObjectDefaultOption("Tree")("framecolor")(black);
setObjectDefaultOption("Tree")("framestyle")("");
setObjectDefaultOption("Tree")("Dalign")("top");
setObjectDefaultOption("Tree")("Ualign")("bot");
setObjectDefaultOption("Tree")("Lalign")("right");
setObjectDefaultOption("Tree")("Ralign")("left");
setObjectDefaultOption("Tree")("shadow")(false); % no shadow by default
setObjectDefaultOption("Tree")("shadowcolor")(black);

% Declaration of a few arrays.
% This must be a |def| and not a |vardef|:
def declare_pp_variables_=
  save pp;
  string pp._draw_[],pp._connect_[],pp.posA[],pp.posB[],pp.name[],
       pp.linestyle[],pp.arrows[];
  numeric pp.angleA[],pp.angleB[],pp.arcangleA[],pp.arcangleB[],
        pp.linewidth[],pp.border[],pp.nodesepA[],pp.nodesepB[],
        pp.loopsize[],pp.boxsize[],pp.boxheight[],pp.boxdepth[],
        pp.linearc[],pp.linetensionA[],pp.linetensionB[],
        pp.armA[],pp.armB[],pp.doublesep[],
        pp.coilarmA[],pp.coilarmB[],pp.coilheight[],pp.coilwidth[],
        pp.coilaspect[],pp.coilinc[],
        pp.n_;
  boolean pp.visible[],pp.doubleline[],pp.pathfilled[];
  color pp.linecolor[],pp.bordercolor[],pp.pathfillcolor[];
  pair pp.offsetA[],pp.offsetB[];
enddef;

vardef resetPathArray@#(suffix $$)=
  % reset the user arrays:
  if known @#.$$n_:
    @#.$$n_:=0;
    forsuffixes $:=pathoptions_:
      @#.$$.$n_:=0;
    endfor;
    deletePaths@#($$);
  fi;
enddef;

% This function either replaces a subtree or adds a subtree at the end
% of the subtrees.
% This function always resets the tree.
vardef replaceTreeElement.expl@#(expr i)(suffix rep)=
  resetObj.expl@#;

  if isHBox(obj(@#subt)):
    replaceHBoxElement.expl.obj(@#subt)(i)(rep);
  else:
    replaceVBoxElement.expl.obj(@#subt)(i)(rep);
  fi;
  if i=@#nst+1:
    @#nst:=@#nst+1;
    % extend the path parameters
    % we use the same parameters as those for the last connection
    if OptionValue@#("edge")<>"none":
      @#_spath_.n_:=@#_spath_.n_+1;
      forsuffixes $:=pathoptions_:
        @#_spath_$[@#_spath_.n_]:=@#_spath_$[@#_spath_.n_-1];
      endfor;
    fi;
  fi;

  if OptionValue@#("edge")<>"none":
    % memorize the path parameters in a local array:
    declare_pp_variables_;
    pp.n_=@#_spath_.n_;
    for j:=1 upto pp.n_:
      forsuffixes $:=pathoptions_:
        pp$[j]=@#_spath_$[j];
      endfor;
    endfor;
  
    % reset the standard arrays:
    resetPathArray@#(_spath_);
  fi;    

  % reset the user arrays:
  resetPathArray@#(_upath_);
  
  resetObj.expl@#;

  % recreate the standard paths from the memorized information
  memorizeConnections_@#(false);
  
enddef;

% This function deletes a subtree.
% This function always resets the tree.
vardef deleteTreeElement.expl@#(expr i)=
  resetObj.expl@#;
  if isHBox(obj(@#subt)):
    deleteHBoxElement.expl.obj(@#subt)(i);
  else:
    deleteVBoxElement.expl.obj(@#subt)(i);
  fi;
  @#nst:=@#nst-1;

  if OptionValue@#("edge")<>"none":
    % memorize the path parameters in a local array:
    declare_pp_variables_;
    pp.n_=@#_spath_.n_-1;
    % first part (before the removed element)
    for j:=1 upto i-1:
      forsuffixes $:=pathoptions_:
        pp$[j]=@#_spath_$[j];
      endfor;
    endfor;
    
    % second part (after the removed element)
    for j:=i upto pp.n_:
      forsuffixes $:=pathoptions_:
        pp$[j]=@#_spath_$[j+1];
      endfor;
    endfor;
  
    % reset the standard arrays:
    resetPathArray@#(_spath_);
  fi;
  
  % reset the user arrays:
  resetPathArray@#(_upath_);

  resetObj.expl@#;

  % recreate the standard paths from the memorized information
  memorizeConnections_@#(false);
 
enddef;

% This function sets the bounding box of a tree to its root.
% It will be more general later.
def hideTreeLeaves(suffix $)=
  % we have merely to give the right shifts as parameters of
  % |rebindrelativeObj|:
  rebindrelativeObj($)(ypart(obj($root).n-$n),ypart(obj($root).s-$s),
                       xpart(obj($root).e-$e),xpart(obj($root).w-$w));
enddef;

% streamlined version
vardef hideTreeLeaves_(expr n)=
  % we have merely to give the correct shifts as parameters of
  % |rebindrelativeObj|:
  rebindrelative_Obj(obj(iname_[n]))
  (ypart(obj(obj(iname_[n]).root).n-obj(iname_[n]).n),
   ypart(obj(obj(iname_[n]).root).s-obj(iname_[n]).s),
   xpart(obj(obj(iname_[n]).root).e-obj(iname_[n]).e),
   xpart(obj(obj(iname_[n]).root).w-obj(iname_[n]).w)
  )
enddef;

%=====================================================================
% A fan is an object normally only used in trees. It is directly
% inspired of PSTricks' fans.
% This object is actually very similar to a HRazor or VRazor.
% It only behaves like a fan in a Tree context.

vardef newHFan@#(expr dx,dy) text options=
  ExecuteOptions(@#)(options);
  assignObj(@#,"HFan");
  StandardInterface;
  ObjCode StandardEquations,
          "@#ise-@#isw=(" & decimal dx & ",0)", 
          "@#ine-@#ise=(0," & decimal dy & ")"; 
enddef;

streamline("HFan")("(expr dx,dy)","(dx,dy)");

% won't be used
def BpathHFan(suffix n)=StandardBpath(n) enddef;

% This is not used, but the parent calls |drawfan_|
def drawHFan(suffix n)=
  % empty, because the fan is drawn by the parent
  %draw n.ise--n.isw;
  drawMemorizedPaths_(n);
enddef;

% |forceedge| is a boolean that can override the option value |"edge"|
def drawfan_(suffix n,fan)(expr i,forceedge)=
  if (OptionValue.fan("edge")="yes") or forceedge:
    if  OptionValue.fan("filled"):
      fill Path.n(_spath_,i)--cycle withcolor OptionValue.fan("fillcolor");
    else:
      if OptionValue.fan("fanlinestyle")<>"":
        draw Path.n(_spath_,i)
          scantokens(OptionValue.fan("fanlinestyle"))
          withcolor OptionValue.fan("fillcolor");
      else:
        draw Path.n(_spath_,i) withcolor OptionValue.fan("fillcolor");
      fi;
    fi;
  fi;
enddef;

vardef drawfan@#(suffix fan)(expr i)=
  drawfan_(@#,fan)(i,true);
enddef;

setObjectDefaultOption("HFan")("filled")(false);
setObjectDefaultOption("HFan")("edge")("yes");
setObjectDefaultOption("HFan")("pointedfan")(true);
setObjectDefaultOption("HFan")("fanlinestyle")("");
setObjectDefaultOption("HFan")("fanlinearc")(0);
setObjectDefaultOption("HFan")("fillcolor")(black);

%=====================================================================

vardef newVFan@#(expr dx,dy) text options=
  ExecuteOptions(@#)(options);
  assignObj(@#,"VFan");
  StandardInterface;
  ObjCode StandardEquations,
          "@#ise-@#isw=(" & decimal dx & ",0)",
          "@#ine-@#ise=(0," & decimal dy & ")"; 
enddef;

streamline("VFan")("(expr dx,dy)","(dx,dy)");

% won't be used
def BpathVFan(suffix n)=StandardBpath(n) enddef;

% This is not used, but the parent calls |drawfan_|
def drawVFan(suffix n)=
  % empty, because the fan is drawn by the parent
  %draw n.ine--n.ise;
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("VFan")("filled")(false);
setObjectDefaultOption("VFan")("edge")("yes");
setObjectDefaultOption("VFan")("pointedfan")(true);
setObjectDefaultOption("VFan")("fanlinestyle")("");
setObjectDefaultOption("VFan")("fanlinearc")(0);
setObjectDefaultOption("VFan")("fillcolor")(black);

%-------------------------------------------------------------------------

% PTree: Proof Trees
% |@#| is a name for an object (must be a suffix)
% |@#| will be the number of the object, but will also be used
% as a prefix for other variables.
% |left| and |right| are the rule names (they are pictures)
% |conclusion| is a picture too.
% Even though this object seems simple, its code is quite complex
% because we try to cover all special cases.
% However, we assume that there is at least either a conclusion
% or one subtree. Calling this function with no subtrees and
% no conclusion will produce an error.
vardef newPTree@#(expr conclusion)(text subtrees)(expr left,right)
                                     text options=
  ExecuteOptions(@#)(options);
  assignObj(@#,"PTree");
  % parameters that should be options:
  save vdist,rdistl,rdistr,dist_n,dist_s,dist_e,dist_w;
  % vertical distance between premisses and conclusion:
  vdist=OptionValue@#("vsep");  
  % rule distance left
  rdistl=OptionValue@#("lrsep");
  % rule distance right
  rdistr=OptionValue@#("rrsep"); 
  % distances around the proof:
  dist_n=dist_s=OptionValue@#("dy");
  dist_e=dist_w=OptionValue@#("dx");
  StandardInterface;
  ObjPoint ledge,redge, % a |PTree| has two additionnal points that
                        % are useful for a fine positionning of the
                        % horizontal line (actually, we could do without them,
                        % by analyzing the structure of the tree, but this
                        % is a first attempt)
           lstart,lend; % These are the points where the line starts and
                        % where it ends. These variables are not really
                        % necessary, but having them is convenient.
  save n,i,eq,spl,spr;numeric n,i,spl,spr;string eq;
  % we count the number of subtrees:   
  n=0;
  forsuffixes $:=subtrees:
    % we have to be careful because there is always at least one loop,
    % even if |subtrees| is empty (because an empty suffix is a valid suffix):
    if length(str $)>0:n:=n+1;fi;
  endfor;
  ObjNumeric nst;
  % the number of subtrees is stored in the object
  setNumeric(nst)(n);
  i=0;
  SubObject(subt,obj(newobjstring_));
  if not numeric conclusion:
    SubObject(conc,obj(newobjstring_));
  fi;
  if not numeric left:
    SubObject(lr,obj(newobjstring_));
  fi;
  if not numeric right:
    SubObject(rr,obj(newobjstring_));
  fi;
  % We put the subtrees in an HBox object except if there are no subtrees:
  if n>0:
    begingroup;
      % we define options passed to |newHBox|
      o_hbsep(OptionValue@#("hsep"));
      if Option@#("treemode","U"):
        o_align("top");
      else:
        o_align("bot");
      fi;
      newHBox.obj(@#subt)(subtrees);
    endgroup;
  else:
    newEmptyBox.obj(@#subt)(0,0);
  fi;
  %
  if string conclusion:if conclusion="": newEmptyBox.obj(@#conc)(0,0);
                       else:newBox.obj(@#conc)(conclusion) "framed(false)";fi;
  elseif picture conclusion:newBox.obj(@#conc)(conclusion) "framed(false)";
  else: % object
    SubObject(conc,Obj(conclusion));
  fi;
  if string left:if left="": newEmptyBox.obj(@#lr)(0,0);
                 else:newBox.obj(@#lr)(left) "framed(false)";fi;
  elseif picture left:newBox.obj(@#lr)(left) "framed(false)";
  else: % object
    SubObject(lr,Obj(left));
  fi;
  if string right:if right="": newEmptyBox.obj(@#rr)(0,0);
                  else:newBox.obj(@#rr)(right) "framed(false)";fi;
  elseif picture right:newBox.obj(@#rr)(right) "framed(false)";
  else: % object
    SubObject(rr,Obj(right));
  fi;
  % We now build the equations: here are the equations for a top-down tree
  %                              (the conclusion being under the subtrees)
  % 1 horizontal equation: the conclusion is in the middle
  %        of the last line of the subtree
  %   |xpart(conc.c)=xpart(.5[subt.ledge,subt.redge])|
  % 2 vertical equation: vertical distance between root and subtrees
  %   |ypart(subt.s-conc.n)=vdist;| % depends on option
  % 3 vertical equation: vertical space at the top
  %   |ypart(@#n-subt.n)=dist_n;|   % depends on option
  % 4 vertical equation: vertical space at the bottom
  %   |ypart(conc.s-@#s)=dist_s;|   % depends on option
  % 5 Edges:
  %   |@#ledge=conc.sw;@#redge=conc.se;| % depends on option
  % 6 Start and end of the line:
  %   |ypart(@#lstart)=ypart(@#lend)=.5[ypart(subt.s),ypart(conc.n)]|
  %   |xpart(@#lstart)=min(xpart(subt.ledge),xpart(conc.w))|
  %   |xpart(@#lend)=max(xpart(subt.redge),xpart(conc.e))|
  % 7 horizontal space at right of subtree
  %   |max(xpart(@#lend)+wd(@#rr)+rdistr-xpart(subt.e),0)|
  % 8 horizontal space at left of subtree
  %   |min(xpart(@#lstart)-wd(@#lr)-rdistl-xpart(subt.w),0)|
  % 9 Attachment of the rules:
  %   |@#lstart-(rdistl,0)=@#lr.e|
  %   |@#lend=@#rr.w-(rdistr,0)|
  %
  % Left and right edges of the subtree are actually not defined,
  % because it is an |HBox|. But even the components of the |HBox|
  % may lack these features if we are at the top of the proof tree.
  % So, what we do is that we compute the positions of the edges
  % with respect to the |.s| point of the subtree.
  save subledge,subredge;pair subledge,subredge;
  if not isEmptyBox(obj(@#subt)):
    if isPTree(obj(obj(@#subt).sb[1])):
      subledge=obj(obj(@#subt).sb[1]).ledge-obj(@#subt).s;
    else:
      subledge=obj(obj(@#subt).sb[1]).sw-obj(@#subt).s;
    fi;
    if isPTree(obj(obj(@#subt).sb[@#nst])):
      subredge=obj(obj(@#subt).sb[@#nst]).redge-obj(@#subt).s;
    else:
      subredge=obj(obj(@#subt).sb[@#nst]).se-obj(@#subt).s;
    fi;
  else: % if the subtree is empty, we use the edges of the conclusion
    % with respect to the |.n| point of the conclusion
    subledge=obj(@#conc).nw-obj(@#conc).n;
    subredge=obj(@#conc).ne-obj(@#conc).n;
    % see below how it is used when there are no subtrees
  fi;
  eq:="";
  % 1   |xpart(conc.c)=xpart(.5[subt.ledge,subt.redge])|
  %                  |=xpart(.5[subt.s+subledge,subt.s+subredge])|
  %          |=.5(xpart(subt.s)+xpart(subledge),xpart(subt.s)+xpart(subredge))|
  %  (if for some reason conc.ledge and conc.redge exist, we replace
  %    conc.c by .5[conc.ledge,conc.redge])
  if (not isEmptyBox(obj(@#subt))) and (not isEmptyBox(obj(@#conc))):
    eq:=eq & "xpart(";
    if pair obj(@#conc).ledge and pair obj(@#conc).redge:
      eq:=eq & ".5[obj(@#conc).ledge,obj(@#conc).redge]";
    else:
      eq:=eq & "obj(@#conc).c";
    fi;
    eq:=eq & ")=.5[xpart(obj(@#subt).s)" & (signeddecimal xpart(subledge)) &
            ",xpart(obj(@#subt).s)" & (signeddecimal xpart(subredge)) & "];";
  fi;
  % 2 |ypart(subt.s-conc.n)=vdist;| % depends on options
  if (not isEmptyBox(obj(@#subt))) and (not isEmptyBox(obj(@#conc))):
    if Option@#("treemode","U"):
      eq:=eq & "ypart(obj(@#conc).s-obj(@#subt).n)=" & decimal vdist & ";";
    else:
      eq:=eq & "ypart(obj(@#subt).s-obj(@#conc).n)=" & decimal vdist & ";";
    fi;    
  fi;
  % 3 |ypart(@#n-subt.n)=dist_n;|  % depends on option
  if Option@#("treemode","U"):
    if (not isEmptyBox(obj(@#conc))):
      eq:=eq & "ypart(@#n-obj(@#conc).n)=" & decimal dist_n & ";";
    else:
      eq:=eq & "ypart(@#n-obj(@#subt).n)=" & decimal (vdist/2) & ";";
    fi;
  else:
    if (not isEmptyBox(obj(@#subt))):
      eq:=eq & "ypart(@#n-obj(@#subt).n)=" & decimal dist_n & ";";
    else:
      eq:=eq & "ypart(@#n-obj(@#conc).n)=" & decimal (vdist/2) & ";";
    fi;
  fi;
  % 4 |ypart(conc.s-@#s)=dist_s;|  % depends on option
  if Option@#("treemode","U"):
    if (not isEmptyBox(obj(@#subt))):
      eq:=eq & "ypart(obj(@#subt).s-@#s)=" & decimal dist_s & ";";
    else:
      eq:=eq & "ypart(obj(@#conc).s-@#s)=" & decimal (vdist/2) & ";";
    fi;
  else:
    if (not isEmptyBox(obj(@#conc))):
      eq:=eq & "ypart(obj(@#conc).s-@#s)=" & decimal dist_s & ";";
    else:
      eq:=eq & "ypart(obj(@#subt).s-@#s)=" & decimal (vdist/2) & ";";
    fi;
  fi;
  % 5 |@#ledge=conc.sw;@#redge=conc.se;| % depends on option
  if (not isEmptyBox(obj(@#conc))):
    if Option@#("treemode","U"):
      eq:=eq & "@#ledge=obj(@#conc).nw;@#redge=obj(@#conc).ne;";
    else:
      eq:=eq & "@#ledge=obj(@#conc).sw;@#redge=obj(@#conc).se;";
    fi;
  else:
    % |@#ledge=@#lstart; @#redge=@#lend;|
    eq:=eq & "@#ledge=@#lstart;@#redge=@#lend;";
  fi;
  % 6 Start and end of the line:
  %   |ypart(@#lstart)=ypart(@#lend)=ypart(conc.n)+vdist/2|
  % |if xpart(subt.redge)-xpart(subt.ledge) > xpart(conc.e)-xpart(conc.w):|
  %   |xpart(@#lstart)=xpart(subt.ledge)|
  %   |xpart(@#lend)=xpart(subt.redge)|
  % |else:|
  % |  xpart(@#lstart)=xpart(conc.w)|
  % |  xpart(@#lend)=xpart(conc.e)|
  % |fi|
  if Option@#("treemode","U"):
    if not isEmptyBox(obj(@#conc)):
      eq:=eq & "ypart(@#lstart)=ypart(@#lend)" &
                "=ypart(obj(@#conc).s)-" & decimal (vdist/2) & ";";
    else:
      eq:=eq & "ypart(@#lstart)=ypart(@#lend)" &
                "=ypart(obj(@#subt).n)+" & decimal (vdist/2) & ";";
    fi;
  else:
    if not isEmptyBox(obj(@#conc)):
      eq:=eq & "ypart(@#lstart)=ypart(@#lend)" &
                "=ypart(obj(@#conc).n)+" & decimal (vdist/2) & ";";
    else:
      eq:=eq & "ypart(@#lstart)=ypart(@#lend)" &
                "=ypart(obj(@#subt).s)-" & decimal (vdist/2) & ";";
    fi;
  fi;
  if xpart(subredge)-xpart(subledge) >
    (if pair obj(@#conc).ledge:
        xpart(obj(@#conc).redge)-xpart(obj(@#conc).ledge)
     else:
       xpart(obj(@#conc).e)-xpart(obj(@#conc).w)
     fi):
    eq:=eq & "xpart(@#lstart)=xpart(obj(@#subt).c)" &
                            (signeddecimal xpart(subledge)) &
                            (signeddecimal(OptionValue@#("lstartdx")))  & ";";
    eq:=eq & "xpart(@#lend)=xpart(obj(@#subt).c)" &
                            (signeddecimal xpart(subredge)) &
                            (signeddecimal(OptionValue@#("lenddx")))  & ";";
    % 7 horizontal space at right of subtree
    %   |max(xpart(@#lend)+rdistr+wd(@#rr)-xpart(subt.e),0)|
    % |= max(xpart(obj(@#subt).redge)+rdistr+wd(@#rr)-xpart(obj(@#subt).e),0)|
    spr=xpart(obj(@#subt).s)+xpart(subredge)+rdistr
       +xpart(obj(@#rr).e-obj(@#rr).w)-xpart(obj(@#subt).e);
    if spr<0: spr:=0;fi;spr:=spr+dist_e;
    % 8 horizontal space at left of subtree
    %   |min(xpart(@#lstart)-wd(@#lr)-rdistl-xpart(subt.w),0)|
    % |= min(xpart(obj(@#subt).ledge)-wd(@#lr)-rdistl-xpart(obj(@#subt).w),0)|
    spl=xpart(obj(@#subt).s)+xpart(subledge)
       -xpart(obj(@#lr).e-obj(@#lr).w)-rdistl-xpart(obj(@#subt).w);
    if spl>0:spl:=0;fi;spl:=spl-dist_w;
    eq:=eq & "xpart(@#e)-xpart(obj(@#subt).e)=" & (signeddecimal spr) & ";";
    eq:=eq & "xpart(obj(@#subt).w)-xpart(@#w)=" & (signeddecimal (-spl)) & ";";
  else:
    if pair obj(@#conc).ledge:
      eq:=eq & "xpart(@#lstart)=xpart(obj(@#conc).ledge)" &
                            (signeddecimal(OptionValue@#("lstartdx"))) & ";";
      eq:=eq & "xpart(@#lend)=xpart(obj(@#conc).redge)" &
                            (signeddecimal(OptionValue@#("lenddx"))) & ";";
    else:
      eq:=eq & "xpart(@#lstart)=xpart(obj(@#conc).w)" &
                            (signeddecimal(OptionValue@#("lstartdx"))) & ";";
      eq:=eq & "xpart(@#lend)=xpart(obj(@#conc).e)" &
                            (signeddecimal(OptionValue@#("lenddx"))) & ";";
    fi;
    % 7 horizontal space at right of conclusion
    %   |max(xpart(@#lend)+rdistr+wd(@#rr)-xpart(conc.e),0)|
    % |= max(rdistr+wd(@#rr),0)|
    spr=rdistr+xpart(obj(@#rr).e-obj(@#rr).w);
    if spr<0: spr:=0;fi;spr:=spr+dist_e;
    % 8 horizontal space at left of conclusion
    %   |min(xpart(@#lstart)-wd(@#lr)-rdistl-xpart(conc.w),0)|
    % |= min(-wd(@#lr)-rdistl,0)|
    spl=-xpart(obj(@#lr).e-obj(@#lr).w)-rdistl;
    if spl>0:spl:=0;fi;spl:=spl-dist_w;
    if pair obj(@#conc).ledge:
      eq:=eq & "xpart(@#e)-xpart(obj(@#conc).redge)=" &
                           (signeddecimal spr) & ";";
      eq:=eq & "xpart(obj(@#conc).ledge)-xpart(@#w)=" &
                           (signeddecimal (-spl)) & ";";
    else:
      eq:=eq & "xpart(@#e)-xpart(obj(@#conc).e)=" &
                           (signeddecimal spr) & ";";
      eq:=eq & "xpart(obj(@#conc).w)-xpart(@#w)=" &
                           (signeddecimal (-spl)) & ";";
    fi;
  fi;
  %
  % 9 Attachment of the rules:
  %   |@#lstart=@#lr.e|
  %   |@#lend=@#rr.w|
  if not isEmptyBox(obj(@#lr)):
    eq:=eq & "@#lstart-(rdistl,0)=obj(@#lr).e;";
  fi;
  if not isEmptyBox(obj(@#rr)):
    eq:=eq & "@#lend=obj(@#rr).w-(rdistr,0);";
  fi;
  ObjCode StandardEquations,eq;
%    |"xpart(@#n)=xpart(@#s);ypart(@#ne)=ypart(@#nw);";|
  StandardTies;
enddef;

streamline("PTree")("(expr conclusion)(text subtrees)(expr left,right)",
                   "suffixpar(conclusion)suffixlist(subtrees)(left,right)");

def BpathPTree(suffix n)= StandardBpath(n) enddef;

% CHOOSE A BETTER NAME
def PTreeRoot_(suffix sb)=
  (if isBB(sb): PTreeRoot_(obj(sb.sub))
   elseif isPTree(sb): PTreeRoot_(obj(sb.root))
   else: sb.ic
   fi
  )
enddef;

def PTreeRootPath_(suffix sb)=
  (if isBB(sb): PTreeRootPath_(obj(sb.sub))
   elseif isPTree(sb): PTreeRootPath_(obj(sb.root))
   else: BpathObj(sb)
   fi
  )
enddef;

def drawPTree(suffix n)=
  drawFramedOrFilledObject_(n);
  if not isEmptyBox(obj(n.conc)): drawObj(obj(n.conc)); fi;
  if not isEmptyBox(obj(n.subt)): drawObj(obj(n.subt)); fi;
  if not isEmptyBox(obj(n.lr)):   drawObj(obj(n.lr));   fi;
  if not isEmptyBox(obj(n.rr)):   drawObj(obj(n.rr));   fi;
  if OptionValue.n("rule")>0:
    pickup pencircle scaled OptionValue.n("rule");
    draw n.lstart -- n.lend;
  fi;
%  pickup pencircle scaled 2pt;
%  draw n.ledge withcolor red;
%  draw n.redge withcolor red;
  pickup pencircle scaled .4pt;
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("PTree")("treemode")("D");    % default is down
setObjectDefaultOption("PTree")("dx")(0mm);     % left/right margins
setObjectDefaultOption("PTree")("dy")(0mm);     % top/down margins
setObjectDefaultOption("PTree")("hsep")(3mm);   % internal horizontal separation
                                          % between subtrees
setObjectDefaultOption("PTree")("vsep")(2mm);   % internal vertical separation
setObjectDefaultOption("PTree")("lrsep")(2mm);  % separation with left rule
setObjectDefaultOption("PTree")("rrsep")(2mm);  % separation with right rule
setObjectDefaultOption("PTree")("lstartdx")(0); % positive towards the right
setObjectDefaultOption("PTree")("lenddx")(0);   % positive towards the right
setObjectDefaultOption("PTree")("rule")(.5bp);  % rule thickness
setObjectDefaultOption("PTree")("framed")(false);
setObjectDefaultOption("PTree")("filled")(false);
setObjectDefaultOption("PTree")("fillcolor")(black);
setObjectDefaultOption("PTree")("framewidth")(.5bp);
setObjectDefaultOption("PTree")("framecolor")(black);
setObjectDefaultOption("PTree")("framestyle")("");
setObjectDefaultOption("PTree")("shadow")(false); % no shadow by default
setObjectDefaultOption("PTree")("shadowcolor")(black);

% Two simplified versions, where only one rule is given:
vardef newPTreeL@#(expr conclusion)(text subtrees)(expr left) text options=
  newPTree@#(conclusion)(subtrees)(left,"") options
enddef;

vardef newPTreeR@#(expr conclusion)(text subtrees)(expr right) text options=
  newPTree@#(conclusion)(subtrees)("",right) options
enddef;

% A version with no subtrees and no rules:
vardef newAxiom@#(expr axiom) text options=
  newPTree@#(axiom)("")("","") options
enddef;

vardef newAssumption@#(expr assumption)=
  newBox@#(assumption) "framed(false)", "dx(0)", "dy(0)"
enddef;

% This is identical to |newAssumption|, but it would be confusing
% to use |newAssumption| where a conclusion occurs.
vardef newConclusion@#(expr conclusion)=
  newBox@#(conclusion) "framed(false)", "dx(0)", "dy(0)"
enddef;

%=====================================================================
% |HBox| class

% |HBox|: Generic Horizontal Alignments
% |@#| is a name for an object (must be a suffix)
% |@#| will be the number of the object, but will also be used
% as a prefix for other variables.
vardef newHBox@#(text sublist) text options =
  ExecuteOptions(@#)(options);
  assignObj(@#,"HBox");
  StandardInterface;
  save n,i,eq;numeric n,i;string eq;
  n=0;
  forsuffixes $:=sublist:n:=n+1;endfor;
  ObjSubArray(sb)(n); % |n| is the number of horizontal elements
  ObjNumeric nst,tallest;
  setNumeric(nst)(n);
  i=0;
  if OptionValue@#("flip"):
    forsuffixes $:=sublist:i:=i+1;
      SubObjectOfArray(sb[n+1-i],$);
    endfor;
  else:
    forsuffixes $:=sublist:i:=i+1;
      SubObjectOfArray(sb[i],$);
    endfor;
  fi;
  % we now build the equations:
  % 1: horizontal equation: horizontal separation between elements
  %   if elementsize<0:
  %      |xpart(sb[2].w-sb[1].e)=xpart(sb[3].w-sb[2].e)=...|
  %                            |=xpart(sb[n].w-sb[n-1].e)=5mm;|
  %   if elementsize>=0:
  %      |xpart(sb[2].c-sb[1].c)=xpart(sb[3].c-sb[2].c)=...|
  %                            |=xpart(sb[n].c-sb[n-1].c)=hbsep+elementsize;|
  %
  % 2: horizontal equation: horizontal space at the edges
  % |xpart(sb[1].w-@#w)=xpart(@#e-sb[n].e)=0mm;|
  % 3: vertical equation: elements are lined up at the top
  %      |ypart(sb[1].n)=ypart(sb[2].n)=...=ypart(sb[n].n)|
  %   or at the bottom (default) (depending on the options)
  %      |ypart(sb[1].s)=ypart(sb[2].s)=...=ypart(sb[n].s)|
  %   or at the center
  %      |ypart(sb[1].c)=ypart(sb[2].c)=...=ypart(sb[n].c)|
  % 4: vertical equation: vertical space at the top
  %   |ypart(@#n-sb[i].n)=0mm;|  where |sb[i]| is the tallest
  % 5: vertical equation: vertical space at the bottom
  %     |ypart(sb[i].s-@#s)=0mm;| where |sb[i]| is the tallest
  % 1:
  if OptionValue@#("elementsize")<0:
    eq:="if @#sb.n_>1:" &
          "xpart(obj(@#sb[2]).w-obj(@#sb[1]).e) " &
          "if @#sb.n_>2:" & 
            "for i:=3 upto @#sb.n_: " &
               "=xpart(obj(@#sb[i]).w-obj(@#sb[i-1]).e)" &
            "endfor " &
          "fi" &
          "=" & decimal(OptionValue@#("hbsep")) & ";" & 
          "fi;";
  else:
    eq:="if @#sb.n_>1:" &
          "xpart(obj(@#sb[2]).c-obj(@#sb[1]).c) " &
          "if @#sb.n_>2:" & 
            "for i:=3 upto @#sb.n_: " &
               "=xpart(obj(@#sb[i]).c-obj(@#sb[i-1]).c)" &
            "endfor " &
          "fi" &
          "=" &
          decimal(OptionValue@#("hbsep")+OptionValue@#("elementsize")) & ";" & 
          "fi;";
  fi;    
  % 2: |xpart(sb[1].w-@#w)=xpart(@#e-sb[n].e)=5mm;|
  if OptionValue@#("elementsize")<0:
    eq:=eq & "xpart(obj(@#sb[1]).w-@#w)" &
          "=xpart(@#e-obj(@#sb[@#sb.n_]).e)=" &
          decimal(OptionValue@#("dx")) & ";";
  else:
    eq:=eq & "xpart(obj(@#sb[1]).c-@#w)" &
          "=xpart(@#e-obj(@#sb[@#sb.n_]).c)=" &
          decimal(OptionValue@#("dx")+.5*OptionValue@#("elementsize")) & ";";
  fi;
  % The next equation depends on an option:
  save alignsuffix;string alignsuffix;  alignsuffix="s";
  if Option@#("align","top"):alignsuffix:="n";
  elseif Option@#("align","center"):alignsuffix:="c";
  fi;
          
  % 3: |ypart(sb[1].alignsuffix)=ypart(sb[2].alignsuffix)=...|
                             % |=ypart(sb[n].alignsuffix)|
  eq:=eq & "if @#sb.n_>1:" &
             "ypart(obj(@#sb[1])." & alignsuffix & ")" &
             "for i:=2 upto @#sb.n_: " &
               "=ypart(obj(@#sb[i])." & alignsuffix & ")" &
             "endfor;" &
           "fi;";
  % first, we compute the tallest subtree:
  setTallest@#;
  % 4: |ypart(@#n-sb[tallest].n)=0mm;|
  eq:=eq & "ypart(@#n-obj(@#sb[@#tallest]).n)=" &
                              decimal(OptionValue@#("dy")) & ";";
  % 5: |ypart(sb[tallest].s-@#s)=0mm;|
  eq:=eq & "ypart(obj(@#sb[@#tallest]).s-@#s)=" &
                              decimal(OptionValue@#("dy")) & ";";
  
  ObjCode StandardEquations,eq;
%    |"xpart(@#n)=xpart(@#s);ypart(@#ne)=ypart(@#nw);";|
  StandardTies;
enddef;

% The result of |setTallest| must be greater than 0.
vardef setTallest@#=
  save tallest_height;
  @#tallest:=1;tallest_height=0;
  for i:=1 upto @#nst:
    if ypart(obj(@#sb[i]).n-obj(@#sb[i]).s)>tallest_height: 
      @#tallest:=i;
      tallest_height:=ypart(obj(@#sb[i]).n-obj(@#sb[i]).s);
    fi;
  endfor;
enddef;

streamline("HBox")("(text sublist)","suffixlist(sublist)");

def BpathHBox(suffix n)= StandardBpath(n) enddef;

def drawHBox(suffix n)=
  drawFramedOrFilledObject_(n);
  drawObjArray(n)(sb);
  drawMemorizedPaths_(n);
enddef;

% Default values of |HBox|:
setObjectDefaultOption("HBox")("dx")(0mm);
setObjectDefaultOption("HBox")("dy")(0mm);
setObjectDefaultOption("HBox")("hbsep")(1mm);
setObjectDefaultOption("HBox")("elementsize")(-1pt); % like PSTricks
setObjectDefaultOption("HBox")("align")("bot");
setObjectDefaultOption("HBox")("framed")(false);
setObjectDefaultOption("HBox")("filled")(false);
setObjectDefaultOption("HBox")("fillcolor")(black);
setObjectDefaultOption("HBox")("framewidth")(.5bp);
setObjectDefaultOption("HBox")("framecolor")(black);
setObjectDefaultOption("HBox")("framestyle")("");
setObjectDefaultOption("HBox")("flip")(false);
setObjectDefaultOption("HBox")("shadow")(false); % no shadow by default
setObjectDefaultOption("HBox")("shadowcolor")(black);


% Replace an element in an |HBox| or add an element at the end of the list.
% A succeeding call to this function resets the object.
vardef replaceHBoxElement.expl@#(expr i)(suffix rep)=
  setcurrentobjname_(str @#);
  if (i<1) or (i>@#sb.n_+1):
    errmessage "Value out of range";
  elseif i<@#sb.n_+1:
    % first, we reset the object in order to be sure we have its right
    % dimensions when we try to update  |tallest|
    resetObj.expl@#;
    @#sb[i]:=str rep;
    % we recompute the tallest element:
    setTallest@#;
    resetObj.expl@#;
  else: % |i=@#sb.n_+1|
    % we add |rep| at the end of the |HBox|
    % first, we reset the object in order to be sure we have its right
    % dimensions when we try to update  |tallest|
    resetObj.expl@#;
    @#sb.n_:=@#sb.n_+1;
    @#sb[@#sb.n_]:=str rep;
    setTallest@#; % not fast, but short
    resetObj.expl@#;
    % we need to add one tie, and the easiest is to recreate them all:
    @#nsubobjties_:=0;
    StandardTies;
  fi;
enddef;

% Delete an element in an |HBox|
% A succeeding call to this function resets the object.
vardef deleteHBoxElement.expl@#(expr i)=
  setcurrentobjname_(str @#);
  if (i<0) or (i>@#sb.n_):
    errmessage "Value out of range";
  else:
    resetObj.expl@#;
    for j:=i upto @#sb.n_-1:
      @#sb[j]:=@#sb[j+1];
    endfor;
    @#sb[@#sb.n_]:=whateverstring;
    @#sb.n_:=@#sb.n_-1;
    setTallest@#;
    resetObj.expl@#;
    % we reconstruct the standard ties
    @#nsubobjties_:=0;
    StandardTies;
  fi;
enddef;


% The next class is the vertical analog of |HBox|. It would have
% been possible to merge |newHBox| and |newVBox| in something like
% |newAlign| (|xpart| becoming |ypart|, |.w| becoming |.s|, etc.)
% but we didn't do it for the sake of clarity. It is left as an
% exercise.

%=====================================================================
% |VBox| class

% |VBox|: Generic Vertical Alignments
% The objects are stacked up (and not down as in \TeX).
% |@#| is a name for an object (must be a suffix)
% |@#| will be the number of the object, but will also be used
% as a prefix for other variables.
vardef newVBox@#(text sublist) text options =
  ExecuteOptions(@#)(options);
  assignObj(@#,"VBox");
  StandardInterface;
  save n,i,eq;numeric n,i;string eq;
  n=0;
  forsuffixes $:=sublist:n:=n+1;endfor;
  ObjSubArray(sb)(n); % |n| is the number of vertical elements
  ObjNumeric nst,widest;
  setNumeric(nst)(n);
  i=0;
  if OptionValue@#("flip"):
    forsuffixes $:=sublist:i:=i+1;
      SubObjectOfArray(sb[n+1-i],$);
    endfor;
  else:
    forsuffixes $:=sublist:i:=i+1;
      SubObjectOfArray(sb[i],$);
    endfor;
  fi;
  % we now build the equations:
  % 1: vertical equation: vertical separation between elements
  % |ypart(sb[2].s-sb[1].n)=ypart(sb[3].s-sb[2].n)=...|
  %                       |=ypart(sb[n].s-sb[n-1].n)=5mm;|
  % 2: vertical equation: vertical space at the edges
  % |ypart(sb[1].s-@#s)=ypart(@#n-sb[n].n)=0mm;|
  % 3: horizontal equation: elements are lined up at the left (default)
  %      |xpart(sb[1].w)=xpart(sb[2].w)=...=xpart(sb[n].w)|
  %   or at the right (depending on the options)
  %      |xpart(sb[1].e)=xpart(sb[2].e)=...=xpart(sb[n].e)|
  %   or at the center
  %      |xpart(sb[1].c)=xpart(sb[2].c)=...=xpart(sb[n].c)|
  % 4: horizontal equation: horizontal space at the right
  %   |xpart(@#e-sb[i].e)=0mm;|  where |sb[i]| is the widest
  % 5: horizontal equation: vertical space at the left
  %     |xpart(sb[i].w-@#w)=0mm;| where |sb[i]| is the widest
  % 1:
  if OptionValue@#("elementsize")<0:
    eq:="if @#sb.n_>1:" &
          "ypart(obj(@#sb[2]).s-obj(@#sb[1]).n)" &
          "if @#sb.n_>2:" &
            "for i:=3 upto @#sb.n_: " &
              "=ypart(obj(@#sb[i]).s-obj(@#sb[i-1]).n)" &
            "endfor " &
          "fi" &
          "=" & decimal(OptionValue@#("vbsep")) & ";" &
          "fi;";
  else:
    eq:="if @#sb.n_>1:" &
          "ypart(obj(@#sb[2]).c-obj(@#sb[1]).c)" &
          "if @#sb.n_>2:" &
            "for i:=3 upto @#sb.n_: " &
              "=ypart(obj(@#sb[i]).c-obj(@#sb[i-1]).c)" &
            "endfor " &
          "fi" &
          "=" &
           decimal(OptionValue@#("vbsep")+OptionValue@#("elementsize")) & ";" &
          "fi;";
  fi;
  % 2: |ypart(sb[1].s-@#s)=ypart(@#n-sb[n].n)=5mm;|
  if OptionValue@#("elementsize")<0:
    eq:=eq & "ypart(obj(@#sb[1]).s-@#s)" &
            "=ypart(@#n-obj(@#sb[@#sb.n_]).n)=" &
            decimal(OptionValue@#("dy")) & ";";
  else:
    eq:=eq & "ypart(obj(@#sb[1]).c-@#s)" &
            "=ypart(@#n-obj(@#sb[@#sb.n_]).c)=" &
            decimal(OptionValue@#("dy")+.5*OptionValue@#("elementsize")) & ";";
  fi;
  % The next equation depends on an option:
  save alignsuffix;string alignsuffix;  alignsuffix="w"; % default
  if Option@#("align","right"):alignsuffix:="e";
  elseif Option@#("align","center"):alignsuffix:="c";
  fi;
          
  % 3: |xpart(sb[1].alignsuffix)=xpart(sb[2].alignsuffix)=...|
                             % |=xpart(sb[n].alignsuffix)|
  eq:=eq & "if @#sb.n_>1:" &
             "xpart(obj(@#sb[1])." & alignsuffix & ")" &
             "for i:=2 upto @#sb.n_: " &
                "=xpart(obj(@#sb[i])." & alignsuffix & ")" &
             "endfor;" &
           "fi;";
  % first, we compute the widest subtree:
  setWidest@#;
  % 4: |xpart(@#e-sb[widest].e)=0mm;|
  eq:=eq & "xpart(@#e-obj(@#sb[@#widest]).e)=" &
                         decimal(OptionValue@#("dx")) & ";";
  % 5: |xpart(sb[widest].w-@#w)=0mm;|
  eq:=eq & "xpart(obj(@#sb[@#widest]).w-@#w)=" &
                         decimal(OptionValue@#("dx")) & ";";
  ObjCode StandardEquations,eq;
%    |"ypart(@#n)=ypart(@#s);xpart(@#ne)=xpart(@#nw);";|
  StandardTies;
enddef;

% The result of |setWidest| must be greater than 0.
vardef setWidest@#=
  save widest_width;@#widest:=1;widest_width=0;
  for i:=1 upto @#nst:
    if xpart(obj(@#sb[i]).e-obj(@#sb[i]).w)>widest_width: 
      @#widest:=i;
      widest_width:=xpart(obj(@#sb[i]).e-obj(@#sb[i]).w);
    fi;
  endfor;
enddef;

streamline("VBox")("(text sublist)","suffixlist(sublist)");

def BpathVBox(suffix n)= StandardBpath(n) enddef;

def drawVBox(suffix n)=
  drawFramedOrFilledObject_(n);
  drawObjArray(n)(sb);
  drawMemorizedPaths_(n);
enddef;

% Default values of |VBox|:
setObjectDefaultOption("VBox")("dx")(0mm);
setObjectDefaultOption("VBox")("dy")(0mm);
setObjectDefaultOption("VBox")("vbsep")(1mm);
setObjectDefaultOption("VBox")("elementsize")(-1pt); % like PSTricks
setObjectDefaultOption("VBox")("align")("left");
setObjectDefaultOption("VBox")("framed")(false);
setObjectDefaultOption("VBox")("filled")(false);
setObjectDefaultOption("VBox")("fillcolor")(black);
setObjectDefaultOption("VBox")("framewidth")(.5bp);
setObjectDefaultOption("VBox")("framecolor")(black);
setObjectDefaultOption("VBox")("framestyle")("");
setObjectDefaultOption("VBox")("flip")(false);
setObjectDefaultOption("VBox")("shadow")(false); % no shadow by default
setObjectDefaultOption("VBox")("shadowcolor")(black);

% Replace an element in an |VBox| or add an element at the end of the list.
% A succeeding call to this function resets the object.
vardef replaceVBoxElement.expl@#(expr i)(suffix rep)=
  setcurrentobjname_(str @#);
  if (i<1) or (i>@#sb.n_+1):
    errmessage "Value out of range";
  elseif i<@#sb.n_+1:
    % first, we reset the object in order to be sure we have its right
    % dimensions when we try to update  |widest|
    resetObj.expl@#;
    @#sb[i]:=str rep;
    % we recompute the widest element:
    setWidest@#;
    resetObj.expl@#;
  else: % |i=@#sb.n_+1|
    % we add |rep| at the end of the |VBox|
    % first, we reset the object in order to be sure we have its right
    % dimensions when we try to update  |widest|
    resetObj.expl@#;
    @#sb.n_:=@#sb.n_+1;
    @#sb[@#sb.n_]:=str rep;
    setWidest@#; % not fast, but short
    resetObj.expl@#;
    % we need to add one tie, and the easiest is to recreate them all:
    @#nsubobjties_:=0;
    StandardTies;
  fi;
enddef;

% Delete an element in an |VBox|
% A succeeding call to this function resets the object.
% This function should be merged with |deleteHBoxElement.expl|
vardef deleteVBoxElement.expl@#(expr i)=
  setcurrentobjname_(str @#);
  if (i<0) or (i>@#sb.n_):
    errmessage "Value out of range";
  else:
    resetObj.expl@#;
    for j:=i upto @#sb.n_-1:
      @#sb[j]:=@#sb[j+1];
    endfor;
    @#sb[@#sb.n_]:=whateverstring;
    @#sb.n_:=@#sb.n_-1;
    setWidest@#;
    resetObj.expl@#;
    % we reconstruct the standard ties
    @#nsubobjties_:=0;
    StandardTies;
  fi;
enddef;

%=====================================================================
% |Matrix| class

% |Matrix|: Generic Matrix
% |@#| is a name for an object (must be a suffix)
% |@#| will be the number of the object, but will also be used
% as a prefix for other variables.
vardef newMatrix@#(expr Nx,Ny)(text elements) text options =
  ExecuteOptions(@#)(options);
  assignObj(@#,"Matrix");
  StandardInterface;
  save i,eq;numeric i;string eq;
  ObjSubArray(sb)(Nx*Ny);
  ObjNumeric nx,ny;
  setNumeric(nx)(Nx);
  setNumeric(ny)(Ny);
  ObjNumericArray(wd)(Ny);
  ObjNumericArray(ht)(Nx);
  
  i=0;
  forsuffixes $:=elements:i:=i+1;
    if $<>0: % null box
      SubObjectOfArray(sb[i],$);
    fi;
  endfor;

  % We compute for each column, which element is the widest,
  % and for each line, which one is the tallest; the indices
  % are stored in the |wd| and |ht| arrays:
  % This assumes that there is at least one object in each column
  % and line.
  % First, the tallest elements in each line:
  if OptionValue@#("matrixnodevsize")<0:
    for i:=1 upto Nx:
      % find the first column which contains an object and initialize
      % |@#ht[i]| to its index:
      @#ht[i]=0;
      for k:=1 upto Ny:
        if known @#sb[(i-1)*Ny+k]: @#ht[i]:=k;fi;
        exitif @#ht[i]=k;
      endfor;
      for j:=@#ht[i]+1 upto Ny:
        if known @#sb[(i-1)*Ny+j]:
          if ypart(obj(@#sb[(i-1)*Ny+j]).n-obj(@#sb[(i-1)*Ny+j]).s)>
            ypart(obj(@#sb[(i-1)*Ny+@#ht[i]]).n-obj(@#sb[(i-1)*Ny+@#ht[i]]).s):
            @#ht[i]:=j;
          fi;
        fi;
      endfor;
      @#ht[i]:=(i-1)*Ny+@#ht[i];
    endfor;
  else:
    for i:=1 upto Nx:
      @#ht[i]=1+(i-1)*Ny; % bug corrected on October 5, 2005
    endfor;
  fi;
  
  % Then, the widest elements in each column:
  if OptionValue@#("matrixnodehsize")<0:
    for i:=1 upto Ny:
      @#wd[i]=0;
      % find the first line which contains an object and initialize
      % |@#wd[i]| to its index:
      for k:=1 upto Nx:
        if known @#sb[(k-1)*Ny+i]: @#wd[i]:=k;fi;
        exitif @#wd[i]=k;
      endfor;
      for j:=@#wd[i]+1 upto Nx:
        if known @#sb[(j-1)*Ny+i]:
          if xpart(obj(@#sb[(j-1)*Ny+i]).e-obj(@#sb[(j-1)*Ny+i]).w)>
            xpart(obj(@#sb[(@#wd[i]-1)*Ny+i]).e-obj(@#sb[(@#wd[i]-1)*Ny+i]).w):
            @#wd[i]:=j;
          fi;
        fi;
      endfor;
      @#wd[i]:=(@#wd[i]-1)*Ny+i;
    endfor;
  else:
    for i:=1 upto Ny:
      @#wd[i]=i; % bug corrected on October 5, 2005
    endfor;
  fi;
  % The basic equations are:
  % horizontally:
  %   |xpart(sb[wd(1)].w-@#w)=5mm;|
  %   |xpart(@#e-sb[wd(ny)].e)=5mm;|
  %   |for i=1 upto ny-1|
  %     |xpart(sb[wd(i+1)].w-sb[wd(i)].e)=5mm;| ****
  %   |for i=1 upto ny|
  %     |for j=1 upto nx|
  %       |xpart(sb[(j-1)*ny+i].c)=xpart(sb[wd(i)].c)|
  % vertically:
  %   |ypart(@#n-sb[ht(1)].n)=5mm;|
  %   |ypart(sb[ht(nx)].s-@#s)=5mm;|
  %   |for i=1 upto nx-1|
  %     |ypart(sb[ht(i)].s-sb[ht(i+1)].n)=5mm;| ****
  %   |for i=1 upto ny|
  %     |for j=1 upto nx|
  %       |ypart(sb[(j-1)*ny+i].c)=ypart(sb[ht(j)].c)|
  %
  %  `****' shows where matrixnode(h/v)size needs to be taken into account
  %  These two equations become:
  %    |xpart(sb[wd(i+1)].c-sb[wd(i)].c)=matrixnodehsize;|
  %    |ypart(sb[ht(i)].c-sb[ht(i+1)].c)=matrixnodevsize;|
  %
  % By not hardwiring the widest and tallest elements
  % we allow ourselves the possibility to replace elements
  % and still have the size adjusted (after resetting the object).
  % The only assumption is that there is always at least one non null
  % object in each column and each line.
  
  eq:="save fal_;" &
      "vardef fal_(expr i,s)=" &
        "save l;" &
        "hide(l=length(s);)" &
        "substring if i>l: (l-1,l) else: (i-1,i) fi of s " &
      "enddef; " &
  if OptionValue@#("matrixnodehsize")>=0:
      "xpart(obj(@#sb[@#wd[1]]).c-@#w)=" &
          decimal (OptionValue@#("matrixnodehsize")/2+OptionValue@#("dx")) &";" &
      "xpart(@#e-obj(@#sb[@#wd[@#ny]]).c)=" &
          decimal (OptionValue@#("matrixnodehsize")/2+OptionValue@#("dx")) &";" &
  else:
      "xpart(obj(@#sb[@#wd[1]]).w-@#w)=" & decimal (OptionValue@#("dx")) &";" &
      "xpart(@#e-obj(@#sb[@#wd[@#ny]]).e)=" &
                                           decimal (OptionValue@#("dx")) &";" &
  fi
      "for i:=1 upto @#ny-1:";
  if OptionValue@#("matrixnodehsize")>=0:
    eq:=eq &
        "xpart(obj(@#sb[@#wd[i+1]]).c-obj(@#sb[@#wd[i]]).c)=" &
	                              decimal (OptionValue@#("matrixnodehsize")) &";";	
  else:
    eq:=eq &
        "xpart(obj(@#sb[@#wd[i+1]]).w-obj(@#sb[@#wd[i]]).e)=" &
                                      decimal (OptionValue@#("hsep")) &";";
  fi;
  eq:=eq &                     
      "endfor;" &
      "for i:=1 upto @#ny:" &
        "for j:=1 upto @#nx:" &
          "if ((j-1)*@#ny+i<>@#wd[i]) and (known @#sb[(j-1)*@#ny+i]):" &
             "xpart(obj(@#sb[(j-1)*@#ny+i]).sc_(fal_(i," &
                      quote(OptionValue@#("halign")) & ")))" &
            "=xpart(obj(@#sb[@#wd[i]]).sc_(fal_(i," &
                      quote(OptionValue@#("halign")) & ")));" &
          "fi;" &
        "endfor;" &
      "endfor;" &
  if OptionValue@#("matrixnodevsize")>=0:
      "ypart(@#n-obj(@#sb[@#ht[1]]).c)=" &
         decimal (OptionValue@#("matrixnodevsize")/2+OptionValue@#("dy")) &";" &
      "ypart(obj(@#sb[@#ht[@#nx]]).c-@#s)=" &
         decimal (OptionValue@#("matrixnodevsize")/2+OptionValue@#("dy")) &";" &
  else:
      "ypart(@#n-obj(@#sb[@#ht[1]]).n)=" & decimal (OptionValue@#("dy")) &";" &
      "ypart(obj(@#sb[@#ht[@#nx]]).s-@#s)=" &
                                           decimal (OptionValue@#("dy")) &";" &
  fi
      "for i:=1 upto @#nx-1:";
  if OptionValue@#("matrixnodevsize")>=0:
    eq:=eq &
      "ypart(obj(@#sb[@#ht[i]]).c-obj(@#sb[@#ht[i+1]]).c)=" &
                              decimal (OptionValue@#("matrixnodevsize")) &";";
  else:
    eq:=eq &
      "ypart(obj(@#sb[@#ht[i]]).s-obj(@#sb[@#ht[i+1]]).n)=" &
                                         decimal (OptionValue@#("vsep")) &";";
  fi;
    eq:=eq &
      "endfor;" &
      "for i:=1 upto @#ny:" &
        "for j:=1 upto @#nx:" &
          "if ((j-1)*@#ny+i<>@#ht[j]) and (known @#sb[(j-1)*@#ny+i]):" &
              "ypart(obj(@#sb[(j-1)*@#ny+i]).sc_(fal_(i," &
                      quote(OptionValue@#("valign")) & ")))" &
             "=ypart(obj(@#sb[@#ht[j]]).sc_(fal_(i," &
                      quote(OptionValue@#("valign")) & ")));" &
          "fi;" &  
        "endfor;" &
      "endfor;";
    ObjCode StandardEquations,eq;
  StandardTies;
enddef;

streamline("Matrix")("(expr nx,ny)(text sublist)",
                     "(nx,ny)suffixlist(sublist)");

def BpathMatrix(suffix n)= StandardBpath(n) enddef;

def drawMatrix(suffix n)=
  drawFramedOrFilledObject_(n);
  drawObjArray(n)(sb);
  drawMemorizedPaths_(n);
enddef;

% Default values of |Matrix|:
setObjectDefaultOption("Matrix")("dx")(0mm);
setObjectDefaultOption("Matrix")("dy")(0mm);
setObjectDefaultOption("Matrix")("hsep")(1mm);
setObjectDefaultOption("Matrix")("vsep")(1mm);
setObjectDefaultOption("Matrix")("halign")("c");
setObjectDefaultOption("Matrix")("valign")("c");
setObjectDefaultOption("Matrix")("framed")(false);
setObjectDefaultOption("Matrix")("filled")(false);
setObjectDefaultOption("Matrix")("fillcolor")(black);
setObjectDefaultOption("Matrix")("framewidth")(.5bp);
setObjectDefaultOption("Matrix")("framecolor")(black);
setObjectDefaultOption("Matrix")("framestyle")("");
setObjectDefaultOption("Matrix")("shadow")(false); % no shadow by default
setObjectDefaultOption("Matrix")("shadowcolor")(black);
setObjectDefaultOption("Matrix")("matrixnodehsize")(-1pt);
setObjectDefaultOption("Matrix")("matrixnodevsize")(-1pt);


% Some special functions on matrices:

% This function replaces the element at position (i,j) by element |rep|
% Since we call |resetObj.expl|, this function cancels transformations.
% However, the new matrix has its equations correctly applied
% to the new object.
% |i| is the line, |j| the column
% It is possible to create new columns or new lines by giving to
% |i| (or |j|) the value of the number of lines (or columns) plus one.
vardef replaceMatrixElement.expl@#(expr i,j)(suffix rep)=
  % first, we reset the object in order to be sure we have its right
  % dimensions when we try to update  |ht[i]| and |wd[j]|
  resetObj.expl@#;

  % first, see if a new column or a new line are needed
  if i=@#nx+1:
    if (j>0) and (j<=@#ny):
      % create new line
      @#nx:=@#nx+1;
      @#sb.n_:=@#nx*@#ny;

      % increase size of |@#ht[]| array
      @#ht.n_:=@#nx;
      
      @#ht[i]=(i-1)*@#ny+j;
      if xpart(rep.e-rep.w)>xpart(obj(@#sb[@#wd[j]]).e-obj(@#sb[@#wd[j]]).w):
        @#wd[j]:=(i-1)*@#ny+j;
      fi;
      % we replace the string representing the subobject
      @#sb[(i-1)*@#ny+j]:= str rep;
      % we reset the object again, this time in order to take the changes
      % to |ht[i]| and |wd[j]| into account
      resetObj.expl@#;
      
    elseif j=@#ny+1:
      % in this case, we create a new line and a new column
      % first, a new column:
      addmatrixcolumn_@#;
      
      % create new line
      @#nx:=@#nx+1;
      @#sb.n_:=@#nx*@#ny;
      % increase sizes of |@#ht[]| array
      @#ht.n_:=@#nx;

      % we now update |@#ht| and |@#wd| because of the new object;
      % this is easy, because the object is alone on its line and column.
      @#ht[@#nx]:=@#nx*@#ny;
      @#wd[@#ny]:=@#nx*@#ny;
      % we add the subobject:
      @#sb[@#nx*@#ny]:= str rep;
      % and we reset the object

      resetObj.expl@#;
    else:
      errmessage "Column number out of range";
    fi;
  elseif (i>@#nx+1) or (i<1):
    errmessage "Line number out of range";
  else:
    if (j>0) and (j<=@#ny):
      % AVERAGE CASE
      % we replace the string representing the subobject
      @#sb[(i-1)*@#ny+j]:= str rep;
      % we recompute the |ht[i]| and |wd[j]| values; since it is possible
      % that we replace the largest element by a smaller one, the new largest
      % element can be different from both the previous largest and the
      % new element; so, in order to simplify the code, we recompute
      % |ht[i]| and |wd[j]| from scratch.
      @#ht[i]:=(i-1)*@#ny+j; % we are sure this element exists
      updateHeight_@#(i);
      @#wd[j]:=(i-1)*@#ny+j; % we are sure this element exists
      updateWidth_@#(j);
      % we reset the object again, this time in order to take the changes
      % to |ht[i]| and |wd[j]| into account
      resetObj.expl@#;
      
    elseif j=@#ny+1:
      addmatrixcolumn_@#;
      @#sb.n_:=@#nx*@#ny;

      % we now update |@#ht| and |@#wd| because of the new object;
      % the width is easy, because the object is alone on its column.
      
      @#wd[@#ny]:=i*@#ny;

      % for the height, we update |@#ht[i]|:
      if ypart(rep.n-rep.s) > ypart(obj(@#sb[@#ht[i]]).n-obj(@#sb[@#ht[i]]).s):
        @#ht[i]:=i*@#ny;
      fi;
      
      % we add the subobject:
      @#sb[i*@#ny]:= str rep;
      % and we reset the object
      resetObj.expl@#;
    else:
      errmessage "Column number out of range";
    fi;
  fi;
enddef;

% This function is only used by |replaceMatrixElement.expl|
vardef addmatrixcolumn_@#=
  % create a new column
  for k:=@#nx downto 1:
    for l:=@#ny downto 1:
      if known @#sb[(k-1)*@#ny+l]:
        @#sb[(k-1)*(@#ny+1)+l]:=@#sb[(k-1)*@#ny+l];
      else:
        @#sb[(k-1)*(@#ny+1)+l]:=whateverstring;
      fi;
    endfor;
  endfor;
  % we must also refresh the new column:
  for k:= 1 upto @#nx:
    @#sb[k*(@#ny+1)]:=whateverstring;
  endfor;

  % The values of |@#ht[i]| and |@#wd[i]| are now incorrect
  % because of the new column that changed the indices.
  %
  for k:=1 upto @#nx:
    @#ht[k]:=@#ht[k]+((@#ht[k]-1) div @#ny);
  endfor;
  for k:=1 upto @#ny:
    @#wd[k]:=@#wd[k]+((@#wd[k]-1) div @#ny);
  endfor;    
  @#ny:=@#ny+1;
  % increase sizes of |@#wd[]| array
  @#wd.n_:=@#ny;
enddef;


% This function is only used by |replaceMatrixElement.expl|
vardef updateHeight_@#(expr i)=
  for k:=1 upto @#ny:
    if known @#sb[(i-1)*@#ny+k]:
      if @#ht[i]>0:
        if ypart(obj(@#sb[(i-1)*@#ny+k]).n-obj(@#sb[(i-1)*@#ny+k]).s)>
           ypart(obj(@#sb[@#ht[i]]).n-obj(@#sb[@#ht[i]]).s):
          @#ht[i]:=(i-1)*@#ny+k;
        fi;
      else:
         @#ht[i]:=(i-1)*@#ny+k;     
      fi;
    fi;
  endfor;
enddef;
    
% This function is only used by |replaceMatrixElement.expl|
vardef updateWidth_@#(expr j)=
  for k:=1 upto @#nx:
    if known @#sb[(k-1)*@#ny+j]:
      if @#wd[j]>0:
        if xpart(obj(@#sb[(k-1)*@#ny+j]).e-obj(@#sb[(k-1)*@#ny+j]).w)>
           xpart(obj(@#sb[@#wd[j]]).e-obj(@#sb[@#wd[j]]).w):
          @#wd[j]:=(k-1)*@#ny+j;
        fi;
      else:
        @#wd[j]:=(k-1)*@#ny+j;
      fi;
    fi;
  endfor;
enddef;

% Delete matrix element (i,j). In certain cases, we reduce the number
% of columns or lines.
% We assume that after deletion the matrix is not empty.
vardef deleteMatrixElement.expl@#(expr i,j)=
  % The easy case is when the element we want to remove was neither
  % alone on its line, nor on its column
  if isaloneoncolumn_@#(i,j):
    if isaloneonline_@#(i,j): % case 1 (toughest case)
      % Here, we have to shift up to three whole blocks of the matrix
      for k:=1 upto (@#nx-1)*(@#ny-1):
        if known @#sb[transfer_@#(k,@#nx-1,@#ny-1,i,j)]:
          @#sb[k]:=@#sb[transfer_@#(k,@#nx-1,@#ny-1,i,j)];
        else:
          @#sb[k]:=whateverstring;
        fi;
      endfor;
      
      % the last column and line must be refreshed
      for k:=(@#nx-1)*(@#ny-1)+1 upto @#nx*@#ny:
        @#sb[k]:=whateverstring;
      endfor;
      
      % |@#wd[]| and |@#ht[]| must be updated,
      % as well as their number of elements.
      for k:=1 upto i-1:
        @#ht[k]:=transferi_@#(@#ht[k],@#nx-1,@#ny-1,i,j);
      endfor;
      for k:=i+1 upto @#nx:
        @#ht[k-1]:=transferi_@#(@#ht[k],@#nx-1,@#ny-1,i,j);
      endfor;
      for k:=1 upto j-1:
        @#wd[k]:=transferi_@#(@#wd[k],@#nx-1,@#ny-1,i,j);
      endfor;
      for k:=j+1 upto @#ny:
        @#wd[k-1]:=transferi_@#(@#wd[k],@#nx-1,@#ny-1,i,j);
      endfor;

      % |@#nx| and |@#ny| must be updated
      @#nx:=@#nx-1;@#ny:=@#ny-1;
      @#sb.n_:=@#nx*@#ny;
  
      @#ht.n_:=@#ht.n_-1;@#wd.n_:=@#wd.n_-1;

    else: % case 2: we remove column |j|
      for k:=1 upto @#nx*(@#ny-1):
        if known @#sb[transfer_@#(k,@#nx,@#ny-1,@#nx+1,j)]:
          @#sb[k]:=@#sb[transfer_@#(k,@#nx,@#ny-1,@#nx+1,j)];
        else:
          @#sb[k]:=whateverstring;
        fi;
      endfor;
      % the last column must be refreshed
      for k:=@#nx*(@#ny-1)+1 upto @#nx*@#ny:
        @#sb[k]:=whateverstring;
      endfor;

      % |@#wd[]| and |@#ht[]| must be updated,
      % as well as their number of elements.
      for k:=1 upto @#nx:
        @#ht[k]:=transferi_@#(@#ht[k],@#nx,@#ny-1,@#nx+1,j);
      endfor;
      % SPECIAL TREATMENT FOR |@#ht[i]|:
      @#ht[i]:=0;updateHeight_@#(i);
      
      for k:=1 upto j-1:
        @#wd[k]:=transferi_@#(@#wd[k],@#nx,@#ny-1,@#nx+1,j);
      endfor;
      for k:=j+1 upto @#ny:
        @#wd[k-1]:=transferi_@#(@#wd[k],@#nx,@#ny-1,@#nx+1,j);
      endfor;

      % |@#ny| must be updated
      @#ny:=@#ny-1;
      @#sb.n_:=@#nx*@#ny;
  
      @#wd.n_:=@#wd.n_-1;
      
    fi;
  else:
    if isaloneonline_@#(i,j): % case 3: we remove line |i|
      for k:=1 upto (@#nx-1)*@#ny:
        if known @#sb[transfer_@#(k,@#nx-1,@#ny,i,@#ny+1)]:
          @#sb[k]:=@#sb[transfer_@#(k,@#nx-1,@#ny,i,@#ny+1)];
        else:
          @#sb[k]:=whateverstring;
        fi;
      endfor;
      
      % the last line must be refreshed
      for k:=(@#nx-1)*@#ny+1 upto @#nx*@#ny:
        @#sb[k]:=whateverstring;
      endfor;
      
      % |@#wd[]| and |@#ht[]| must be updated,
      % as well as their number of elements.
      for k:=1 upto i-1:
        @#ht[k]:=transferi_@#(@#ht[k],@#nx-1,@#ny,i,@#ny+1);
      endfor;
      for k:=i+1 upto @#nx:
        @#ht[k-1]:=transferi_@#(@#ht[k],@#nx-1,@#ny,i,@#ny+1);
      endfor;
      for k:=1 upto @#ny:
        @#wd[k]:=transferi_@#(@#wd[k],@#nx-1,@#ny,i,@#ny+1);
        % SPECIAL TREATMENT FOR |@#wd[j]|:
      endfor;
      @#wd[j]:=0;updateWidth_@#(j);
      % |@#nx| and |@#ny| must be updated
      @#nx:=@#nx-1;
      @#sb.n_:=@#nx*@#ny;
  
      @#ht.n_:=@#ht.n_-1;
 
    else: % case 4 (easiest case)
      % we cancel the subobject
      @#sb[(i-1)*@#ny+j]:=whateverstring;
      % and we recompute the |@#ht[i]| and |@#wd[j]| values:
      @#ht[i]:=0;updateHeight_@#(i);
      @#wd[j]:=0;updateWidth_@#(j);
    fi;
  fi;
  resetObj.expl@#;
enddef;

% This function is only used by |deleteMatrixElement.expl|
% Given a slot |n| in a matrix |nnx|$\times$|nny|, where |nnx=@#nx| or
% |@#nx-1|, and |nny=@#ny| or |@#ny-1|, this function finds
% the slot number from the matrix |@#nx|$\times$|@#ny|.
% |i| and |j| are the missing line and column indexes
% If either |i| or |j| is equal to 0, only a line or only a column is missing.
vardef transfer_@#(expr n,nnx,nny,i,j)=
  save l,c,res;
  hide(
    % line and column of |n|:
    l=((n-1) div nny)+1;
    c=n-(l-1)*nny;
    if i*j>0:
      if (l>=1) and (l<i):
        if c<j: res=(l-1)*@#ny+c;
        else: res=(l-1)*@#ny+c+1;
        fi;
      elseif (l>=i):
        if c<j: res=l*@#ny+c;
        else: res=l*@#ny+c+1;
        fi;
      else:
        errmessage "Function not defined";
      fi;
    else:
      errmessage "This should not happen";
    fi;
  ) res
enddef;

% This is an inverse to |transfer_|.
% |n| is an index in the |@#nx|$\times$|@#ny| matrix,
% the new matrix is |nnx|$\times$|nny| and |i| and |j| are the cuts.
% The function returns the index in the new matrix.
vardef transferi_@#(expr n,nnx,nny,i,j)=
  save l,c,res;
  hide(
    % line and column of |n|:
    l=((n-1) div @#ny)+1;
    c=n-(l-1)*@#ny;
    % FIRST, THE CASE WHERE |i|*|j|>0:
    if i*j>0:
      if (l>=1) and (l<i):
        if c<j: res=(l-1)*nny+c;
        else: res=(l-1)*nny+c-1;
        fi;
      elseif (l>=i):
        if c<j: res=(l-2)*nny+c;
        else: res=(l-2)*nny+c-1;
        fi;
      else:
        errmessage "Function not defined";
      fi;
    else:
      errmessage "This should not happen";
    fi;
  ) res
enddef;

% This function is only used by |deleteMatrixElement.expl|
vardef isaloneoncolumn_@#(expr i,j)=
  save res;boolean res;res=true;
  for k:=1 upto @#nx:
    if (k<>i) and (known @#sb[(k-1)*@#ny+j]):
      res:=false;
    fi;
  endfor;
  res
enddef;

% This function is only used by |deleteMatrixElement.expl|
vardef isaloneonline_@#(expr i,j)=
  save res;boolean res;res=true;
  for k:=1 upto @#ny:
    if (k<>j) and (known @#sb[(i-1)*@#ny+k]):
      res:=false;
    fi;
  endfor;
  res
enddef;

% add brackets to an object
% the left bracket is |left| and the right bracket is |right|
vardef bracketit.expl(suffix $)(expr left,right)=
  save ratio;numeric ratio;
  ratio=ypart($n-$s)/ypart(urcorner left-lrcorner left);
  settodefaultifnotknown_("labshift")(pair)
             ((-.5ratio*xpart(urcorner left-ulcorner left),0));
  ObjLabel.$(left scaled ratio) "labpoint(w)";
  ratio:=ypart($n-$s)/ypart(urcorner right-lrcorner right);
  o_labshift_val:=(.5ratio*xpart(urcorner right-ulcorner right),0);
  ObjLabel.$(right scaled ratio) "labpoint(e)";
enddef;

%=====================================================================
% Definitions specific to the |EmptyBox| class

% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
vardef newEmptyBox@#(expr dx,dy) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"EmptyBox");
  StandardInterface;
  ObjCode StandardEquations,
          "@#ise-@#isw=(" & decimal dx & ",0)", 
          "@#ine-@#ise=(0," & decimal dy & ")"; 
enddef;

% shortcut (PSTricks compatibility)
def Tn=
  new_EmptyBox(0,0)
enddef;

streamline("EmptyBox")("(expr dx,dy)","(dx,dy)");

def BpathEmptyBox(suffix n)=StandardBpath(n) enddef;

def drawEmptyBox(suffix n)=
  if show_empty_boxes:
    drawFramedOrFilledObject_(n);
  fi;
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("EmptyBox")("filled")(false);
setObjectDefaultOption("EmptyBox")("fillcolor")(black);
setObjectDefaultOption("EmptyBox")("framed")(false);
setObjectDefaultOption("EmptyBox")("framewidth")(.5bp);
setObjectDefaultOption("EmptyBox")("framecolor")(black);
setObjectDefaultOption("EmptyBox")("framestyle")("");
setObjectDefaultOption("EmptyBox")("shadow")(false); % no shadow by default
setObjectDefaultOption("EmptyBox")("shadowcolor")(black);


% |HRazor| and |VRazor| are just wrappers around the |EmptyBox| class
vardef newHRazor@#(expr dx) text options =newEmptyBox@#(dx,0) options enddef;
vardef new_HRazor(expr dx)= new_EmptyBox(dx,0) enddef;
vardef newVRazor@#(expr dy) text options =newEmptyBox@#(0,dy) options enddef;
vardef new_VRazor(expr dy)= new_EmptyBox(0,dy) enddef;

% Moreover, we define two handy abbreviations for the streamlined versions:
def HR(expr dx)=new_HRazor(dx) enddef;
def VR(expr dy)=new_VRazor(dy) enddef;

%=====================================================================
% Definitions specific to the |RandomBox| class
% A class ``|RandomBox|'' with four random points. 

% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
% |wd| is the width, |ht| the height, and |dx| and |dy| are
% maximum allowed variations. Then to each point are
% added |(uniformdeviate(dx),uniformdeviate(dy))|
vardef newRandomBox@#(expr wd,ht,dx,dy) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"RandomBox");
  StandardInterface;
  % The random calculations are done only once, when the object
  % is created. So, there are no problems for duplicating such
  % an object.
  ObjCode MinimumStandardEquations,
    "xpart(@#ine)-xpart(@#inw)=" & decimal (wd+uniformdeviate(dx)-dx/2),
    "xpart(@#ise)-xpart(@#inw)=" & decimal (wd+uniformdeviate(dx)-dx/2),
    "xpart(@#isw)-xpart(@#inw)=" & decimal (uniformdeviate(dx)-dx/2),
    "ypart(@#inw)-ypart(@#ine)=" & decimal (uniformdeviate(dy)-dy/2),
    "ypart(@#inw)-ypart(@#ise)=" & decimal (ht+uniformdeviate(dy)-dy/2),
    "ypart(@#inw)-ypart(@#isw)=" & decimal (ht+uniformdeviate(dy)-dy/2);
enddef;

streamline("RandomBox")("(expr wd,ht,dx,dy)","(wd,ht,dx,dy)");

def BpathRandomBox(suffix n)=StandardBpath(n) enddef;

def drawRandomBox(suffix n)=
  drawFramedOrFilledObject_(n);
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("RandomBox")("filled")(false);
setObjectDefaultOption("RandomBox")("fillcolor")(black);
setObjectDefaultOption("RandomBox")("framed")(true);
setObjectDefaultOption("RandomBox")("framewidth")(.5bp);
setObjectDefaultOption("RandomBox")("framecolor")(black);
setObjectDefaultOption("RandomBox")("framestyle")("");
setObjectDefaultOption("RandomBox")("shadow")(false); % no shadow by default
setObjectDefaultOption("RandomBox")("shadowcolor")(black);

%=====================================================================
% Definitions specific to the |RecursiveBox| class
% A class ``|RecursiveBox|'' with four points. 

% A constructor initializing a box containing |n| levels of itself.
% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
vardef newRecursiveBox@#(expr n) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"RecursiveBox");
  StandardInterface;
  % we create a subobject only when |n|>0
  if n>0:
    % we find a name for the subobject:
    SubObject(sub,obj(newobjstring_));
    % and we continue to create the hierarchy:
    newRecursiveBox.obj(@#sub)(n-1);
    rotateObj(obj(@#sub),OptionValue@#("rotangle"));
    % the equations are slightly adapted from |newBB|:
    ObjCode StandardEquations,
     "save lftmost,rtmost,topmost,botmost;",
     "string lftmost,rtmost,topmost,botmost;",
     "lftmost=find_lft_most.obj(@#sub);",
     "rtmost =find_rt_most.obj(@#sub);",
     "topmost=find_top_most.obj(@#sub);",
     "botmost=find_bot_most.obj(@#sub);",
     "xpart(@#inw)=xpart(obj(@#sub).obj(lftmost));",
     "xpart(@#ine)=xpart(obj(@#sub).obj(rtmost));",
     "ypart(@#inw)=ypart(obj(@#sub).obj(topmost));",
     "ypart(@#isw)=ypart(obj(@#sub).obj(botmost));";
  else:
    ObjCode StandardEquations,
      "@#ise-@#isw=(" & decimal (OptionValue@#("dx")) & ",0)", 
      "@#ine-@#ise=(0," & decimal (OptionValue@#("dy")) & ")";
  fi;
  StandardTies;
enddef;

streamline("RecursiveBox")("(expr n)","(n)");

def BpathRecursiveBox(suffix n)=StandardBpath(n) enddef;

def drawRecursiveBox(suffix n)=
  drawFramedOrFilledObject_(n);
  if known n.sub:  
    drawObj(obj(n.sub));
  fi;
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("RecursiveBox")("filled")(false);
setObjectDefaultOption("RecursiveBox")("fillcolor")(black);
setObjectDefaultOption("RecursiveBox")("framed")(true);
setObjectDefaultOption("RecursiveBox")("framewidth")(.5bp);
setObjectDefaultOption("RecursiveBox")("framecolor")(black);
setObjectDefaultOption("RecursiveBox")("framestyle")("");
setObjectDefaultOption("RecursiveBox")("dx")(5cm);
setObjectDefaultOption("RecursiveBox")("dy")(5cm);
setObjectDefaultOption("RecursiveBox")("rotangle")(10);
setObjectDefaultOption("RecursiveBox")("shadow")(false); % no shadow by default
setObjectDefaultOption("RecursiveBox")("shadowcolor")(black);

%=====================================================================
% Definitions specific to the |VonKochFlake| class
% This class draws a generic Von Koch flake.

% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
vardef newVonKochFlake@#(expr n) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"VonKochFlake");
  StandardInterface;
  % define a triangle
  ObjPoint A,B,C;
  save p;
  pair p[];
  % Compute the three vertices:
  p2-p1=(10cm,0);p3-p1=(p2-p1) rotated 60;
  % we create subobjects only when |n|>0
  if n>0:
    % we find names for the three subobjects
    %  (one for each side of the triangle)
    SubObject(suba,obj(newobjstring_));
    SubObject(subb,obj(newobjstring_));
    SubObject(subc,obj(newobjstring_));
    % and we continue to create the hierarchy:
    newVonKochSide.obj(@#suba)(p1,p2,n-1);
    newVonKochSide.obj(@#subb)(p2,p3,n-1);
    newVonKochSide.obj(@#subc)(p3,p1,n-1);
    ObjCode StandardEquations,
      "@#B-@#A=(" & decimal xpart(p2-p1) & "," & decimal ypart(p2-p1) & ")",
      "@#C-@#A=(" & decimal xpart(p3-p1) & "," & decimal ypart(p3-p1) & ")",
      "@#A=@#isw","@#B=@#ise", "ypart(@#C)=ypart(@#inw)",
      "@#A=obj(@#suba).A=obj(@#subc).E",
      "@#B=obj(@#suba).E=obj(@#subb).A",
      "@#C=obj(@#subb).E=obj(@#subc).A";
  else:    
    ObjCode StandardEquations,
      "@#B-@#A=(" & decimal xpart(p2-p1) & "," & decimal ypart(p2-p1) & ")",
      "@#C-@#A=(" & decimal xpart(p3-p1) & "," & decimal ypart(p3-p1) & ")",
      "@#A=@#isw","@#B=@#ise","ypart(@#C)=ypart(@#inw)";
  fi;
  StandardTies;
enddef;

streamline("VonKochFlake")("(expr n)","(n)");

def BpathVonKochFlake(suffix n)=n.A--n.B--n.C--cycle enddef;

def drawVonKochFlake(suffix n)=
  if known n.suba:drawObj(obj(n.suba));else: draw n.A--n.B;fi;
  if known n.subb:drawObj(obj(n.subb));else: draw n.B--n.C;fi;
  if known n.subc:drawObj(obj(n.subc));else: draw n.C--n.A;fi;
  drawMemorizedPaths_(n);
enddef;

%=====================================================================
% Definitions specific to the |VonKochSide| class
% This class draws a generic Von Koch flake side.

% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
vardef newVonKochSide@#(expr pa,pb,n) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"VonKochSide");
  StandardInterface;
  % define a triangle
  ObjPoint A,B,C,D,E;
  save p;
  pair p[];
  % Compute the five vertices:
  p1=pa;p5=pb;p2-p1=p4-p2=p5-p4=(p4-p3) rotated -60=(p3-p2) rotated 60;
  % we create subobjects only when |n|>0
  if n>0:
    % we find names for the four subobjects
    %  (one for each of the subdivision of the sides)
    SubObject(suba,obj(newobjstring_));
    SubObject(subb,obj(newobjstring_));
    SubObject(subc,obj(newobjstring_));
    SubObject(subd,obj(newobjstring_));
    % and we continue to create the hierarchy:
    newVonKochSide.obj(@#suba)(p1,p2,n-1);
    newVonKochSide.obj(@#subb)(p2,p3,n-1);
    newVonKochSide.obj(@#subc)(p3,p4,n-1);
    newVonKochSide.obj(@#subd)(p4,p5,n-1);
    ObjCode StandardEquations,
      "@#B-@#A=(" & decimal xpart(p2-p1) & "," & decimal ypart(p2-p1) & ")",
      "@#C-@#A=(" & decimal xpart(p3-p1) & "," & decimal ypart(p3-p1) & ")",
      "@#D-@#A=(" & decimal xpart(p4-p1) & "," & decimal ypart(p4-p1) & ")",
      "@#E-@#A=(" & decimal xpart(p5-p1) & "," & decimal ypart(p5-p1) & ")",
      "@#isw=@#A","@#ine=@#E",
      "@#A=obj(@#suba).A",
      "@#B=obj(@#suba).E=obj(@#subb).A",
      "@#C=obj(@#subb).E=obj(@#subc).A",
      "@#D=obj(@#subc).E=obj(@#subd).A",
      "@#E=obj(@#subd).E";
  else:
    ObjCode StandardEquations,
      "@#B-@#A=(" & decimal xpart(p2-p1) & "," & decimal ypart(p2-p1) & ")",
      "@#C-@#A=(" & decimal xpart(p3-p1) & "," & decimal ypart(p3-p1) & ")",
      "@#D-@#A=(" & decimal xpart(p4-p1) & "," & decimal ypart(p4-p1) & ")",
      "@#E-@#A=(" & decimal xpart(p5-p1) & "," & decimal ypart(p5-p1) & ")",
      "@#isw=(xpart(@#A),ypart(@#A))", "@#ine=(xpart(@#E),ypart(@#E))";
  fi;
  StandardTies;
enddef;

streamline("VonKochSide")("(expr pa,pb,n)","(pa,pb,n)");

def BpathVonKochSide(suffix n)=n.A--n.B--n.C--n.D--n.E enddef;

def drawVonKochSide(suffix n)=
  if known n.suba:drawObj(obj(n.suba));else: draw n.A--n.B;fi;
  if known n.subb:drawObj(obj(n.subb));else: draw n.B--n.C;fi;
  if known n.subc:drawObj(obj(n.subc));else: draw n.C--n.D;fi;
  if known n.subd:drawObj(obj(n.subd));else: draw n.D--n.E;fi;
  drawMemorizedPaths_(n);
enddef;

%=====================================================================
% Definitions specific to the |Box| class
% A class ``Box'' with four points. 

% A constructor initializing the variable |p| (picture)
% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
% |v| is either a picture, a string or an object given by its number
vardef newBox@#(expr v) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"Box");
  StandardInterface;
  StandardObjectOrPictureContainerSetup(v);
  if OptionValue@#("rbox_radius")>0:
    ObjPoint ene,ese,sse,ssw,wsw,wnw,nnw,nne;
    % we use paths for the rounded corners if necessary
    addPathVariables@#(_spath_);
  fi;
  if not OptionValue@#("fit"):
    @#a:=max(@#a,@#b);@#b:=@#a; % square
  fi;
  ObjCode StandardEquations,
    if numeric v:
      ".5[@#isw,@#ine]=.5[obj(@#sub)ne,obj(@#sub)sw]", % object
    elseif (picture v) or (string v):
      ".5[@#isw,@#ine]=@#p.off", % picture offset
    fi
    if OptionValue@#("rbox_radius")>0:
      "@#ine-@#nne=@#ise-@#sse=@#nnw-@#inw=@#ssw-@#isw=(" &
        decimal (OptionValue@#("rbox_radius")) & ",0)",
      "@#ine-@#ene=@#ese-@#ise=@#inw-@#wnw=@#wsw-@#isw=(0," &
        decimal (OptionValue@#("rbox_radius")) & ")",
    fi
    "@#ise-@#isw=(" & decimal (2@#a+2*OptionValue@#("dx")) & ",0)",
    "@#ine-@#ise=(0," & decimal (2@#b+2*OptionValue@#("dy")) & ")";
  StandardTies;
  if OptionValue@#("rbox_radius")>0:
    addPath@#(_spath_,1,
      @#nnw{left}..{down}@#wnw--@#wsw{down}
      ..{right}@#ssw--@#sse{right}..{up}@#ese--@#ene{up}
      ..{left}@#nne--cycle
      );
    defineBox_pathparameters(@#);
  fi;
enddef;

def defineBox_pathparameters(suffix $)=
  $_spath_.n_:=1;
  $_spath_._draw_[1]:=LocalOptionValue("cdraw","cdraw_default");
  $_spath_.visible[1]:=true;
  $_spath_.pathfilled[1]:=false;
  $_spath_.pathfillcolor[1]:=black;
  $_spath_.border[1]:=CLOV_("border");
  $_spath_.bordercolor[1]:=CLOV_("bordercolor");
  $_spath_.linewidth[1]:=OptionValue$("framewidth");
  $_spath_.linecolor[1]:=OptionValue$("framecolor");
  $_spath_.nodesepA[1]:=0;
  $_spath_.nodesepB[1]:=0;
  $_spath_.arrows[1]:="draw";
  $_spath_.linestyle[1]:=CLOV_("linestyle");
  $_spath_.doubleline[1]:=false;
  forsuffixes $$=_draw_,visible,border,bordercolor,linewidth,linecolor,
    arrows,linestyle,nodesepA,nodesepB,doubleline,pathfilled,pathfillcolor:
    $_spath_$$n_:=1;
  endfor;
enddef;
  
def Tr_(expr p)=
  new_Box_(p)("framed(false)")
enddef;

def Tf=
  new_Box_("")("filled(true)")
enddef;

vardef newRBox@#(expr v) text options=
  newBox@#(v) "rbox_radius(1mm)", options;
enddef;

vardef new_RBox(expr v)=
  new_Box_(v)("rbox_radius(1mm)")
enddef;

streamline("Box")("(expr v)","(v)");

def BpathBox(suffix n)=
  (if OptionValue.n("rbox_radius")=0:
     StandardBpath(n)
   else:
     % good curve:
     % |cycle| was added because in certain cases, |unfill| is called
     % on the path returned by |BpathBox|.
     (Path.n(_spath_,1)--cycle)
     % bad curve:     
%     (n.nnw{n.nnw-n.nne}..{n.wsw-n.wnw}n.wnw--n.wsw{n.wsw-n.wnw}
%       ..{n.sse-n.ssw}n.ssw--n.sse{n.sse-n.ssw}
%       ..{n.ene-n.ese}n.ese--n.ene{n.ene-n.ese}
%       ..{n.nnw-n.nne}n.nne--cycle)
   fi
  )
enddef;
    
def drawBox(suffix n)=
  if OptionValue.n("rbox_radius")=0:
    drawFramedOrFilledObject_(n);
  else:
    if OptionValue.n("framed"):
      if OptionValue.n("shadow"):
        fill (BpathObj(n) shifted (1mm,-1mm))
             withcolor OptionValue.n("shadowcolor");
      fi;
      unfill BpathObj(n);
    fi;
    if OptionValue.n("filled"):
      fill BpathObj(n) withcolor OptionValue.n("fillcolor");
    fi;
  fi;
  drawPictureOrObject(n);
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("Box")("dx")(3bp); % same value as in |boxes.mp|
setObjectDefaultOption("Box")("dy")(3bp); % same value as in |boxes.mp|
setObjectDefaultOption("Box")("filled")(false);
setObjectDefaultOption("Box")("fillcolor")(black);
setObjectDefaultOption("Box")("framed")(true);
setObjectDefaultOption("Box")("shadow")(false); % no shadow by default
setObjectDefaultOption("Box")("shadowcolor")(black);
setObjectDefaultOption("Box")("fit")(true);
setObjectDefaultOption("Box")("framewidth")(.5bp);
setObjectDefaultOption("Box")("framecolor")(black);
setObjectDefaultOption("Box")("framestyle")("");
setObjectDefaultOption("Box")("rbox_radius")(0); % after rboxes.mp
setObjectDefaultOption("Box")("picturecolor")(black);


%=====================================================================
% Definitions specific to the |Polygon| class

% A polygon, either empty, or enclosing a picture or an object |v|.
% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
% |nsides| is the number of sides
vardef newPolygon@#(expr v,nsides) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"Polygon");
  StandardInterface;
  StandardObjectOrPictureContainerSetup(v);
  ObjPointArray(po)(nsides);
  % we can now use |po1|, |po2|, ..., |po[nsides]|
  ObjNumeric ns;
  setNumeric(ns)(nsides); % now, we can use |@#ns| in the |ObjCode|
  % we actually define an ellipse on which we build the polygon:
  ObjNumeric cdx,cdy; % computed dx and dy
  @#cdx=@#cdy=pathsel__(@#a,@#b)(max(@#a,@#b),OptionValue@#("polymargin"),
    (@#a+d_,0){up}...(0,@#b+d_){left});
  ObjCode StandardEquations,
    if numeric v:
      ".5[@#isw,@#ine]=.5[obj(@#sub)ne,obj(@#sub)sw]", % object
    elseif (picture v) or (string v):    
      ".5[@#isw,@#ine]=@#p.off", % picture offset
    fi
    % the size of the box is related to the size of its contents
    if OptionValue@#("fit"):
      "@#ise-@#isw=(" & decimal (2@#a+2*@#cdx) & ",0)",
      "@#ine-@#ise=(0," & decimal (2@#b+2*@#cdy) & ")",
    else:
      "@#ise-@#isw=(" & decimal(2(@#a++@#b)
                                 + OptionValue@#("polymargin")) & ",0);",
      "@#ine-@#ise=(0," & decimal(2(@#a++@#b)
                                 + OptionValue@#("polymargin")) & ");",
    fi
     "save ys,op;numeric ys;",
     "def op expr $=(.5(@#ine-@#inw)) rotated $ yscaled ys enddef;",
     if OptionValue@#("fit"):
       "ys=" & decimal((@#b+@#cdy)/(@#a+@#cdx)) & ";",
     else:
       "ys=1;",
     fi
     "save k;for k:=1 upto " & decimal nsides & ":",
     "@#po[k]-.5(@#isw+@#ine)=op (" & decimal(OptionValue@#("angle")) &
                                    "+(k-1)*(360/@#ns));",
     "endfor;";
  StandardTies;
enddef;

streamline("Polygon")("(expr v,nsides)","(v,nsides)");

def BpathPolygon(suffix n)= 
  (for i:=1 upto n.po.n_: n.po[i]--endfor cycle)
enddef;

def drawPolygon(suffix n)=
  drawFramedOrFilledObject_(n);
  drawPictureOrObject(n);
  drawMemorizedPaths_(n);
enddef;

% These are all the options that can be used with a |Polygon|.
setObjectDefaultOption("Polygon")("polymargin")(2mm); 
setObjectDefaultOption("Polygon")("angle")(0); 
setObjectDefaultOption("Polygon")("filled")(false);
setObjectDefaultOption("Polygon")("fillcolor")(black);
setObjectDefaultOption("Polygon")("framed")(true);
setObjectDefaultOption("Polygon")("fit")(true);
setObjectDefaultOption("Polygon")("framewidth")(.5bp);
setObjectDefaultOption("Polygon")("framecolor")(black);
setObjectDefaultOption("Polygon")("framestyle")("");
setObjectDefaultOption("Polygon")("picturecolor")(black);
setObjectDefaultOption("Polygon")("shadow")(false); % no shadow by default
setObjectDefaultOption("Polygon")("shadowcolor")(black);

% a few common shortcuts:
vardef newTriangle@#(expr v) text options=
  newPolygon@#(v,3) options;
enddef;

vardef newSquare@#(expr v) text options=
  newPolygon@#(v,4) options;
enddef;

vardef newPentagon@#(expr v) text options=
  newPolygon@#(v,5) options;
enddef;

vardef newHexagon@#(expr v) text options=
  newPolygon@#(v,6) options;
enddef;

vardef newHeptagon@#(expr v) text options=
  newPolygon@#(v,7) options;
enddef;

vardef newOctagon@#(expr v) text options=
  newPolygon@#(v,8) options;
enddef;

vardef newEnneagon@#(expr v) text options=
  newPolygon@#(v,9) options;
enddef;

vardef newDecagon@#(expr v) text options=
  newPolygon@#(v,10) options;
enddef;


% THESE SHORTCUTS SHOULD BE STREAMLINED (OR MAYBE NOT, TO DISCOURAGE THEIR USE
% FOR THE MORE GENERIC newPolygon)


%=====================================================================
% Definitions specific to the |Ellipse| class

% A constructor initializing the variable |p| (picture)
% |@#| is a name for a box (must be a suffix)
% |@#| will be the number of the box, but will also be used
% as a prefix for other variables.
vardef newEllipse@#(expr v) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"Ellipse");
  StandardInterface;
  StandardObjectOrPictureContainerSetup(v);
  if not OptionValue@#("fit"):
    @#a:=max(@#a,@#b);@#b:=@#a; % circle
  fi;
  ObjNumeric cdx,cdy; % computed dx and dy
  if (@#a=0) and (@#b=0):
    @#cdx=@#cdy=OptionValue@#("circmargin");
  else:
    @#cdx=@#cdy=pathsel__(@#a,@#b)(max(@#a,@#b),OptionValue@#("circmargin"),
      (@#a+d_,0){up}...(0,@#b+d_){left});
  fi;
  if not OptionValue@#("fit"):
    % we draw a circle that fits horizontally
    @#cdx:=OptionValue@#("circmargin");
    @#cdy:=@#cdx;
  fi;
  ObjCode StandardEquations,
    if numeric v:
      ".5[@#isw,@#ine]=.5[obj(@#sub)ne,obj(@#sub)sw]", % object
    elseif (picture v) or (string v):
      ".5[@#isw,@#ine]=@#p.off", % picture offset
    fi
    "@#ise-@#isw=(" & decimal (2@#a+2*@#cdx) & ",0)", 
    "@#ine-@#ise=(0," & decimal (2@#b+2*@#cdy) & ")";
  StandardTies;
enddef;

streamline("Ellipse")("(expr v)","(v)");

% shortcut (PSTricks compatibility)
def Toval_(expr p)=
  new_Ellipse(p)
enddef;

% The function drawing the ellipse uses the current transformation
% of the object to get the right shape. However, when doing so,
% we can't use the current points, since the current transformation
% applies to the initial points... We can either inverse
% the current transform (using |inverse|) or use some information
% stored on the initial status.
vardef ellipse@#(expr a_,b_,c_,d_)=
  (fullcircle 
    xscaled (2@#a+2*@#cdx)
    yscaled (2@#b+2*@#cdy)
    transformed @#ctransform_
    shifted ((a_+c_)/2)
    )  
enddef;

def BpathEllipse(suffix n)=
  ellipse.n(n.isw,n.ise,n.ine,n.inw)
enddef;

def drawEllipse(suffix n)=
  drawFramedOrFilledObject_(n);
  drawPictureOrObject(n);
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("Ellipse")("circmargin")(2bp); % same value as in |boxes.mp|
setObjectDefaultOption("Ellipse")("framed")(true);
setObjectDefaultOption("Ellipse")("filled")(false);
setObjectDefaultOption("Ellipse")("fillcolor")(black);
setObjectDefaultOption("Ellipse")("fit")(true);
setObjectDefaultOption("Ellipse")("framewidth")(.5bp);
setObjectDefaultOption("Ellipse")("framecolor")(black);
setObjectDefaultOption("Ellipse")("framestyle")("");
setObjectDefaultOption("Ellipse")("picturecolor")(black);
setObjectDefaultOption("Ellipse")("shadow")(false); % no shadow by default
setObjectDefaultOption("Ellipse")("shadowcolor")(black);


%=====================================================================
% Definitions specific to the |Circle| class

vardef newCircle@#(expr v) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"Circle");
  StandardInterface;
  StandardObjectOrPictureContainerSetup(v);
  ObjNumeric cdx,cdy; % computed dx and dy
  if (numeric v) or (picture v) or (string v): % object or picture
    % correction of bug discovered by Stephan Hennig
    %   (comp.text.tex, 2004-03-18)
    @#cdx=(@#a++@#b)+OptionValue@#("circmargin")-@#a;
    %@#cdy=(@#a++@#b)+OptionValue@#("circmargin")-@#b; % DR 23/3/2004
    @#cdy=@#cdx+@#a-@#b; % DR 23/3/2004
    %@#cdx=@#cdy=pathsel__(@#a,@#b)(max(@#a,@#b),OptionValue@#("circmargin"),
    %  (@#a+d_,0){up}...(0,@#b+d_){left});
  else:
    @#cdx=@#cdy=OptionValue@#("circmargin");
  fi;    
  ObjCode StandardEquations,
    if numeric v:
      ".5[@#isw,@#ine]=.5[obj(@#sub)ne,obj(@#sub)sw]", % object
    elseif (picture v) or (string v):
      ".5[@#isw,@#ine]=@#p.off", % picture offset
    fi
      % correction of bug discovered by Stephan Hennig
      %   (comp.text.tex, 2004-03-18)
      % "@#ise-@#isw=(" & decimal(2*max(@#a,@#b)+2*@#cdx) % DR 23/3/2004
      "@#ise-@#isw=(" & decimal(2*(@#a+@#cdx)) % DR 23/3/2004
      %decimal(@#a++@#b+OptionValue@#("circmargin"))
      & ",0)",
      %"@#ine-@#ise=(0," & decimal(2*max(@#a,@#b)+2*@#cdy)  % DR 23/3/2004
      "@#ine-@#ise=(0," & decimal(2*(@#b+@#cdy)) % DR 23/3/2004
      %decimal(@#a++@#b+OptionValue@#("circmargin"))
      & ")";
  StandardTies;
enddef;

streamline("Circle")("(expr v)","(v)");

% shortcuts (PSTricks compatibility)
def Tcircle_(expr p)=
  new_Circle(p)
enddef;

% circle with a 1mm radius
def Tc=
  new_Circle_("")("circmargin(1mm)")
enddef;

def Tc_(expr s)=
  new_Circle_("")("circmargin(" & decimal(s) & ")")
enddef;

% filled circle with a 1mm radius
def TC=
  new_Circle_("")("filled(true)","circmargin(1mm)")
enddef;

% default filled circle
def TCs=
  new_Circle_("")("filled(true)")
enddef;

def TC_(expr s)=
  new_Circle_("")("filled(true)","circmargin(" & decimal(s) & ")")
enddef;

vardef circle@#(expr a_,b_,c_,d_)=
  (fullcircle 
    scaled 2(@#a+@#cdx)
    transformed @#ctransform_
    shifted ((a_+c_)/2)
    )  
enddef;

def BpathCircle(suffix n)=
  circle.n(n.isw,n.ise,n.ine,n.inw)
enddef;

def drawCircle(suffix n_)=
  drawFramedOrFilledObject_(n_);
  drawPictureOrObject(n_);
  drawMemorizedPaths_(n_);
enddef;

setObjectDefaultOption("Circle")("circmargin")(2bp); % same value as in |boxes.mp|
setObjectDefaultOption("Circle")("filled")(false);
setObjectDefaultOption("Circle")("fillcolor")(black);
setObjectDefaultOption("Circle")("framed")(true);
setObjectDefaultOption("Circle")("framewidth")(.5bp);
setObjectDefaultOption("Circle")("framecolor")(black);
setObjectDefaultOption("Circle")("framestyle")("");
setObjectDefaultOption("Circle")("picturecolor")(black);
setObjectDefaultOption("Circle")("shadow")(false); % no shadow by default
setObjectDefaultOption("Circle")("shadowcolor")(black);

%=====================================================================
% Double Box
vardef newDBox@#(expr v) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"DBox");
  StandardInterface;
  StandardObjectOrPictureContainerSetup(v);
  if not OptionValue@#("fit"):
    @#a:=max(@#a,@#b);@#b:=@#a; % square
  fi;
  ObjPoint swi,nwi,sei,nei;
  ObjCode StandardEquations,
    if numeric v:
      ".5[@#isw,@#ine]=.5[obj(@#sub)ne,obj(@#sub)sw]", % object
    elseif (picture v) or (string v):
      ".5[@#isw,@#ine]=@#p.off", % picture offset
    fi
    % inner/outer:
    "@#isw-@#swi=@#nei-@#ine=(-" & decimal(OptionValue@#("hsep")) & ",-" &
           decimal(OptionValue@#("vsep"))  & ");", 
    "@#ise-@#sei=@#nwi-@#inw=(" & decimal(OptionValue@#("hsep")) & ",-" &
           decimal(OptionValue@#("vsep"))  & ");", 
     % the size of the inner box is related to the size of its contents
    "@#sei-@#swi=(" & decimal(2@#a+2*OptionValue@#("dx")) & ",0)",
    "@#nei-@#sei=(0," & decimal(2@#b+2*OptionValue@#("dy")) & ")";
  StandardTies;
enddef;

streamline("DBox")("(expr v)","(v)");

def BpathDBox(suffix n)=StandardBpath(n) enddef;

def drawDBox(suffix n)=
  drawFramedOrFilledObject_(n);
  if OptionValue.n("framed"):
    draw n.swi--n.sei--n.nei--n.nwi--cycle
      withcolor OptionValue.n("framecolor") sc_(OptionValue.n("framestyle"));
  fi;
  drawPictureOrObject(n);
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("DBox")("filled")(false);
setObjectDefaultOption("DBox")("fillcolor")(black);
setObjectDefaultOption("DBox")("framed")(true);
setObjectDefaultOption("DBox")("hsep")(1mm);
setObjectDefaultOption("DBox")("vsep")(1mm);
setObjectDefaultOption("DBox")("dx")(3bp); % same value as in |boxes.mp|
setObjectDefaultOption("DBox")("dy")(3bp); % same value as in |boxes.mp|
setObjectDefaultOption("DBox")("fit")(true);
setObjectDefaultOption("DBox")("framewidth")(.5bp);
setObjectDefaultOption("DBox")("framecolor")(black);
setObjectDefaultOption("DBox")("framestyle")("");
setObjectDefaultOption("DBox")("picturecolor")(black);
setObjectDefaultOption("DBox")("shadow")(false); % no shadow by default
setObjectDefaultOption("DBox")("shadowcolor")(black);

%=====================================================================
% Double Ellipse
vardef newDEllipse@#(expr v) text options= 
  ExecuteOptions(@#)(options);
  assignObj(@#,"DEllipse");
  StandardInterface;
  StandardObjectOrPictureContainerSetup(v);
  if not OptionValue@#("fit"):
    @#a:=max(@#a,@#b);@#b:=@#a; % circle
  fi;
  ObjPoint swi,nwi,sei,nei;
  ObjNumeric cdx,cdy; % computed dx and dy
  @#a:=@#a+OptionValue@#("hsep");@#b:=@#b+OptionValue@#("vsep");
  if (@#a=0) and (@#b=0):
    @#cdx=@#cdy=OptionValue@#("circmargin");
  else:
    @#cdx=@#cdy=pathsel__(@#a,@#b)(max(@#a,@#b),OptionValue@#("circmargin"),
      (@#a+d_,0){up}...(0,@#b+d_){left});
  fi;
  if not OptionValue@#("fit"):
    % we draw a circle that fits horizontally
    @#cdx:=OptionValue@#("circmargin");
    @#cdy:=@#cdx;
  fi;
  ObjCode StandardEquations,
     if numeric v:
      ".5[@#isw,@#ine]=.5[obj(@#sub)ne,obj(@#sub)sw]", % object
     elseif (picture v) or (string v):
      ".5[@#isw,@#ine]=@#p.off", % picture offset
     fi
     % inner/outer:
     "@#isw-@#swi=@#nei-@#ine=(-" & decimal(OptionValue@#("hsep")) & ",-" &
           decimal(OptionValue@#("vsep"))  & ");", 
     "@#ise-@#sei=@#nwi-@#inw=(" & decimal(OptionValue@#("hsep")) & ",-" &
           decimal(OptionValue@#("vsep"))  & ");",  
     "@#ise-@#isw=(" & decimal(2@#a+2*@#cdx) & ",0)",
     "@#ine-@#ise=(0," & decimal(2@#b+2*@#cdx) & ")";  
  StandardTies;
enddef;

streamline("DEllipse")("(expr v)","(v)");

vardef innerellipse@#(expr a_,b_,c_,d_)=
  (fullcircle 
    xscaled (2@#a+2*@#cdx-2*OptionValue@#("hsep"))
    yscaled (2@#b+2*@#cdx-2*OptionValue@#("vsep"))
    transformed @#ctransform_
    shifted ((a_+c_)/2)
    )  
enddef;

def BpathDEllipse(suffix n)=BpathEllipse(n) enddef;

def drawDEllipse(suffix n)=
  drawFramedOrFilledObject_(n);
  if OptionValue.n("framed"):
    draw innerellipse.n(n.swi,n.sei,n.nei,n.nwi)
      withcolor OptionValue.n("framecolor") sc_(OptionValue.n("framestyle"));
  fi;
  drawPictureOrObject(n);
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("DEllipse")("circmargin")(2bp); % same value as in |boxes.mp|
setObjectDefaultOption("DEllipse")("filled")(false);
setObjectDefaultOption("DEllipse")("fillcolor")(black);
setObjectDefaultOption("DEllipse")("framed")(true);
setObjectDefaultOption("DEllipse")("hsep")(1mm);
setObjectDefaultOption("DEllipse")("vsep")(1mm);
setObjectDefaultOption("DEllipse")("fit")(true);
setObjectDefaultOption("DEllipse")("framewidth")(.5bp);
setObjectDefaultOption("DEllipse")("framecolor")(black);
setObjectDefaultOption("DEllipse")("framestyle")("");
setObjectDefaultOption("DEllipse")("picturecolor")(black);
setObjectDefaultOption("DEllipse")("shadow")(false); % no shadow by default
setObjectDefaultOption("DEllipse")("shadowcolor")(black);

% It would of course be easy to create triple boxes, triple circles, etc.

%=====================================================================
% The Container class was suggested by Michael Schwarz
% (<mi-schwarz@gmx.de>)
% (Emails from May 20, 2006)
% THIS CODE HAS NOT YET BEEN CHECKED (added October 8, 2006)
% CODE IMPROVED ON December 3, 2006.

setObjectDefaultOption("Container")("filled")(false);
setObjectDefaultOption("Container")("fillcolor")(black);
setObjectDefaultOption("Container")("framed")(false);
setObjectDefaultOption("Container")("framewidth")(.5bp);
setObjectDefaultOption("Container")("framecolor")(black);
setObjectDefaultOption("Container")("framestyle")("");
setObjectDefaultOption("Container")("shadow")(false);
setObjectDefaultOption("Container")("shadowcolor")(black);
setObjectDefaultOption("Container")("dx")(0);
setObjectDefaultOption("Container")("dy")(0);

vardef newContainer@#(text sublist) text options =
  save i,topC, botC, lftC, rtC, topS, botS, lftS, rtS, floating,
       n, firstsub, $;
  boolean floating;
  string firstsub; 
  ExecuteOptions(@#)(options);
  assignObj(@#,"Container");
  StandardInterface;

  n:=0;
  forsuffixes $=sublist:
    if incr(n)=1 : firstsub:= str $; fi;
  endfor;
  ObjSubArray(sub_)(n); % |n| is the number of elements
  i=0;
  forsuffixes $:=sublist:i:=i+1;
    SubObjectOfArray(sub_[i],$);
  endfor;

  if known(obj(firstsub).c):
    floating := false;
  else:
    floating := true;
    obj(firstsub).scantokens(firstPointOf_(firstsub)) = origin;
  fi;

  forsuffixes $=sublist:
    topS := findrec_top_most.$;
    botS := findrec_bot_most.$;
    lftS := findrec_lft_most.$;
    rtS := findrec_rt_most.$;
    if known topC:
      if topS > topC : topC := topS; fi;
    else:
      topC := topS;
    fi;

    if known botC:
      if botS < botC : botC := botS; fi;
    else:
      botC := botS;
    fi;

    if known lftC:
      if lftS < lftC : lftC := lftS; fi;
    else:
      lftC := lftS;
    fi;

    if known rtC:
      if rtS > rtC : rtC := rtS; fi;
    else:
      rtC := rtS;
    fi;
  endfor;

  ObjCode StandardEquations,
            "@#nw = (" & decimal (lftC-OptionValue@#("dx")) & "," &
            decimal (topC+OptionValue@#("dy")) & ")",
            "@#se = (" & decimal (rtC+OptionValue@#("dx")) & "," &
            decimal (botC-OptionValue@#("dy")) & ")";
  StandardTies;
  if floating: untieObj(@#); fi;
enddef;

streamline("Container")("(text t)")("suffixlist(t)");

def BpathContainer(suffix n)= StandardBpath(n) enddef;

vardef drawContainer(suffix n) =
  save i;
  drawFramedOrFilledObject_(n);
    for i=1 upto n.sub_.n_:
      drawObj(obj(n.sub_[i]));
    endfor;
  drawMemorizedPaths_(n);
enddef;


%=====================================================================
% Definitions specific to the |BB| class (Bounding Box)
% Sometimes, we want to make a new object hiding the positions
% of an object. For instance, if we rotate an object upside down,
% the |.s| component will be at the top, etc., and this is likely
% to produce unwanted effects when such an object is a subobject
% somewhere. One solution is to move the bounding points,
% without moving the contents (with respect to the whole bounding box).
% This may be a problem if the drawing macros of the object rely
% on the bounding box (which would be bad practice).
% So here we provide another solution which is simply a class
% to encapsulate cleanly a strange object. This class merely adds a layer.
%
% The computation of the new bounding box only looks at the corners
% of the object, not at other points or subobjects. |rebindObj| might
% be used to ensure that nothing protrudes.

vardef newBB@#(suffix t) text options=
  ExecuteOptions(@#)(options);
  assignObj(@#,"BB");
  StandardInterface;
  SubObject(sub,t);
  % We inject the following in the equations, using |obj(@#sub)|
  % instead of |t|, so that |resetObj.expl|, or any other function
  % using the object code, can reexecute the function code.
  %   |lftmost=find_lft_most.t;|
  %   |rtmost =find_rt_most.t;|
  %   |topmost=find_top_most.t;|
  %   |botmost=find_bot_most.t;|
  % The equations are now:
  % |xpart(@#nw)=xpart(obj(@#sub).obj(lftmost))|
  % |xpart(@#ne)=xpart(obj(@#sub).obj(rtmost))|
  % |ypart(@#nw)=ypart(obj(@#sub).obj(topmost))|
  % |ypart(@#sw)=ypart(obj(@#sub).obj(botmost))|
  % (the other points are found with the standard equations)
  ObjCode StandardEquations,
     "save lftmost,rtmost,topmost,botmost;",
     "string lftmost,rtmost,topmost,botmost;",
     "lftmost=find_lft_most.obj(@#sub);",
     "rtmost =find_rt_most.obj(@#sub);",
     "topmost=find_top_most.obj(@#sub);",
     "botmost=find_bot_most.obj(@#sub);",
     "xpart(@#inw)=xpart(obj(@#sub).obj(lftmost));",
     "xpart(@#ine)=xpart(obj(@#sub).obj(rtmost));",
     "ypart(@#inw)=ypart(obj(@#sub).obj(topmost));",
     "ypart(@#isw)=ypart(obj(@#sub).obj(botmost));";
  StandardTies;
enddef;

% create a streamlined version
streamline("BB")("(expr t)","suffixpar(t)");

def BpathBB(suffix n)= StandardBpath(n) enddef;

def drawBB(suffix n)=
  drawFramedOrFilledObject_(n);
  drawObj(obj(n.sub));
  drawMemorizedPaths_(n);
enddef;

setObjectDefaultOption("BB")("filled")(false);
setObjectDefaultOption("BB")("fillcolor")(black);
setObjectDefaultOption("BB")("framed")(false);
setObjectDefaultOption("BB")("framewidth")(.5bp);
setObjectDefaultOption("BB")("framecolor")(black);
setObjectDefaultOption("BB")("framestyle")("");
setObjectDefaultOption("BB")("shadow")(false); % no shadow by default
setObjectDefaultOption("BB")("shadowcolor")(black);

endinput
