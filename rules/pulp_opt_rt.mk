ifdef rt/no-werror
override CONFIG_OPT += rt/werror=false
endif

help_opt_rt:
	@echo
	@echo "Available make options for runtime:"
	@echo "  rt/no-werror=1         Deactivate errors on warnings"
	