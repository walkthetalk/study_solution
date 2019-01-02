#!/usr/bin/env sh

SELFDIR="`dirname $0`"
MAINDIR="`readlink -fe ${SELFDIR}/../`"

FIGDIR="${MAINDIR}/fundamentals_of_electric_circuits/fig/"

TMPDIR="`mktemp -p /tmp -d context.XXXX`"
SRCFILE="$1"
if [ ! -f ${SRCFILE} ]; then
	echo "$0 {file name}$"
	exit 1
fi

TMPFILE="${TMPDIR}/tmp.tex"

echo "\starttext
\switchtobodyfont[6pt]
\startMPpage
input ${FIGDIR}/schematic.mp;
elesize_ratio := 3;
eleconn_ratio := 6;
labeloffset := 1;
clearObjsForTwiceRun;
%setX("fig" & str #1);
input ${FIGDIR}/${SRCFILE}
\stopMPpage
\stoptext
" > ${TMPFILE}

context --batchmode --purgeall ${TMPFILE}

echo "rming ${TMPDIR}"
rm -rf ${TMPDIR}
