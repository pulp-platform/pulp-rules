define declareInstallFile

$(TARGET_INSTALL_DIR)/$(1): $(1)
	install -D $(1) $$@

INSTALL_HEADERS += $(TARGET_INSTALL_DIR)/$(1)

endef


INSTALL_FILES += $(shell find rules -name *.mk)
INSTALL_FILES += $(shell find rules/zephyr -name CMakeLists.txt)

$(foreach file, $(INSTALL_FILES), $(eval $(call declareInstallFile,$(file))))

all: $(INSTALL_HEADERS)