module top();
  import  uvm_pkg::*;
  import  rggen_rtl_pkg::*;

  tvip_clock_if clock_if();
  initial begin
    uvm_config_db #(virtual tvip_clock_if)::set(null, "", "clock_vif", clock_if);
  end

  tvip_reset_if reset_if();
  initial begin
    uvm_config_db #(virtual tvip_reset_if)::set(null, "", "reset_vif", reset_if);
  end

  tvip_apb_if apb_if(clock_if.clk, reset_if.reset_n);
  initial begin
    uvm_config_db #(virtual tvip_apb_if)::set(null, "apb", "vif", apb_if);
  end

  rggen_apb_if #(16, 32)  apb_if0();
  rggen_apb_if #( 7, 32)  apb_if1();
  rggen_bus_if #( 7, 32)  register_9_if();

  sample_0 u_sample_0 (
    .clk                    (clock_if.clk     ),
    .rst_n                  (reset_if.reset_n ),
    .apb_if                 (apb_if0          ),
    .o_irq                  (),
    .o_bit_field_0_0        (),
    .o_bit_field_0_1        (),
    .o_bit_field_1_0        (),
    .i_bit_field_2_0        ('0),
    .o_bit_field_2_1        (),
    .i_bit_field_3_0        ('0),
    .i_bit_field_4_0        ('{'0, '0, '0, '0}),
    .o_bit_field_4_1        (),
    .i_bit_field_5_0        ('{'{'0, '0, '0, '0}, '{'0, '0, '0, '0}}),
    .o_bit_field_5_1        (),
    .i_bit_field_6_0_set    ('0),
    .i_bit_field_6_1_set    ('0),
    .o_bit_field_7_0        (),
    .i_bit_field_7_0_clear  ('0),
    .o_bit_field_7_1        (),
    .i_bit_field_7_1_clear  ('0),
    .o_bit_field_8_0        (),
    .o_bit_field_8_1        (),
    .register_9_bus_if      (register_9_if  )
  );

  assign  apb_if1.psel    = register_9_if.request;
  assign  apb_if1.penable = register_9_if.request;
  assign  apb_if1.paddr   = register_9_if.address;
  assign  apb_if1.pprot   = '0;
  assign  apb_if1.pwrite  = register_9_if.direction;
  assign  apb_if1.pwdata  = register_9_if.write_data;
  assign  apb_if1.pstrb   = register_9_if.write_strobe;

  assign  register_9_if.done        = apb_if1.pready;
  assign  register_9_if.read_done   = (apb_if1.pready && (!apb_if1.pwrite)) ? 1 : 0;
  assign  register_9_if.write_done  = (apb_if1.pready &&   apb_if1.pwrite ) ? 1 : 0;
  assign  register_9_if.read_data   = apb_if1.prdata;
  assign  register_9_if.status      = (apb_if1.pslverr) ? RGGEN_SLAVE_ERROR : RGGEN_OKAY;

  sample_1 u_sample_1 (
    .clk              (clock_if.clk     ),
    .rst_n            (reset_if.reset_n ),
    .apb_if           (apb_if1          ),
    .o_bit_field_0_0  (),
    .i_bit_field_0_1  ('0),
    .o_bit_field_1_0  (),
    .i_bit_field_2_0  ('0),
    .o_bit_field_2_1  ()
  );

  initial begin
    run_test();
  end
endmodule

