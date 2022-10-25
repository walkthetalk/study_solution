-- Copyright 2022 Yi Qingliang <niqingliang2003@tom.com>
-- Time-stamp: <2022-10-22 11:25:20>
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
if not modules then modules = { } end modules ['t-pretty-clrscode'] = {
    version   = 0.9,
    comment   = "Companion to t-pretty-clrscode.mkiv",
    author    = "Yi Qingliang",
    copyright = "2022 Yi Qingliang",
    license   = "GNU General Public License version 3"
}

-- note: the \t is alreay converted to spaces when parsing.

local tohash = table.tohash
local P, S, V, patterns = lpeg.P, lpeg.S, lpeg.V, lpeg.patterns

local context               = context
local makepattern           = visualizers.makepattern

local handler = visualizers.newhandler {
    startinline  = function() context.CSnippet(false,"{") end,
    stopinline   = function() context("}") end,
    startdisplay = function() context.startCSnippet() end,
    stopdisplay  = function() context.stopCSnippet() end ,

    fcomments   = function(s)
                        context("\\color[darkred]{"..s.."}")
                    end,
    ftext       = function(s)
                        context(s)
                    end,
    fstrip      = function(s)
                        context.verbatim.CSnippetStrip(s)
                    end,
    fnewline    = function(s)
                        context.verbatim.CSnippetStrip(s)
                    end,
    ftabs       = function(s)
                        context.verbatim.CSnippetStrip(s)
                    end,
    fkeyword    = function(s)
                        context.verbatim.CSnippetKeyword(s)
                    end,
    fmath        = function(s)
                        context("$"..s.."$")
                    end,
}

local space       = patterns.space
local anything    = patterns.anything
local newline     = patterns.newline
local emptyline   = patterns.emptyline
local beginline   = patterns.beginline
local somecontent = patterns.somecontent
local utf8char    = patterns.utf8char
local spacer      = patterns.spacer
local spacers     = patterns.spacer^0
local visualchar  = anything - spacer - S("\r\n")
local notnewline  = anything - S("\r\n")
local notBS       = visualchar - S("/")
local notBSTab    = anything - S("\t\r\n/")
local notTab      = notnewline - S("\t")

local validName   = --visualchar^1
                S("/")^0 * (
                        notBS^1 * (S("/") * notBS^1)^0
                    ) * S("/")^0

local gkeyword   = P("for")
                  + P("to")
                  + P("do")
                  + P("while")
                  + P("if")
                  + P("else")
                  + P("downto")
                  + P("return")
                  + P("NIL")
                  + P("and")
                  + P("or")
local notkeyword = validName - gkeyword
local mathContent = notkeyword * (spacer^1 * notkeyword)^0

--local notComments = ((notBackSlash^1 * (S("/") * notBackSlash^1)^0)
--                    + (S("/") * notBackSlash^1)^1)
local containComments = notnewline^0 * P("//") * notnewline^0

-- A + B: A or B
-- A * B: A concat B
-- A^-1 : 0 or 1
-- A^0  : 0 or 1 or 2 or ...
local grammar = visualizers.newgrammar(
   "default",
   {
      "visualizer",
      pspacers = makepattern(handler, "fstrip", spacer^1),
      ptabs    = makepattern(handler, "ftabs", S("\t ")^0),
      --ptabs    = makepattern(handler, "ftabs", S(" \t")^0),
      pnewline = makepattern(handler, "fnewline", newline),

      pkeyword = makepattern(handler, "fkeyword", gkeyword),
      pmath    = makepattern(handler, "fmath", mathContent),

      pkorm    = V("pkeyword") + V("pmath"),

      ptext    = V("pkorm")
                    * (V("pspacers") * V("pkorm"))^0,
      pcomments = makepattern(handler, "fcomments", (P("//") * notnewline^0)),
    -- the pattern is for normal line (without newline)
    pattern = V("pspacers")^0 *
                ((V("ptext") * V("pspacers")^0 * V("pcomments")^-1)
                + V("pcomments")),

    visualizer = (V("pattern")^0 * V("pnewline"))^0 * V("pattern")
   }
)

local parser = P(grammar)

visualizers.register("clrscode", { parser = parser, handler = handler, grammar = grammar } )
