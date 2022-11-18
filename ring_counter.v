`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 04:45:16 PM
// Design Name: 
// Module Name: RingCounter
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


module RingCounter(
    input advance, 
    input clk, 
    output [3:0]o
    );
    
    FDRE #(.INIT(1'b0) ) rc1 (.C(clk), .CE(advance), .R(1'b0), .D(o[3]), .Q(o[0]));
    FDRE #(.INIT(1'b0) ) rc2 (.C(clk), .CE(advance), .R(1'b0), .D(o[0]), .Q(o[1]));
    FDRE #(.INIT(1'b0) ) rc3 (.C(clk), .CE(advance), .R(1'b0), .D(o[1]), .Q(o[2]));
    FDRE #(.INIT(1'b1) ) rc4 (.C(clk), .CE(advance), .R(1'b0), .D(o[2]), .Q(o[3]));
    
endmodule
