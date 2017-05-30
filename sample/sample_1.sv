module sample_1 (
  input clk,
  input rst_n,
  rggen_apb_if.slave apb_if,
  output [15:0] o_bit_field_0_0,
  input [15:0] i_bit_field_0_1,
  output [31:0] o_bit_field_1_0,
  input i_bit_field_2_0,
  output o_bit_field_2_1
);
  rggen_register_if #(7, 32) register_if[3]();
  `define rggen_connect_bit_field_if(RIF, FIF, MSB, LSB) \
    assign  FIF.read_access         = RIF.read_access; \
    assign  FIF.write_access        = RIF.write_access; \
    assign  FIF.write_data          = RIF.write_data[MSB:LSB]; \
    assign  FIF.write_mask          = RIF.write_mask[MSB:LSB]; \
    assign  RIF.value[MSB:LSB]      = FIF.value; \
    assign  RIF.read_data[MSB:LSB]  = FIF.read_data;
  rggen_host_if_apb #(
    .LOCAL_ADDRESS_WIDTH  (7),
    .DATA_WIDTH           (32),
    .TOTAL_REGISTERS      (3)
  ) u_host_if (
    .clk          (clk),
    .rst_n        (rst_n),
    .apb_if       (apb_if),
    .register_if  (register_if)
  );
  generate if (1) begin : g_register_0
    rggen_bit_field_if #(32) bit_field_if();
    rggen_default_register #(
      .ADDRESS_WIDTH  (7),
      .START_ADDRESS  (7'h00),
      .END_ADDRESS    (7'h03),
      .DATA_WIDTH     (32),
      .VALID_BITS     (32'hffffffff)
    ) u_register (
      .register_if  (register_if[0]),
      .bit_field_if (bit_field_if)
    );
    if (1) begin : g_bit_field_0_0
      rggen_bit_field_if #(16) bit_field_sub_if();
      `rggen_connect_bit_field_if(bit_field_if, bit_field_sub_if, 31, 16)
      rggen_bit_field_rw #(
        .WIDTH          (16),
        .INITIAL_VALUE  (16'h0000)
      ) u_bit_field (
        .clk          (clk),
        .rst_n        (rst_n),
        .bit_field_if (bit_field_sub_if),
        .o_value      (o_bit_field_0_0)
      );
    end
    if (1) begin : g_bit_field_0_1
      rggen_bit_field_if #(16) bit_field_sub_if();
      `rggen_connect_bit_field_if(bit_field_if, bit_field_sub_if, 15, 0)
      rggen_bit_field_ro #(
        .WIDTH  (16)
      ) u_bit_field (
        .bit_field_if (bit_field_sub_if),
        .i_value      (i_bit_field_0_1)
      );
    end
  end endgenerate
  generate if (1) begin : g_register_1
    rggen_bit_field_if #(32) bit_field_if();
    rggen_default_register #(
      .ADDRESS_WIDTH  (7),
      .START_ADDRESS  (7'h04),
      .END_ADDRESS    (7'h07),
      .DATA_WIDTH     (32),
      .VALID_BITS     (32'hffffffff)
    ) u_register (
      .register_if  (register_if[1]),
      .bit_field_if (bit_field_if)
    );
    if (1) begin : g_bit_field_1_0
      rggen_bit_field_if #(32) bit_field_sub_if();
      `rggen_connect_bit_field_if(bit_field_if, bit_field_sub_if, 31, 0)
      rggen_bit_field_rw #(
        .WIDTH          (32),
        .INITIAL_VALUE  (32'h00000000)
      ) u_bit_field (
        .clk          (clk),
        .rst_n        (rst_n),
        .bit_field_if (bit_field_sub_if),
        .o_value      (o_bit_field_1_0)
      );
    end
  end endgenerate
  generate if (1) begin : g_register_2
    rggen_bit_field_if #(32) bit_field_if();
    rggen_default_register #(
      .ADDRESS_WIDTH  (7),
      .START_ADDRESS  (7'h08),
      .END_ADDRESS    (7'h0b),
      .DATA_WIDTH     (32),
      .VALID_BITS     (32'h00010001)
    ) u_register (
      .register_if  (register_if[2]),
      .bit_field_if (bit_field_if)
    );
    if (1) begin : g_bit_field_2_0
      rggen_bit_field_if #(1) bit_field_sub_if();
      `rggen_connect_bit_field_if(bit_field_if, bit_field_sub_if, 16, 16)
      rggen_bit_field_ro #(
        .WIDTH  (1)
      ) u_bit_field (
        .bit_field_if (bit_field_sub_if),
        .i_value      (i_bit_field_2_0)
      );
    end
    if (1) begin : g_bit_field_2_1
      rggen_bit_field_if #(1) bit_field_sub_if();
      `rggen_connect_bit_field_if(bit_field_if, bit_field_sub_if, 0, 0)
      rggen_bit_field_rw #(
        .WIDTH          (1),
        .INITIAL_VALUE  (1'h0)
      ) u_bit_field (
        .clk          (clk),
        .rst_n        (rst_n),
        .bit_field_if (bit_field_sub_if),
        .o_value      (o_bit_field_2_1)
      );
    end
  end endgenerate
  `undef rggen_connect_bit_field_if
endmodule
