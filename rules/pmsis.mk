ifeq '$(PMSIS_OS)' 'freertos'

APP_SRC 	= $(SRCS)
DEMO_SRC	+=
INC_PATH	+=

include $(GAP_SDK_HOME)/tools/rules/freeRTOS_rules.mk

else

ifeq '$(PMSIS_OS)' 'mbed'

TEST_C          = $(SRCS)
MBED_FLAGS     += -DMBED_CONF_RTOS_PRESENT=1

include $(GAP_SDK_HOME)/tools/rules/mbed_rules.mk

else

override runner_args += --config-user=$(RUNNER_CONFIG)

ifeq '$(PMSIS_OS)' 'zephyr'

include $(PULP_SDK_HOME)/install/rules/zephyr.mk

else

PULP_APP = $(APP)
PULP_APP_FC_SRCS = $(SRCS)
PULP_CFLAGS = $(CFLAGS)
ifdef USE_PMSIS_BSP
PULP_LDFLAGS += -lpibsp
endif

include $(PULP_SDK_HOME)/install/rules/pulp_rt.mk

endif

endif

endif