#
# This is the top makefile which can be included by a module or application in 
# order to bring everything.
# A script is used to generate the hierarchy of makefiles for the specified
# architecture and is then included.
#

ifndef PULP_CURRENT_CONFIG
$(error PULP_CURRENT_CONFIG must contain the current configuration)
endif

ifndef PULP_SDK_HOME
$(error The SDK is not configured, PULP_SDK_HOME is undefined)
endif

# This file is a dummy one and is included just to trigger module recompilation
# in case the tools are updated
include $(PULP_SDK_HOME)/install/rules/tools.mk
include $(PULP_SDK_HOME)/install/rules/pulp_defs.mk
include $(PULP_SDK_HOME)/install/rules/pulp_opt.mk
include $(PULP_SDK_HOME)/install/rules/pulp_help.mk

# Work-around to don't break old applications using PULP_OMP_APP which is now deprecated
ifdef PULP_OMP_APP
PULP_APP = $(PULP_OMP_APP)
endif

properties = $(foreach prop,$(PULP_PROPERTIES), --property=$(prop))
libs       = $(foreach lib,$(PULP_LIBS), --lib=$(lib))
apps       = $(foreach app,$(PULP_APP), --app=$(app))

override CONFIG_OPT += options/rt/type=pulp-rt

ifdef CONFIG_OPT
export PULP_CURRENT_CONFIG_ARGS += $(CONFIG_OPT)
endif

ifdef PLT_OPT
pulpRunOpt += $(PLT_OPT)
endif

genconf:
	plpflags gen $(FLAGS_OPT) --output-dir=$(CONFIG_BUILD_DIR) --makefile=$(CONFIG_BUILD_DIR)/config.mk $(properties) $(libs) $(apps) --out-config=$(CONFIG_BUILD_DIR)/config.json

$(CONFIG_BUILD_DIR)/config.mk:
	plpflags gen $(FLAGS_OPT) --output-dir=$(CONFIG_BUILD_DIR) --makefile=$(CONFIG_BUILD_DIR)/config.mk $(properties) $(libs) $(apps) --out-config=$(CONFIG_BUILD_DIR)/config.json

-include $(CONFIG_BUILD_DIR)/config.mk

conf: $(MAKEFILE_LIST) genconf $(GEN_TARGETS_FORCE)