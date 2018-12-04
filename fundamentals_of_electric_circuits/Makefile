tex_name=main

pdf_name=fundamentals_of_electric_circuits

dir_self := $(shell dirname $(shell readlink -fe $(lastword ${MAKEFILE_LIST})))
dir_main := $(shell readlink -fe ${dir_self})

dir_env  := $(shell readlink -fe ${dir_self}/../env/en)
dir_output := ${dir_main}/output
output_dirs:=${dir_output}

tex_deps:=$(shell find ${dir_env} -type f)
tex_deps+=$(shell find . -type f -name \*.tex)
tex_deps+=$(shell find . -type f -name \*.mp)
tex_deps+=$(shell find . -type f -name \*.bib)
tex_deps+=$(shell find . -type f -name \*.lua)
tex_deps+=$(shell find . -type f -name \*.mkiv)

define clean_misc =
	rm -f $(tex_name).aux $(tex_name).bbl $(tex_name).blg $(tex_name).log $(pdf_name).tuc
endef

fig_srcs:=$(shell cd fig; find . -type f -name e\*.mp | cut -d '/' -f 2)
fig_srcs+=$(shell cd fig; find . -type f -name p\*.mp | cut -d '/' -f 2)
fig_incs:=$(shell cd fig; find . -type f -name "*.mp" | cut -d '/' -f 2 | grep -v "^[e|p]")
#$(warning figincs is ${fig_incs})

ifneq ($(MAKECMDGOALS),clean)
#$(warning MAKECMDGOALS is $(MAKECMDGOALS))
#$(warning asy_dirs is $(asy_dirs))
#$(warning output_dirs is $(output_dirs))
$(foreach temp, $(output_dirs), $(shell mkdir -p $(temp)))
endif

.PHONY: all
all: $(pdf_name).pdf

.PHONY: clean
clean:
	@rm -f $(pdf_name).pdf
	@$(call clean_misc)
	@rm -f ${dir_output}/*

$(pdf_name).pdf: $(tex_deps)
	@echo [gen] $@
	@context --jit --purge \
	  --nocompression \
	  --environment=env_cmm \
	  --path=$(dir_env) \
	  --result=$(pdf_name).pdf \
	  $(tex_name).tex; \
	$(call clean_misc)
