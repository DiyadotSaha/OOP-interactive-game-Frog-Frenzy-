`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2022 01:14:18 PM
// Design Name: 
// Module Name: Edge_detector
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


module Edge_detector(
    input x,
    input clk,
    output o
    );
    wire Q0, Q1;

    FDRE #(.INIT(1'b0)) ed1 (.CE(1'b1), .C(clk), .D(x), .Q(Q0));
    FDRE #(.INIT(1'b0)) ed2 (.CE(1'b1), .C(clk), .D(Q0), .Q(Q1));
    assign o = x & ~Q0 & ~ Q1;
    
endmodule
