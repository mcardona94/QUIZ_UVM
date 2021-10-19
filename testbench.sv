//`timescale 1ns / 1ps
`define LENGTH  4
//`include "detector_secuencia.sv"
`include "interfaz.sv"
`include "item_secuencia.sv"
`include "secuencia.sv"
`include "monitor.sv"
`include "driver.sv"
`include "scoreboard.sv"
`include "agente.sv"
`include "ambiente.sv"
`include "test.sv"

module tb;
  import uvm_pkg::*;
  reg clk;

  always #10 clk =~ clk;
  dut_if _if(clk);

  det_1011 u0 (.clk(clk),
               .rstn(_if.rstn),
               .in(_if.in),
               .out(_if.out));
  initial begin
    clk <= 0;
    uvm_config_db#(virtual dut_if)::set(null,"uvm_test_top","dut_vif",_if);
    run_test("base_test");
  end
endmodule