///////////////////////////////////////////////////////////////////////
////                                                               ////
////  testbench.svh                                                ////
////                                                               ////
////  Project : UVM Simulationsmodell eines JTAG-Interfaces        ////
////                                                               ////
////  Author(s):                                                   ////
////    Serin Varghese                                             ////
////    Micro and Nano Systems,                                    ////
////    TU Chemnitz                                                ////
////                                                               ////
////  Date: July 2017                                              ////
////                                                               ////
////  Notes:                                                       ////
////  This is the top module for the testbench. It defines the     //// 
////  DUT and the Interface. This module also starts the test.     ////
////                                                               ////
///////////////////////////////////////////////////////////////////////

`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"

module top;
  import uvm_pkg::*;
  import my_testbench_pkg::*;
  
  // Instantiate the interface
  dut_if dut_if1();
  
  // Instantiate the DUT and connect it to the interface
  dut dut1(.dif(dut_if1));
  
  // Clock generator
  initial begin
    dut_if1.TCK = 0;
    forever #5 dut_if1.TCK = ~dut_if1.TCK;
  end
  
  initial begin
    // Place the interface into the UVM configuration database
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_vif", dut_if1);
    // Start the test
    run_test("my_test");
  end
  
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
endmodule
