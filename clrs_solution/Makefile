pdf_name := CLRS_solution
doc_env  := book
dir_main := $(shell dirname $(shell readlink -fe $(lastword ${MAKEFILE_LIST})))

include $(dir_main)/../scripts/common.mk

define clean_misc =
	rm -f $(tex_name).aux $(tex_name).bbl $(tex_name).blg $(tex_name).log $(pdf_name).tuc
endef

fig_srcs:=$(shell cd fig; find . -type f -name e\*.mp | cut -d '/' -f 2)
fig_srcs+=$(shell cd fig; find . -type f -name p\*.mp | cut -d '/' -f 2)
fig_incs:=$(shell cd fig; find . -type f -name "*.mp" | cut -d '/' -f 2 | grep -v "^[e|p]")
#$(warning figincs is ${fig_incs})

fig_pdfs:=$(patsubst %.mp,$(output_dir)/%-1.pdf,$(fig_srcs))
fig_deps:=$(patsubst %.mp,${dir_main}/fig/%.mp,$(fig_incs))

#$(warning fig srcs is ${fig_pdfs})

.PHONY: fig_pdfs
fig_pdfs: ${fig_pdfs}

${main_object}: ${fig_pdfs}

$(output_dir)/%-1.pdf : ${dir_main}/fig/%.mp ${fig_deps}
	@set -e; \
	COMPILE_DIR=$$(mktemp -d /tmp/CLRSMP.XXXXXXXX); \
	echo [compile] $* at $${COMPILE_DIR}; \
	cp $^ $${COMPILE_DIR}/; \
	cd $${COMPILE_DIR}; \
	mptopdf $*.mp > /dev/null; \
	cp *.pdf ${output_dir}/; \
	rm -r $${COMPILE_DIR}
