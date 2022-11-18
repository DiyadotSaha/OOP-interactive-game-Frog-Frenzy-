`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2022 04:32:46 PM
// Design Name: 
// Module Name: hex_7_seg
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


module hex7seg(
 input [3:0]n, 
 output [6:0] seg 
 );
 
 mux8_1 ca (.in({1'b0, n[0], n[0], 1'b0, 1'b0, ~n[0], 1'b0,n[0]}), .sel({n[3], n[2], n[1]}), .o(seg[0]));
 mux8_1 cb (.in({1'b1,~n[0], n[0], 1'b0,~n[0], n[0], 1'b0,1'b0}), .sel({n[3], n[2], n[1]}), .o(seg[1]));
 mux8_1 cc (.in({1'b1, ~n[0],1'b0, 1'b0, 1'b0, 1'b0, ~n[0],1'b0}), .sel({n[3], n[2], n[1]}), .o(seg[2]));
 mux8_1 cd (.in({n[0],1'b0,~n[0],n[0], n[0], ~n[0], 1'b0, n[0]}), .sel({n[3], n[2], n[1]}), .o(seg[3]));
 mux8_1 ce (.in({1'b0, 1'b0, 1'b0, n[0], n[0],1'b1,n[0], n[0]}), .sel({n[3], n[2], n[1]}), .o(seg[4]));
 mux8_1 cf (.in({1'b0,n[0], 1'b0, 1'b0, n[0], 1'b0,1'b1, n[0]}), .sel({n[3], n[2], n[1]}), .o(seg[5]));
 mux8_1 cg (.in({1'b0,~n[0],1'b0, 1'b0,n[0] ,1'b0, 1'b0, 1'b1 }), .sel({n[3], n[2], n[1]}), .o(seg[6]));
 

endmodule

