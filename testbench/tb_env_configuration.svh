`ifndef TB_ENV_CONFIGURATION_SVH
`define TB_ENV_CONFIGURATION_SVH
class tb_env_configuration extends tue_configuration;
        tvip_clock_vif          clock_vif;
        tvip_reset_vif          reset_vif;
  rand  tvip_apb_configuration  apb_configuration;

  constraint c_apb_configuration {
    apb_configuration.address_width == 16;
    apb_configuration.data_width    == 32;
  }

  function new(string name = "tb_env_configuration");
    super.new(name);
    apb_configuration = tvip_apb_configuration::type_id::create("apb_configuration");
  endfunction

  virtual function bit apply_config_db(
    uvm_component context_component, string instance_name
  );
    if (!uvm_config_db #(tvip_clock_vif)::get(
      context_component, instance_name, "clock_vif", clock_vif)
    ) begin
      return 0;
    end
    if (!uvm_config_db #(tvip_reset_vif)::get(
      context_component, instance_name, "reset_vif", reset_vif)
    ) begin
      return 0;
    end
    if (!apb_configuration.apply_config_db(context_component, "apb")) begin
      return 0;
    end
    return 1;
  endfunction

  `uvm_object_utils_begin(tb_env_configuration)
    `uvm_field_object(apb_configuration, UVM_DEFAULT)
  `uvm_object_utils_end
endclass
`endif
