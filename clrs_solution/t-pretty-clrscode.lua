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

local tohash = table.tohash
local P, S, V, patterns = lpeg.P, lpeg.S, lpeg.V, lpeg.patterns

local context               = context
local makepattern           = visualizers.makepattern

local handler = visualizers.newhandler {
    startinline  = function() context.CSnippet(false,"{") end,
    stopinline   = function() context("}") end,
    startdisplay = function() context.startCSnippet() end,
    stopdisplay  = function() context.stopCSnippet() end ,

    fstartcomments    = function(s)
                        context("\\color[red]{")
                        context(s)
                    end,
    fstopcomments= function(s)
                        context("}")
                        -- for newline
                        context.verbatim.CSnippetStrip(s)
                    end,
    fstopcomments2= function()
                        context("}")
                    end,
    ftext        = function(s)
                        context(s)
                    end,
    fstrip       = function(s) context.verbatim.CSnippetStrip(s) end,
}

local space       = patterns.space
local anything    = patterns.anything
local newline     = patterns.newline
local emptyline   = patterns.emptyline
local beginline   = patterns.beginline
local somecontent = patterns.somecontent
local spacer      = patterns.spacer
local spacers     = patterns.spacer^0
local visualchar  = anything - spacer - S("\r\n")
local notnewline  = anything - S("\r\n")
local notBackSlash=notnewline - S("/")

local gname       = (patterns.letter + patterns.underscore)
                  * (patterns.letter + patterns.underscore + patterns.digit)^0

local gkeywords   = P("for")
                  + P("do")
                  + P("while")
                  + P("if")
                  + P("downto")

-- A + B: A or B
-- A * B: A concat B
-- A^-1 : 0 or 1
-- A^0  : 0 or 1 or 2 or ...
local grammar = visualizers.newgrammar(
   "default",
   {
      "visualizer",

      ptext         = makepattern(handler, "ftext",
                        (notBackSlash^1 * (S("/") * notBackSlash^1)^0)
                        + (S("/") * notBackSlash^1)^1),
      pstartcomments= makepattern(handler, "fstartcomments", P("//")),
      pstopcomments = makepattern(handler, "fstopcomments", newline),
      pstopcomments2= makepattern(handler, "fstopcomments2", P(true)),
    -- the pattern is for normal line (with newline)
    pattern = makepattern(handler, "fstrip", spacers)
                * V("ptext")^-1
                * ((V("pstartcomments") * V("ptext")^-1 * V("pstopcomments"))
                    + makepattern(handler, "fstrip", newline)),
    -- the pattern2 is only for final line without newline
    pattern2 = makepattern(handler, "fstrip", spacers)
                * V("ptext")^-1
                * ((V("pstartcomments") * V("ptext")^-1 * V("pstopcomments2"))^-1),
    --pattern = makepattern(handler, "fcomments", anything),

    visualizer = V("pattern")^0 * V("pattern2")
   }
)

local parser = P(grammar)

visualizers.register("clrscode", { parser = parser, handler = handler, grammar = grammar } )
