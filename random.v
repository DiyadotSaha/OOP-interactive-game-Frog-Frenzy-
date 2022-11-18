`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2022 02:05:18 PM
// Design Name: 
// Module Name: random
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


module random(
input clk,
output [7:0] out
);
wire xor_wire;
wire [7:0]rnd;

assign xor_wire = rnd[0] ^ rnd[5] ^ rnd[6] ^ rnd[7];

FDRE #(.INIT(1'b1)) r1 (.C(clk), .CE(1'b1), .D(xor_wire),.Q(rnd[0]));
FDRE #(.INIT(1'b0)) r2 (.C(clk), .CE(1'b1), .D(rnd[0]),.Q(rnd[1]));
FDRE #(.INIT(1'b0)) r3 (.C(clk), .CE(1'b1), .D(rnd[1]),.Q(rnd[2]));
FDRE #(.INIT(1'b0)) r4 (.C(clk), .CE(1'b1), .D(rnd[2]),.Q(rnd[3]));
FDRE #(.INIT(1'b0)) r5 (.C(clk), .CE(1'b1), .D(rnd[3]),.Q(rnd[4]));
FDRE #(.INIT(1'b0)) r6 (.C(clk), .CE(1'b1), .D(rnd[4]),.Q(rnd[5]));
FDRE #(.INIT(1'b0)) r7 (.C(clk), .CE(1'b1), .D(rnd[5]),.Q(rnd[6]));
FDRE #(.INIT(1'b0)) r8 (.C(clk), .CE(1'b1), .D(rnd[6]),.Q(rnd[7]));

assign out = {1'b0, 1'b0, rnd[5:0]};

endmodule
