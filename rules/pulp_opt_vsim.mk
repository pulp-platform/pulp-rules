ifdef gui
override CONFIG_OPT += **/vsim/gui=true
endif

ifdef simchecker
override CONFIG_OPT += **/vsim/simchecker=true
endif

ifdef vsim/script
override CONFIG_OPT += **/vsim/script=$(vsim/script)
endif

ifdef vsim/recordwlf
override CONFIG_OPT += **/vsim/recordwlf=true
endif

ifdef vsim/dofile
override CONFIG_OPT += **/vsim/dofile="$(vsim/dofile)"
endif

ifdef vsim/model
override CONFIG_OPT += **/vsim/model=$(vsim/model)
endif

ifdef vsim/enablecov
override CONFIG_OPT += **/vsim/enablecov=true
endif



BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD=\033[1m
STD=\033[0m

help_opt_vsim:
	@echo -e "##############################################"
	@echo -e "## Available make options for vsim platform:"
	@echo -e "##############################################"
	@echo -e " - ${BOLD}gui=1${STD}:             		Launch simulation from vsim GUI"
	@echo -e " - ${BOLD}simchecker=1${STD}:      		Activate RISCV simchecker (ISA comparison against golden model)"
	@echo -e " - ${BOLD}vsim/script=<path${STD}: 		Specify path to a script used to launch the platform>"
	@echo -e " - ${BOLD}vsim/recordwlf=1${STD}:      	Activate Questasim WLF waveform trace recording in gap.wlf file"
	@echo -e " - ${BOLD}vsim/dofile=<filename>${STD}: 	Specify one do file located in \$VSIM_PATH/waves to record specific traces during a simulation"
	@echo -e " - ${BOLD}vsim/enablecov=1${STD}: 		Enable code coverage feature in Questasim"
	@echo -e ""
	@echo -e "##############################################"
	@echo -e "Available make target for vsim platform:"
	@echo -e "##############################################"
	@echo -e " - ${BOLD}clean_rtl${STD}: 				Clean compiled RTL platform"
	@echo -e " - ${BOLD}build_rtl${STD}: 				Compile RTL platform"
	@echo -e " - ${BOLD}vsim_debug${STD}: 				Questasim debug mode using only msimviewer licence."
	@echo -e " - ${BOLD}vsim_cov_report${STD}: 			Generate code coverage report"
	@echo -e " - ${BOLD}vsim_cov_gui${STD}: 			Open Questasim viewer in coverage mode"
	@echo -e " - ${BOLD}vsim_cov_html${STD}: 			Open firefox to view code coverage report in html format"
	@echo -e " - ${BOLD}vsim_cov_clean${STD}: 			Clean code coverage db"


VEGA_TOP_PATH=$(VSIM_PATH)/../../..

build_rtl:
	@pushd $(VEGA_TOP_PATH) && make -f $(VEGA_TOP_PATH)/Makefile build_rtl && popd

clean_rtl:
	@pushd $(VEGA_TOP_PATH) && make -f $(VEGA_TOP_PATH)/Makefile clean_rtl && popd


#########################################################################
### Questasim debug mode using only msimviewer licence
#########################################################################
vsim_debug:
	@vsim -view $(CONFIG_BUILD_DIR)/vega.wlf -do "$(CONFIG_BUILD_DIR)/waves/$(vsim/dofile)"


#########################################################################
### Questasim Coverage report generation
#########################################################################
vsim_cov_report:
	@vcover merge -out $(VSIM_PATH)/fe/sim/cov/vega_merged.ucdb $(VSIM_PATH)/fe/sim/cov
	@vcover report -details -source -html -htmldir $(VSIM_PATH)/fe/sim/cov_report_html $(VSIM_PATH)/fe/sim/cov/vega_merged.ucdb

vsim_cov_gui:
	@vsim -viewcov $(VSIM_PATH)/fe/sim/cov/vega_merged.ucdb	-do 'add testbrowser $(VSIM_PATH)/fe/sim/cov/vega_merged.ucdb' 

vsim_cov_html:
	@firefox $(VSIM_PATH)/fe/sim/cov_report_html/index.html &

vsim_cov_clean:
	@rm -rf $(VSIM_PATH)/fe/sim/cov $(VSIM_PATH)/fe/sim/cov_report_html

