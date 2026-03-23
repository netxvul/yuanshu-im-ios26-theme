SHELL := /bin/bash

ROOT_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
PARENT_DIR := $(abspath $(ROOT_DIR)/..)
THEME_NAME := $(notdir $(ROOT_DIR))
DESKTOP_DIR := $(HOME)/Desktop

LATEST_ARCHIVE := $(shell find "$(PARENT_DIR)" -maxdepth 1 -type f -name "$(THEME_NAME)_v*.cskin" | sort -V | tail -n 1)
NEXT_VERSION := $(shell latest='$(LATEST_ARCHIVE)'; if [ -z "$$latest" ]; then echo 'v1.0.0'; else version="$$(basename "$$latest" .cskin | sed 's/^.*_v//')"; major="$$(echo "$$version" | cut -d. -f1)"; minor="$$(echo "$$version" | cut -d. -f2)"; patch="$$(echo "$$version" | cut -d. -f3)"; echo "v$$major.$$minor.$$((patch + 1))"; fi)
ARCHIVE_NAME := $(THEME_NAME)_$(NEXT_VERSION).cskin
ARCHIVE_PATH := $(PARENT_DIR)/$(ARCHIVE_NAME)
DESKTOP_ARCHIVE_PATH := $(DESKTOP_DIR)/$(ARCHIVE_NAME)

ZIP_EXCLUDES := \
	-x "$(THEME_NAME)/.git/*" \
	-x "$(THEME_NAME)/.DS_Store" \
	-x "$(THEME_NAME)/test/*" \
	-x "$(THEME_NAME)/Makefile" \
	-x "$(THEME_NAME)/*.cskin"

.PHONY: all compile package version clean

all: package

compile:
	cd "$(ROOT_DIR)" && jsonnet -S -m . jsonnet/main.jsonnet

package: compile
	cd "$(PARENT_DIR)" && zip -rq "$(ARCHIVE_NAME)" "$(THEME_NAME)" $(ZIP_EXCLUDES)
	mv "$(ARCHIVE_PATH)" "$(DESKTOP_ARCHIVE_PATH)"
	@echo "Created $(DESKTOP_ARCHIVE_PATH)"

version:
	@echo "$(NEXT_VERSION)"

clean:
	rm -f "$(PARENT_DIR)/$(THEME_NAME)_v"*.cskin
