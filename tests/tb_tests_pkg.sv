`ifndef TB_TESTS_PKG_SV
`define TB_TESTS_PKG_SV
package tb_tests_pkg;
  timeunit  1ns;

  import  uvm_pkg::*;
  import  tue_pkg::*;
  import  tb_env_pkg::*;

  `include  "uvm_macros.svh"
  `include  "tue_macros.svh"

  `include  "tb_base_test.svh"
  `include  "tb_ral_test.svh"
endpackage
`endif
