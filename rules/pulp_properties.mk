#
# This makefile can be included by a module or application in order to generate some properties
# extracted from the architecture
#
# For that define the properties in PULP_PROPERTIES and include $(PULP_SDK_HOME)/install/rules/pulp_properties.mk

include $(PULP_SDK_HOME)/install/rules/pulp_defs.mk

ifdef PULP_PROPERTIES

properties := $(foreach prop,$(PULP_PROPERTIES), --property=$(prop))

$(CONFIG_BUILD_DIR)/props.mk: $(MAKEFILE_LIST) $(PULP_SDK_HOME)/install/rules/tools.mk
	plpinfo mkgen --makefile=$(CONFIG_BUILD_DIR)/props.mk $(properties)

include $(CONFIG_BUILD_DIR)/props.mk

endif
