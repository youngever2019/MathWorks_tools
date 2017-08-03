// -------------------------------------------------------------
//
// Module: fir_decim
// Generated by MATLAB(R) 9.0 and the Filter Design HDL Coder 3.0.
// Generated on: 2016-07-05 15:45:22
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// FIRAdderStyle: tree
// OptimizeForHDL: on
// EDAScriptGeneration: off
// AddPipelineRegisters: on
// Name: fir_decim
// TargetLanguage: Verilog
// TestBenchName: fo_copy_tb
// TestBenchStimulus: step ramp chirp noise 
// GenerateHDLTestBench: off

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// Multipliers           : 6
// Folding Factor        : 1
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time FIR Multirate Filter (real)
// -----------------------------------------
// Filter Structure   : Direct-Form FIR Polyphase Decimator
// Decimation Factor  : 2
// Polyphase Length   : 3
// Filter Length      : 6
// Stable             : Yes
// Linear Phase       : Yes (Type 2)
//
// Arithmetic         : fixed
// Numerator          : s12,11 -> [-1 1)
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module fir_decim
               (
                clk,
                clk_enable,
                reset,
                filter_in,
                filter_out,
                ce_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [11:0] filter_in; //sfix12_En11
  output  signed [25:0] filter_out; //sfix26_En22
  output  ce_out; 

////////////////////////////////////////////////////////////////
//Module Architecture: fir_decim
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [11:0] coeffphase1_1 = 12'b000011010101; //sfix12_En11
  parameter signed [11:0] coeffphase1_2 = 12'b011011110010; //sfix12_En11
  parameter signed [11:0] coeffphase1_3 = 12'b110000111110; //sfix12_En11
  parameter signed [11:0] coeffphase2_1 = 12'b110000111110; //sfix12_En11
  parameter signed [11:0] coeffphase2_2 = 12'b011011110010; //sfix12_En11
  parameter signed [11:0] coeffphase2_3 = 12'b000011010101; //sfix12_En11

  // Signals
  reg  [1:0] ring_count; // ufix2
  wire phase_0; // boolean
  wire phase_1; // boolean
  reg  ce_out_reg; // boolean
  reg  signed [11:0] input_register; // sfix12_En11
  reg  signed [11:0] input_pipeline_phase0 [0:1] ; // sfix12_En11
  reg  signed [11:0] input_pipeline_phase1 [0:2] ; // sfix12_En11
  wire signed [23:0] product_phase0_1; // sfix24_En22
  wire signed [23:0] product_phase0_2; // sfix24_En22
  wire signed [23:0] product_phase0_3; // sfix24_En22
  wire signed [23:0] product_phase1_1; // sfix24_En22
  wire signed [23:0] product_phase1_2; // sfix24_En22
  wire signed [23:0] product_phase1_3; // sfix24_En22
  reg  signed [23:0] product_pipeline_phase0_1; // sfix24_En22
  reg  signed [23:0] product_pipeline_phase0_2; // sfix24_En22
  reg  signed [23:0] product_pipeline_phase0_3; // sfix24_En22
  reg  signed [23:0] product_pipeline_phase1_1; // sfix24_En22
  reg  signed [23:0] product_pipeline_phase1_2; // sfix24_En22
  reg  signed [23:0] product_pipeline_phase1_3; // sfix24_En22
  wire signed [25:0] sumvector1 [0:2] ; // sfix26_En22
  wire signed [23:0] add_signext; // sfix24_En22
  wire signed [23:0] add_signext_1; // sfix24_En22
  wire signed [24:0] add_temp; // sfix25_En22
  wire signed [23:0] add_signext_2; // sfix24_En22
  wire signed [23:0] add_signext_3; // sfix24_En22
  wire signed [24:0] add_temp_1; // sfix25_En22
  wire signed [23:0] add_signext_4; // sfix24_En22
  wire signed [23:0] add_signext_5; // sfix24_En22
  wire signed [24:0] add_temp_2; // sfix25_En22
  reg  signed [25:0] sumdelay_pipeline1 [0:2] ; // sfix26_En22
  wire signed [25:0] sumvector2 [0:1] ; // sfix26_En22
  wire signed [25:0] add_signext_6; // sfix26_En22
  wire signed [25:0] add_signext_7; // sfix26_En22
  wire signed [26:0] add_temp_3; // sfix27_En22
  reg  signed [25:0] sumdelay_pipeline2 [0:1] ; // sfix26_En22
  wire signed [25:0] sum3; // sfix26_En22
  wire signed [25:0] add_signext_8; // sfix26_En22
  wire signed [25:0] add_signext_9; // sfix26_En22
  wire signed [26:0] add_temp_4; // sfix27_En22
  reg  ce_delayline1; // boolean
  reg  ce_delayline2; // boolean
  reg  ce_delayline3; // boolean
  reg  ce_delayline4; // boolean
  reg  ce_delayline5; // boolean
  reg  ce_delayline6; // boolean
  reg  ce_delayline7; // boolean
  reg  ce_delayline8; // boolean
  wire ce_gated; // boolean
  reg  signed [25:0] output_register; // sfix26_En22

  // Block Statements
  always @ (posedge clk or posedge reset)
    begin: ce_output
      if (reset == 1'b1) begin
        ring_count <= 1;
      end
      else begin
                if (clk_enable == 1'b1) begin
        ring_count <= {ring_count[0], ring_count[1]};
              end
            end
    end // ce_output

  assign  phase_0 = ring_count[0]  && clk_enable;

  assign  phase_1 = ring_count[1]  && clk_enable;

  //   ------------------ CE Output Register ------------------

  always @ (posedge clk or posedge reset)
    begin: ce_output_register
      if (reset == 1'b1) begin
        ce_out_reg <= 1'b0;
      end
      else begin
          ce_out_reg <= phase_1;
      end
    end // ce_output_register

  always @ (posedge clk or posedge reset)
    begin: input_reg_process
      if (reset == 1'b1) begin
        input_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          input_register <= filter_in;
        end
      end
    end // input_reg_process

  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_Phase0_process
      if (reset == 1'b1) begin
        input_pipeline_phase0[0] <= 0;
        input_pipeline_phase0[1] <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          input_pipeline_phase0[0] <= input_register;
          input_pipeline_phase0[1] <= input_pipeline_phase0[0];
        end
      end
    end // Delay_Pipeline_Phase0_process


  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_Phase1_process
      if (reset == 1'b1) begin
        input_pipeline_phase1[0] <= 0;
        input_pipeline_phase1[1] <= 0;
        input_pipeline_phase1[2] <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          input_pipeline_phase1[0] <= input_register;
          input_pipeline_phase1[1] <= input_pipeline_phase1[0];
          input_pipeline_phase1[2] <= input_pipeline_phase1[1];
        end
      end
    end // Delay_Pipeline_Phase1_process


  assign product_phase0_1 = input_register * coeffphase1_1;

  assign product_phase0_2 = input_pipeline_phase0[0] * coeffphase1_2;

  assign product_phase0_3 = input_pipeline_phase0[1] * coeffphase1_3;

  assign product_phase1_1 = input_pipeline_phase1[0] * coeffphase2_1;

  assign product_phase1_2 = input_pipeline_phase1[1] * coeffphase2_2;

  assign product_phase1_3 = input_pipeline_phase1[2] * coeffphase2_3;

  always @ (posedge clk or posedge reset)
    begin: product_pipeline_process1
      if (reset == 1'b1) begin
        product_pipeline_phase0_1 <= 0;
        product_pipeline_phase1_1 <= 0;
        product_pipeline_phase0_2 <= 0;
        product_pipeline_phase1_2 <= 0;
        product_pipeline_phase0_3 <= 0;
        product_pipeline_phase1_3 <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          product_pipeline_phase0_1 <= product_phase0_1;
          product_pipeline_phase1_1 <= product_phase1_1;
          product_pipeline_phase0_2 <= product_phase0_2;
          product_pipeline_phase1_2 <= product_phase1_2;
          product_pipeline_phase0_3 <= product_phase0_3;
          product_pipeline_phase1_3 <= product_phase1_3;
        end
      end
    end // product_pipeline_process1

  assign add_signext = product_pipeline_phase1_1;
  assign add_signext_1 = product_pipeline_phase1_2;
  assign add_temp = add_signext + add_signext_1;
  assign sumvector1[0] = $signed({{1{add_temp[24]}}, add_temp});

  assign add_signext_2 = product_pipeline_phase1_3;
  assign add_signext_3 = product_pipeline_phase0_1;
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sumvector1[1] = $signed({{1{add_temp_1[24]}}, add_temp_1});

  assign add_signext_4 = product_pipeline_phase0_2;
  assign add_signext_5 = product_pipeline_phase0_3;
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sumvector1[2] = $signed({{1{add_temp_2[24]}}, add_temp_2});

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process1
      if (reset == 1'b1) begin
        sumdelay_pipeline1[0] <= 0;
        sumdelay_pipeline1[1] <= 0;
        sumdelay_pipeline1[2] <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          sumdelay_pipeline1[0] <= sumvector1[0];
          sumdelay_pipeline1[1] <= sumvector1[1];
          sumdelay_pipeline1[2] <= sumvector1[2];
        end
      end
    end // sumdelay_pipeline_process1

  assign add_signext_6 = sumdelay_pipeline1[0];
  assign add_signext_7 = sumdelay_pipeline1[1];
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sumvector2[0] = add_temp_3[25:0];

  assign sumvector2[1] = sumdelay_pipeline1[2];

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process2
      if (reset == 1'b1) begin
        sumdelay_pipeline2[0] <= 0;
        sumdelay_pipeline2[1] <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          sumdelay_pipeline2[0] <= sumvector2[0];
          sumdelay_pipeline2[1] <= sumvector2[1];
        end
      end
    end // sumdelay_pipeline_process2

  assign add_signext_8 = sumdelay_pipeline2[0];
  assign add_signext_9 = sumdelay_pipeline2[1];
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sum3 = add_temp_4[25:0];

  always @ (posedge clk or posedge reset)
    begin: ce_delay
      if (reset == 1'b1) begin
        ce_delayline1 <= 1'b0;
        ce_delayline2 <= 1'b0;
        ce_delayline3 <= 1'b0;
        ce_delayline4 <= 1'b0;
        ce_delayline5 <= 1'b0;
        ce_delayline6 <= 1'b0;
        ce_delayline7 <= 1'b0;
        ce_delayline8 <= 1'b0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          ce_delayline1 <= clk_enable;
          ce_delayline2 <= ce_delayline1;
          ce_delayline3 <= ce_delayline2;
          ce_delayline4 <= ce_delayline3;
          ce_delayline5 <= ce_delayline4;
          ce_delayline6 <= ce_delayline5;
          ce_delayline7 <= ce_delayline6;
          ce_delayline8 <= ce_delayline7;
        end
      end
    end // ce_delay

  assign ce_gated =  ce_delayline8 & ce_out_reg;

  always @ (posedge clk or posedge reset)
    begin: output_register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          output_register <= sum3;
        end
      end
    end // output_register_process

  // Assignment Statements
  assign ce_out = ce_gated;
  assign filter_out = output_register;
endmodule  // fir_decim