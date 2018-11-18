tex_name=main

prd_name=formword
pdf_name := ${prd_name}.pdf

dir_self := $(shell dirname $(shell readlink -fe $(lastword ${MAKEFILE_LIST})))
dir_main := $(shell readlink -fe ${dir_self})
dir_env  := $(shell readlink -fe ${dir_self}/../env)

tex_deps:=$(shell find . -type f -name \*.tex)
tex_deps+=$(shell find . -type f -name \*.bib)
tex_deps+=$(shell find . -type f -name \*.lua)
tex_deps+=$(shell find . -type f -name \*.mkiv)

define clean_misc =
	rm -f $(tex_name).aux $(tex_name).bbl $(tex_name).blg $(tex_name).log *.tuc
endef


.PHONY: all
all: ${pdf_name}

.PHONY: clean
clean:
	@rm -f ${pdf_name}
	@$(call clean_misc)

${pdf_name}: $(tex_deps) $(eps_files)
	@echo [gen] $@
	context --purge --environment=env_cmm --path=$(dir_env) --result=$(dir_main)/${pdf_name} main.tex; \
	$(call clean_misc)

