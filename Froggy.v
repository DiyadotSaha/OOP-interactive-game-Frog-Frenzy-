`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2022 01:49:35 PM
// Design Name: 
// Module Name: Froggy
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


module frog_sm(
    input clk,  
    input press_up, 
    input press_down, 
    input [3:0]gameStates,  
    //input [9:0]frame_counter,  
    input frame_signal, 
    output up_signal, 
    output down_signal, 
    output down_fromup, 
    output up_fromdown, 
    
    output [4:0]test
    
    //assigning states 
        //Q[0] = center 
        //Q[1] = Up 
        //Q[2] = DownfUp
        //Q[3] = Down 
        //Q[4] = UpfDown 
    
    );
    
    wire [4:0]D; 
    wire [4:0]Q; 
    
    wire [9:0]frog_frames; 
    
    wire state_time = 10'd32; 
    wire frame_check; 
    count10UDL frametimer(.clk(clk), .CE(frame_signal), .r((frog_frames == 10'd32)|up_signal|down_fromup|down_signal|up_fromdown), .o(frog_frames));
    assign frame_check = (frog_frames == 10'd32); 
    //flip flops for the states 
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(1'b1), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(1'b1), .D(D[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) Q4_FF (.C(clk), .CE(1'b1), .D(D[4]), .Q(Q[4]));
    
    //asigning paths for the states 
     assign D[0] = (Q[0] & ~press_up & ~press_down) | (Q[2] & (frog_frames == 10'd32)) | (Q[4] & frame_check)| 
     (Q[1] & gameStates[3])| (Q[2] & gameStates[3])|(Q[3] & gameStates[3])| (Q[4] & gameStates[3]); 
     assign D[1] = (Q[1] & ~frame_check & ~gameStates[3]) | (Q[0] & press_up & ~gameStates[3]); 
     assign D[2] = (Q[2] & ~frame_check & ~gameStates[3]) | (Q[1] & frame_check & ~gameStates[3]);
     assign D[3] = (Q[3] & ~frame_check & ~gameStates[3]) | (Q[0] & press_down & ~gameStates[3]); 
     assign D[4] = (Q[4] & ~frame_check & ~gameStates[3]) | (Q[3] & frame_check & ~gameStates[3]); 
     
     //assigning outputs 
     assign up_signal = Q[0] & press_up; 
     assign down_fromup = Q[1] & frame_check;
     assign down_signal = Q[0] & press_down; 
     assign up_fromdown = Q[3] & frame_check; 
     //assign up_signal = Q[1] | Q[4];
     //assign down_signal = Q[2] | Q[3];  
     assign test = Q; 
    
    
endmodule
