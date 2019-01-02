tex_name=main

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

define clean_misc =
	rm -f $(tex_name).aux $(tex_name).bbl $(tex_name).blg $(tex_name).log $(pdf_name).tuc
endef

fig_srcs:=$(shell cd ${dir_main}/fig; find . -type f -name '[a1-9]*.mp' | cut -d '/' -f 2)
fig_incs:=schematic.mp coord.mp smetaobj.mp

$(warning dr_main is ${dir_main})
$(warning fig_srcs is ${fig_srcs})

fig_pdfs:=$(patsubst %.mp,$(dir_output)/fig/%.pdf,$(fig_srcs))
fig_deps:=$(patsubst %.mp,${dir_main}/fig/%.mp,$(fig_incs))

ifneq ($(MAKECMDGOALS),clean)
#$(warning MAKECMDGOALS is $(MAKECMDGOALS))
#$(warning asy_dirs is $(asy_dirs))
#$(warning output_dirs is $(output_dirs))
$(foreach temp, $(output_dirs), $(shell mkdir -p $(temp)))
endif

.PHONY: all
all: $(pdf_name).pdf

#.PHONY: clean
#clean:
#	@rm -f $(pdf_name).pdf
#	@$(call clean_misc)
#	@rm -f ${dir_output}/*

$(pdf_name).pdf: $(tex_deps) ${fig_pdfs}
	@echo [gen] $@
	@export MPINPUTS=${dir_mp}; \
	context --jit --purge \
	  --nocompression \
	  --environment=env_cmm \
	  --path=$(dir_env) \
	  --result=$(pdf_name).pdf \
	  $(tex_name).tex; \
	$(call clean_misc)

$(dir_output)/fig/%.pdf: $(dir_output)/fig/%.tex $(env_deps)
	cd $(dir_output)/fig; \
	export MPINPUTS=${dir_mp}; \
	context --jit --purgeall\
	  --nocompression \
	  --environment=env_cmm \
	  --path=$(dir_env) \
	  $<

# NOTE: set pagenumbering is only for getting single page
$(dir_output)/fig/%.tex: $(dir_main)/fig/%.mp ${fig_deps}
	@echo "\usemodule[p][foecsolution] \
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
input $< \
\stopMPpage \
\stoptext" > $@

