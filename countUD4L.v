`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2022 01:38:34 PM
// Design Name: 
// Module Name: flip_flop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module leaf_counter(
    input clk, 
    input Up,
    input Dw, 
    input [9:0]Din, 
    input frame_signal, 
    input LD,  
    output [9:0] Q 
    
    );
  
    wire [9:0]D; 
    wire [9:0]out; 
    wire [9:0]U; 
    wire enable; 
    
    assign enable = (frame_signal | LD); 
    
    //assign UTC = (Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9]); 
   // assign DTC = (~Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4] & ~Q[5] & ~Q[6] & ~Q[7] & ~Q[8] & ~Q[9]);
    
//    assign U[0] = Q[0] ^ enable;                                              
//    assign U[1] = Q[1] ^ (enable & Q[0]);                                     
//    assign U[2] = Q[2] ^ (enable & Q[0] & Q[1]);                              
//    assign U[3] = Q[3] ^ (enable & Q[0] & Q[1] & Q[2]);                       
//    assign U[4] = Q[4] ^ (enable & Q[0] & Q[1] & Q[2] & Q[3]);                                              
//    assign U[5] = Q[5] ^ (enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4]);                                      
//    assign U[6] = Q[6] ^ (enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5]);                               
//    assign U[7] = Q[7] ^ (enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6]);                                
//    assign U[8] = Q[8] ^ (enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7]);
//    assign U[9] = Q[9] ^ (enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[9]);
    
    assign out[0] = (U[0] & Up & ~Dw) & ~LD | (D[0] & ~Up & Dw) & ~LD | (LD & Din[0]); 
    assign out[1] = (U[1] & Up & ~Dw) & ~LD | (D[1] & ~Up & Dw) & ~LD | (LD & Din[1]); 
    assign out[2] = (U[2] & Up & ~Dw) & ~LD | (D[2] & ~Up & Dw) & ~LD | (LD & Din[2]); 
    assign out[3] = (U[3] & Up & ~Dw) & ~LD | (D[3] & ~Up & Dw) & ~LD | (LD & Din[3]);
    assign out[4] = (U[4] & Up & ~Dw) & ~LD | (D[4] & ~Up & Dw) & ~LD | (LD & Din[4]); 
    assign out[5] = (U[5] & Up & ~Dw) & ~LD | (D[5] & ~Up & Dw) & ~LD | (LD & Din[5]); 
    assign out[6] = (U[6] & Up & ~Dw) & ~LD | (D[6] & ~Up & Dw) & ~LD | (LD & Din[6]); 
    assign out[7] = (U[7] & Up & ~Dw) & ~LD | (D[7] & ~Up & Dw) & ~LD | (LD & Din[7]);
    assign out[8] = (U[8] & Up & ~Dw) & ~LD | (D[8] & ~Up & Dw) & ~LD | (LD & Din[8]); 
    assign out[9] = (U[9] & Up & ~Dw) & ~LD | (D[9] & ~Up & Dw) & ~LD | (LD & Din[9]);
      
    
    assign D[0] = Q[0] ^ enable ; 
    assign D[1] = Q[1] ^ (enable & ~Q[0]);                           
    assign D[2] = Q[2] ^ (enable & ~Q[0] & ~Q[1]);                   
    assign D[3] = Q[3] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2]); 
    assign D[4] = Q[4] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2] & ~Q[3]); 
    assign D[5] = Q[5] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4]); 
    assign D[6] = Q[6] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4] & ~Q[5]); 
    assign D[7] = Q[7] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4] & ~Q[5] & ~Q[6]); 
    assign D[8] = Q[8] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4] & ~Q[5] & ~Q[6] & ~Q[7]); 
    assign D[9] = Q[9] ^ (enable & ~ Q[0] & ~Q[1] & ~Q[2] & ~Q[3] & ~Q[4] & ~Q[5] & ~Q[6] & ~Q[7] & ~Q[8]); 
    
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(enable), .D(out[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(enable), .D(out[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(enable), .D(out[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(enable), .D(out[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) Q4_FF (.C(clk), .CE(enable), .D(out[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0)) Q5_FF (.C(clk), .CE(enable), .D(out[5]), .Q(Q[5]));
    FDRE #(.INIT(1'b0)) Q6_FF (.C(clk), .CE(enable), .D(out[6]), .Q(Q[6]));
    FDRE #(.INIT(1'b0)) Q7_FF (.C(clk), .CE(enable), .D(out[7]), .Q(Q[7]));
    FDRE #(.INIT(1'b0)) Q8_FF (.C(clk), .CE(enable), .D(out[8]), .Q(Q[8]));
    FDRE #(.INIT(1'b0)) Q9_FF (.C(clk), .CE(enable), .D(out[9]), .Q(Q[9]));
                                                        
    
    
    
endmodule
