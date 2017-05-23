module top();
  logic                   clk;
  logic                   rst_n;
  rggen_apb_if #(16, 32)  apb_if0();
  rggen_apb_if #( 7, 32)  apb_if1();
  rggen_bus_if #( 7, 32)  register_9_if();

  sample_0 u_sample_0 (
    .clk                    (clk      ),
    .rst_n                  (rst_n    ),
    .apb_if                 (apb_if0  ),
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

  sample_1 u_sample_1 (
    .clk              (clk      ),
    .rst_n            (rst_n    ),
    .apb_if           (apb_if1  ),
    .o_bit_field_0_0  (),
    .i_bit_field_0_1  ('0),
    .o_bit_field_1_0  (),
    .i_bit_field_2_0  ('0),
    .o_bit_field_2_1  ()
  );
endmodule

