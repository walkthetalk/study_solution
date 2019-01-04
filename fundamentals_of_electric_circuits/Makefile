
pdf_name=fundamentals_of_electric_circuits

dir_self := $(shell dirname $(shell readlink -fe $(lastword ${MAKEFILE_LIST})))
dir_mp   := ${dir_self}/fig/:$(shell kpsepath mp)
dir_main := $(shell readlink -fe ${dir_self})

dir_env  := $(shell readlink -fe ${dir_self}/../env/en)
dir_output := ${dir_main}/output
output_dirs:=${dir_output} ${dir_output}/fig

env_deps:=$(shell find ${dir_env} -type f)

tex_deps:=$(shell find . -type f -name \*.tex)
tex_deps+=$(shell find . -type f -name \*.mp)
tex_deps+=$(shell find . -type f -name \*.bib)
tex_deps+=$(shell find . -type f -name \*.lua)
tex_deps+=$(shell find . -type f -name \*.mkiv)

fig_srcs:=$(shell cd ${dir_main}/fig; find . -type f -name '[a1-9]*.mp' | cut -d '/' -f 2)
fig_incs:=schematic.mp coord.mp smetaobj.mp
fig_pdfs:=$(patsubst %.mp,$(dir_output)/fig/%.pdf,$(fig_srcs))
fig_deps:=$(patsubst %.mp,${dir_main}/fig/%.mp,$(fig_incs))

ifneq ($(MAKECMDGOALS),clean)
#$(warning MAKECMDGOALS is $(MAKECMDGOALS))
#$(warning output_dirs is $(output_dirs))
$(foreach temp, $(output_dirs), $(shell mkdir -p $(temp)))
endif

.PHONY: all
all: ${dir_output}/$(pdf_name).pdf

.PHONY: clean
clean:
	@rm -r ${dir_output}/*

${dir_output}/$(pdf_name)-aio.pdf: $(tex_deps) ${env_deps}
	@echo [gen] $@
	@cd ${dir_output}; \
	export MPINPUTS=${dir_mp}; \
	context --jit --purgeall \
	  --paranoid \
	  --nocompression \
	  --environment=env_cmm \
	  --path=${dir_env},${dir_main},${dir_main}/chapters,${dir_main}/fig \
	  --result=${pdf_name}-aiok.pdf \
	  ${dir_main}/main.tex

${dir_output}/$(pdf_name).pdf: $(tex_deps) ${fig_pdfs} ${env_deps}
	@echo [gen] $@
	@cd ${dir_output}; \
	export MPINPUTS=${dir_mp}; \
	context --jit --purgeall \
	  --paranoid \
	  --nocompression \
	  --environment=env_cmm \
	  --path=${dir_env},${dir_main},${dir_main}/chapters,${dir_main}/fig \
	  --mode=sepfig \
	  --result=${pdf_name}.pdf \
	  ${dir_main}/main.tex

$(dir_output)/fig/%.pdf: ${dir_main}/fig/%.mp ${fig_deps} ${env_deps}
	@cd $(dir_output)/fig; \
	export TMPDIR="`mktemp -p /tmp -d context.XXXX`"; \
	echo "\usemodule[p][foecsolution] \
		\setuppagenumbering[state=stop,alternative=singlesided] \
		\starttext \
		\switchtobodyfont[6pt] \
		\startMPpage \
		input coord; \
		input schematic; \
		elesize_ratio := 3; \
		eleconn_ratio := 6; \
		labeloffset := 1; \
		ahangle:=30; \
		clearObjsForTwiceRun; \
		input $<; \
		\stopMPpage \
		\stoptext" > $${TMPDIR}/$*.tex; \
	echo TMPDIR is $${TMPDIR}; \
	cd $${TMPDIR}; \
	export MPINPUTS=${dir_mp}; \
	context --jit --batchmode --purgeall\
	  --paranoid \
	  --noconsole \
	  --nocompression \
	  --environment=env_cmm \
	  --path=$(dir_env),${dir_main} \
	  --mode=sepfig \
	  $${TMPDIR}/$*.tex; \
	mv $${TMPDIR}/$*.pdf $@; \
	rm -r $${TMPDIR}
