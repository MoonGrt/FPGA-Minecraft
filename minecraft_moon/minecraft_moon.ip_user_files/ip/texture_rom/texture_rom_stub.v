// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Aug 18 14:44:18 2024
// Host        : DESKTOP-0TSH46O running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/Project/FPAG/Vivado_18.3/minecraft_moon/minecraft_moon.srcs/sources_1/ip/texture_rom/texture_rom_stub.v
// Design      : texture_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010iclg225-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module texture_rom(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[12:0],douta[31:0]" */;
  input clka;
  input ena;
  input [12:0]addra;
  output [31:0]douta;
endmodule
