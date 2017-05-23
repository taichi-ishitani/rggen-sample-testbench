export RGGEN_HOME	= $(shell cd ../; pwd)

BULDING_BLOCKS	= $(wildcard $(RGGEN_HOME)/rtl/*) $(wildcard $(RGGEN_HOME)/ral/*)
SAMPLE_RTL			= $(RGGEN_HOME)/sample/sample_0.sv $(RGGEN_HOME)/sample/sample_1.sv
SAMPLE_RAL			= $(RGGEN_HOME)/sample/sample_0_ral_pkg.sv $(RGGEN_HOME)/sample/sample_1_ral_pkg.sv

simv: $(TARGET_RTL) $(TARGET_RAL)
	if [ ! -d log ] ; then mkdir log ; fi
	vcs \
	-full64 \
	-sverilog \
	-ntb_opts uvm \
	-l log/compile.log \
	-f $(RGGEN_HOME)/rtl/compile.f \
	$(SAMPLE_RTL) \
	-f $(RGGEN_HOME)/ral/compile.f \
	$(SAMPLE_RAL) \
	$(RGGEN_HOME)/testbench/top.sv

.PHONY: clean_all
clean_all:
	rm -rf log
