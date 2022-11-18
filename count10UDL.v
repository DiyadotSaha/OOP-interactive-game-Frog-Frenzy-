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


module count10UDL(
    input clk, 
    input CE,  
    input r, 
    output [9:0]o 
    //input down
    );
 
    wire [9:0]U;
  
     
    //assign CE = up ^ down; 
     
    FDRE #(.INIT(1'b0)) Q0_FF (.R(r), .C(clk), .CE(CE), .D(U[0]), .Q(o[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.R(r), .C(clk), .CE(CE), .D(U[1]), .Q(o[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.R(r), .C(clk), .CE(CE), .D(U[2]), .Q(o[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.R(r), .C(clk), .CE(CE), .D(U[3]), .Q(o[3]));
    FDRE #(.INIT(1'b0)) Q4_FF (.R(r), .C(clk), .CE(CE), .D(U[4]), .Q(o[4]));
    FDRE #(.INIT(1'b0)) Q5_FF (.R(r), .C(clk), .CE(CE), .D(U[5]), .Q(o[5]));
    FDRE #(.INIT(1'b0)) Q6_FF (.R(r), .C(clk), .CE(CE), .D(U[6]), .Q(o[6]));
    FDRE #(.INIT(1'b0)) Q7_FF (.R(r), .C(clk), .CE(CE), .D(U[7]), .Q(o[7]));
    FDRE #(.INIT(1'b0)) Q8_FF (.R(r), .C(clk), .CE(CE), .D(U[8]), .Q(o[8]));
    FDRE #(.INIT(1'b0)) Q9_FF (.R(r), .C(clk), .CE(CE), .D(U[9]), .Q(o[9]));
       
    //increament 
    assign U[0] = o[0] ^ CE; 
    assign U[1] = o[1] ^ (o[0] & CE); 
    assign U[2] = o[2] ^ (o[1] & o[0] & CE); 
    assign U[3] = o[3] ^ (o[2] & o[1] & o[0] & CE);
    assign U[4] = o[4] ^ (o[3] & o[2] & o[1] & o[0] & CE); 
    assign U[5] = o[5] ^ (o[4] & o[3] & o[2] & o[1] & o[0] & CE); 
    assign U[6] = o[6] ^ (o[5] & o[4] & o[3] & o[2] & o[1] & o[0] & CE);
    assign U[7] = o[7] ^ (o[6] & o[5] & o[4] & o[3] & o[2] & o[1] & o[0] & CE);
    assign U[8] = o[8] ^ (o[7] & o[6] & o[5] & o[4] & o[3] & o[2] & o[1] & o[0] & CE);
    assign U[9] = o[9] ^ (o[8] & o[7] & o[6] & o[5] & o[4] & o[3] & o[2] & o[1] & o[0] & CE);
     
   
    //decrement 
    /*assign D[0] = o[0] ^ CE; 
    assign D[1] = o[1] ^ (~o[0] & CE); 
    assign D[2] = o[2] ^ (~o[1] & ~o[0] & CE); 
    assign D[3] = o[3] ^ (~o[2] & ~o[1] & ~o[0] & CE);
    assign D[4] = o[4] ^ (~o[3] & ~o[2] & ~o[1] & ~o[0] & CE); 
    assign D[5] = o[5] ^ (~o[4] & ~o[3] & ~o[2] & ~o[1] & ~o[0] & CE); 
    assign D[6] = o[6] ^ (~o[5] & ~o[4] & ~o[3] & ~o[2] & ~o[1] & ~o[0] & CE);
    assign D[7] = o[7] ^ (~o[6] & ~o[5] & ~o[4] & ~o[3] & ~o[2] & ~o[1] & ~o[0] & CE); 
    assign D[8] = o[8] ^ (~o[7] & ~o[6] & ~o[5] & ~o[4] & ~o[3] & ~o[2] & ~o[1] & ~o[0] & CE);
    assign D[9] = o[9] ^ (~o[8] & ~o[7] & ~o[6] & ~o[5] & ~o[4] & ~o[3] & ~o[2] & ~o[1] & ~o[0] & CE);*/
    
    //assign up = (o[0] & o[1] & o[2] & o[3] & o[4] & o[5] & o[6] & o[7] & o[8] & o[9]);
    //assign down = (~o[0] & ~o[1] & ~o[2] & ~o[3] & ~o[4] & ~o[5] & ~o[6] & ~o[7] & ~o[8] & ~o[9]); 

endmodule
