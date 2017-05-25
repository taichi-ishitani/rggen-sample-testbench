`ifndef TB_RAL_TEST_SVH
`define TB_RAL_TEST_SVH
class tb_ral_test #(
  type  RAL_SEQUENCE  = uvm_reg_hw_reset_seq
) extends tb_base_test;
  tue_sequencer #() sequencer;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = tue_sequencer #()::type_id::create("sequencer", this);
  endfunction

  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    run_ral_sequence();
    phase.drop_objection(this);
  endtask

  task run_ral_sequence();
    RAL_SEQUENCE  ral_sequence;
    ral_sequence        = new("ral_sequence");
    ral_sequence.model  = env.ral_model;
    ral_sequence.start(sequencer);
  endtask

  `tue_component_default_constructor(tb_ral_test)
endclass

class tb_reg_hw_reset_test extends tb_ral_test #(uvm_reg_hw_reset_seq);
  `tue_component_default_constructor(tb_reg_hw_reset_test)
  `uvm_component_utils(tb_reg_hw_reset_test)
endclass

class tb_reg_bit_bash_test extends tb_ral_test #(uvm_reg_bit_bash_seq);
  `tue_component_default_constructor(tb_reg_bit_bash_test)
  `uvm_component_utils(tb_reg_bit_bash_test)
endclass

class tb_reg_access_test extends tb_ral_test #(uvm_reg_access_seq);
  `tue_component_default_constructor(tb_reg_access_test)
  `uvm_component_utils(tb_reg_access_test)
endclass
`endif
