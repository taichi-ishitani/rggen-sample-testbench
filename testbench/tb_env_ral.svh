`ifndef TB_ENV_RALSVH
`define TB_ENV_RALSVH
class tb_env_ral extends tue_component #(tb_env_configuration);
  uvm_analysis_export #(tvip_apb_master_item) bus_in;

  tb_env_ral_model              ral_model;
  tvip_apb_master_ral_adapter   ral_adapter;
  tvip_apb_master_ral_predictor ral_predictor;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    bus_in        = new("bus_in", this);
    ral_model     = tb_env_ral_model::type_id::create("ral_model");
    ral_adapter   = tvip_apb_master_ral_adapter::type_id::create("ral_adapter");
    ral_predictor = tvip_apb_master_ral_predictor::type_id::create("ral_predictor", this);

    ral_model.configure(null, null, "top.u_sample_0");
    ral_model.build();
    ral_model.register_9.set_hdl_path_root("top.u_sample_1");
    ral_model.lock_model();
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    bus_in.connect(ral_predictor.bus_in);
    ral_predictor.map     = ral_model.default_map;
    ral_predictor.adapter = ral_adapter;
  endfunction

  task run_phase(uvm_phase phase);
    forever @(negedge configuration.reset_vif.reset_n) begin
      ral_model.reset();
    end
  endtask

  function void connect_sequencer(tvip_apb_master_sequencer sequencer);
    ral_model.default_map.set_sequencer(sequencer, ral_adapter);
  endfunction

  `tue_component_default_constructor(tb_env_ral)
  `uvm_component_utils(tb_env_ral)
endclass
`endif
