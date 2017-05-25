`ifndef TB_ENV_SVH
`define TB_ENV_SHV
class tb_env extends tue_env #(tb_env_configuration);
  tb_env_ral_model  ral_model;

  tvip_apb_master_agent apb_master_agent;
  tb_env_ral            ral;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    apb_master_agent  = tvip_apb_master_agent::type_id::create("apb_master_agent", this);
    apb_master_agent.set_configuration(configuration.apb_configuration);

    ral = tb_env_ral::type_id::create("ral", this);
    ral.set_configuration(configuration);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ral_model = ral.ral_model;
    apb_master_agent.item_port.connect(ral.bus_in);
    ral.connect_sequencer(apb_master_agent.sequencer);
  endfunction

  `tue_component_default_constructor(tb_env)
  `uvm_component_utils(tb_env)
endclass
`endif
