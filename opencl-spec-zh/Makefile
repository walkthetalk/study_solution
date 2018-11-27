fig_name=figclassdiag
tex_name=main

pdf_name=opencl-spec-zh

dir_self := $(shell dirname $(shell readlink -fe $(lastword ${MAKEFILE_LIST})))
dir_main := $(shell readlink -fe ${dir_self})

dir_env  := $(shell readlink -fe ${dir_self}/../env/cn)
dir_output := ${dir_main}/output
output_dirs:=${dir_output}

tex_deps:=$(shell find ${dir_env} -type f)
tex_deps+=$(shell find . -type f -name \*.tex)
tex_deps+=$(shell find . -type f -name \*.mp)
tex_deps+=$(shell find . -type f -name \*.bib)
tex_deps+=$(shell find . -type f -name \*.lua)
tex_deps+=$(shell find . -type f -name \*.mkiv)

define clean_misc =
	rm -f $(pdf_name).aux $(pdf_name).bbl $(pdf_name).blg $(pdf_name).log $(pdf_name).tuc
endef

#$(warning fig srcs is ${fig_pdfs})

ifneq ($(MAKECMDGOALS),clean)
#$(warning MAKECMDGOALS is $(MAKECMDGOALS))
#$(warning asy_dirs is $(asy_dirs))
#$(warning output_dirs is $(output_dirs))
$(foreach temp, $(output_dirs), $(shell mkdir -p $(temp)))
endif

all: $(pdf_name).pdf


.PHONY: clean
clean:
	@rm -f $(pdf_name).pdf
	@$(call clean_misc)
	@rm -f $(fig_name).log $(fig_name).1 $(fig_name)-1.pdf

$(fig_name)-1.pdf: $(fig_name).mp
	mptopdf $(fig_name).mp

$(pdf_name).pdf: $(tex_deps) $(fig_name)-1.pdf
	@echo [gen] $@
	@context --jit --purge \
	  --nocompression \
	  --environment=env_cmm \
	  --path=$(dir_env) \
	  --result=$(pdf_name).pdf \
	  $(tex_name).tex; \
	$(call clean_misc)

