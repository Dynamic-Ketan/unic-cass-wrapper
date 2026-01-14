PROJECT_DIR = $(shell pwd)
LIBRELANE_DIR ?= $(PROJECT_DIR)/librelane

.PHONY: all
all: librelane user_project_wrapper

.PHONY: smoke-test
smoke-test: 
	nix-shell --pure $(LIBRELANE_DIR) --run "PDK_ROOT=$(PDK_ROOT) PDK=$(PDK) librelane --smoke-test"

librelane: final/gds/$(TOP).gds
.PHONY: librelane

final/gds/$(TOP).gds: $(CFG_FILES)
	# Run librelane to generate the layout
	$(MAKE) -C user_project_example

.PHONY: user_project_wrapper
user_project_wrapper:
	# Run the unic-cass-wrapper to generate the user project wrapper
	$(MAKE) -C user_project_wrapper
