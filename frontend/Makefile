FRONTEND := .
DIST := dist
SRC := src
STYLE := style

NODE_MODULES_BIN := ../node_modules/.bin

FRONTEND_DIST = $(FRONTEND)/$(DIST)
FRONTEND_SRC = $(FRONTEND)/$(SRC)

NUNJUCKS_TEMPLATES := $(FRONTEND_SRC)/templates
ALL_TEMPLATE_FILES := $(shell find $(NUNJUCKS_TEMPLATES) -name "*.njk")

$(FRONTEND_DIST)/%.js: $(FRONTEND_SRC)/elm/%.elm
	mkdir -p $(dir $@)
	$(NODE_MODULES_BIN)/elm make $< --optimize --output=$@

$(FRONTEND_DIST)/%.min.js: $(FRONTEND_DIST)/%.js
	mkdir -p $(dir $@)
	$(NODE_MODULES_BIN)/uglifyjs --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" $< | $(NODE_MODULES_BIN)/uglifyjs --mangle --output $@

$(FRONTEND_DIST)/%.css: $(FRONTEND_SRC)/$(STYLE)/%.less
	mkdir -p $(dir $@)
	$(NODE_MODULES_BIN)/lessc -m=parens $< $@

$(FRONTEND_DIST)/%.min.css: $(FRONTEND_DIST)/%.css
	mkdir -p $(dir $@)
	$(NODE_MODULES_BIN)/postcss --config postcss.config.js $< > $@

$(FRONTEND_DIST)/%: $(FRONTEND_SRC)/static/%
	mkdir -p $(dir $@)
	cp $< $@

$(FRONTEND_DIST)/%.html: $(FRONTEND_SRC)/pages/%.njk $(ALL_TEMPLATE_FILES)
	./nunjucksbuild.js $< $@ $(NUNJUCKS_TEMPLATES)

ALL_FILES := \
	$(patsubst $(FRONTEND_SRC)/elm/%.elm, $(FRONTEND_DIST)/%.min.js, $(shell find $(FRONTEND_SRC)/elm/ -name "*.elm")) \
	$(patsubst $(FRONTEND_SRC)/$(STYLE)/%.less, $(FRONTEND_DIST)/%.min.css, $(shell find $(FRONTEND_SRC)/$(STYLE)/ -name "*.less")) \
	$(patsubst $(FRONTEND_SRC)/static/%, $(FRONTEND_DIST)/%, $(shell find $(FRONTEND_SRC)/static/ -type f)) \
	$(patsubst $(FRONTEND_SRC)/pages/%.njk, $(FRONTEND_DIST)/%.html, $(shell find $(FRONTEND_SRC)/pages/ -name "*.njk"))

.PHONY: all
.DEFAULT_GOAL := all
all: $(ALL_FILES)
