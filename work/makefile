export RGGEN_HOME	= $(shell cd ../; pwd)
export TVIP_HOME	= $(RGGEN_HOME)/vip
export TUE_HOME		= $(TVIP_HOME)/tue

GUI				?= off
DUMP			?= off
TR_DEBUG	?= off
TEST			?= tb_reg_hw_reset_test

BULDING_BLOCKS	= $(wildcard $(RGGEN_HOME)/rtl/*) $(wildcard $(RGGEN_HOME)/ral/*)
SAMPLE_RTL			= $(RGGEN_HOME)/sample/sample_0.sv $(RGGEN_HOME)/sample/sample_1.sv
SAMPLE_RAL			= $(RGGEN_HOME)/sample/sample_0_ral_pkg.sv $(RGGEN_HOME)/sample/sample_1_ral_pkg.sv
TESTBENCH				= $(wildcard $(RGGEN_HOME)/testbench/*)
TESTS						= $(wildcard $(RGGEN_HOME)/tests/*)

compile_options	=
runtime_options	=

compile_options	+= -full64 -sverilog -l log/compile.log -timescale="1ns/1ps"
compile_options	+= -ntb_opts uvm +define+UVM_NO_DEPRECATED +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTO
compile_options	+= -f $(TUE_HOME)/compile.f -f $(TVIP_HOME)/tvip_common/compile.f -f $(TVIP_HOME)/tvip_apb/compile.f
compile_options	+= -f $(RGGEN_HOME)/rtl/compile.f $(SAMPLE_RTL)
compile_options	+= -f $(RGGEN_HOME)/ral/compile.f $(SAMPLE_RAL)
compile_options	+= -f $(RGGEN_HOME)/testbench/compile.f
compile_options	+= -f $(RGGEN_HOME)/tests/compile.f
compile_options	+= $(RGGEN_HOME)/testbench/top.sv -top top

runtime_options	+= -l log/$(TEST).log +UVM_TESTNAME=$(TEST)

ifeq ($(GUI), on)
	compile_options	+= -lca -debug_access+all -kdb +vcs+fsdbon -top uvm_custom_install_recording -top uvm_custom_install_verdi_recording
	runtime_options	+= -verdi
else
ifeq ($(DUMP), on)
	compile_options	+= -lca -debug_access -kdb +vcs+fsdbon
	runtime_options	+= +fsdbfile+dump/$(TEST).fsdb
endif
endif
ifeq ($(TR_DEBUG), on)
	runtime_options	+= +UVM_VERDI_TRACE +UVM_TR_RECORD
endif

run: simv
	./simv $(runtime_options)

simv: $(BULDING_BLOCKS) $(TARGET_RTL) $(TARGET_RAL) $(TESTBENCH) $(TESTS)
	if [ ! -d log ] ; then mkdir log ; fi
	vcs $(compile_options)

CLEAN_EXCLUSIONS	= makefile log dump . ..
.PHONY: clean
clean:
	rm -rf $(filter-out $(CLEAN_EXCLUSIONS), $(shell ls -a))

clean_all: clean
	rm -rf log dump
