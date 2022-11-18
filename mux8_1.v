`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 04:30:50 PM
// Design Name: 
// Module Name: mux8_1
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


module mux8_1(
 input [7:0] in,
 input [2:0] sel, 
 output o
 );
 
 assign o = (in[0]&~sel[2]&~sel[1]&~sel[0]) | (in[1]&~sel[2]&~sel[1]&sel[0]) | (in[2]&~sel[2]&sel[1]&~sel[0]) | 
(in[3]&~sel[2]&sel[1]&sel[0]) | (in[4]&sel[2]&~sel[1]&~sel[0]) | (in[5]&sel[2]&~sel[1]&sel[0]) | (in[6]&sel[2]&sel[1]&~sel[0]) | 
(in[7]&sel[2]&sel[1]&sel[0]);
endmodule

