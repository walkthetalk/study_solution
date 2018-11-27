-- Copyright 2012 Yi Qingliang <niqingliang2003@tom.com>
-- Time-stamp: <2012-05-28 00:20:20>
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- This work is fully inspired by Peter Münster's pret-c module.
--
if not modules then modules = { } end modules ['t-pretty-clfunc'] = {
    version   = 0.9,
    comment   = "Companion to t-pretty-clfunc.mkiv",
    author    = "Yi Qingliang",
    copyright = "2012 Yi Qingliang",
    license   = "GNU General Public License version 3"
}

local tohash = table.tohash
local P, S, V, patterns = lpeg.P, lpeg.S, lpeg.V, lpeg.patterns

local context               = context
local makepattern           = visualizers.makepattern

local handler = visualizers.newhandler {
    startinline  = function() context.CSnippet(false,"{") end,
    stopinline   = function() context("}") end,
    startdisplay = function() context.startCSnippet() end,
    stopdisplay  = function() context.stopCSnippet() end ,

    fapi         = function(s) context.verbatim.CSnippetApi(s) end,
    ftype        = function(s) context.verbatim.CSnippetType(s) end,
    fqlf         = function(s) context.verbatim.CSnippetQlf(s) end,
    farg         = function(s) context.verbatim.CSnippetArg(s) end,
}

local space       = patterns.space
local anything    = patterns.anything
local newline     = patterns.newline
local emptyline   = patterns.emptyline
local beginline   = patterns.beginline
local somecontent = patterns.somecontent

local gname       = (patterns.letter + patterns.underscore)
                  * (patterns.letter + patterns.underscore + patterns.digit)^0

-- constant must prior to const for greedy (without word split)
local gqlf        = P("constant")
                  + P("const")
                  + P("volatile")
                  + P("__global")
                  + P("__constant")
                  + P("__local")
                  + P("__private")
                  + P("restrict")

local grammar = visualizers.newgrammar(
   "default",
   {
      "visualizer",

      papi     = makepattern(handler,"fapi",gname) * V("optionalwhitespace"),
      pqlf     = makepattern(handler,"fqlf",gqlf) * V("optionalwhitespace"),
      parg     = makepattern(handler,"farg",gname) * V("optionalwhitespace"),
      ptype    = (makepattern(handler,"ftype",P("unsigned") * V("optionalwhitespace") * gname)
               + makepattern(handler,"ftype",gname))
               * V("optionalwhitespace"),

      pstar    = makepattern(handler,"default",P("*")) * V("optionalwhitespace"),
      plp      = makepattern(handler,"default",P("(")) * V("optionalwhitespace"),
      prp      = makepattern(handler,"default",P(")")) * V("optionalwhitespace"),
      pcommar  = makepattern(handler,"default",P(",")) * V("optionalwhitespace"),

      pparam1  = V("pqlf")^0 * V("ptype") * V("pstar")^0 * V("pqlf")^0 * V("parg"),
      pparam2  = V("ptype") * V("pstar")^0,
      pparam3  = makepattern(handler,"farg",P("...")) * V("optionalwhitespace"),
      pparamc  = V("pparam1") + V("pparam2"),
      pparamf  = V("ptype")
               * V("plp") * V("ptype") * V("pstar")^0 * V("parg") * V("prp")
	       * V("plp")
	       * ((V("pparamc") * V("pcommar"))^0 * V("pparamc"))^-1
	       * V("prp"),
      pparam   = V("pparamf")
               + V("pparamc"),

      pfunc = V("ptype") * V("pstar")^0 * V("papi")
            * V("plp")
	    * ((V("pparam") * V("pcommar"))^0 * (V("pparam") + V("pparam3")))^-1
	    * V("prp"),

    pattern = V("pfunc"),

    visualizer =
        V("pattern")^1
   }
)

local parser = P(grammar)

visualizers.register("clfunc", { parser = parser, handler = handler, grammar = grammar } )
