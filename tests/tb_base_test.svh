`ifndef TB_BASE_TEST_SVH
`define TB_BASE_TEST_SVH
class tb_base_test extends tue_test #(tb_env_configuration);
  tb_env  env;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = tb_env::type_id::create("env", this);
    env.set_configuration(configuration);
  endfunction

  task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    configuration.clock_vif.start(10ns);
    configuration.reset_vif.initiate(1us);
    phase.drop_objection(this);
  endtask

  function void create_configuration();
    super.create_configuration();
    if (!configuration.apply_config_db(null, "")) begin
      return;
    end
    if (!configuration.randomize()) begin
      return;
    end
  endfunction

  `tue_component_default_constructor(tb_base_test)
endclass
`endif
