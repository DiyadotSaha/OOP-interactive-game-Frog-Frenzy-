`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 04:04:06 PM
// Design Name: 
// Module Name: Game_state_machine
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


module Game_state_machine(
    input clk, 
    input frame_signal, 
    input press_start, //btnL
   //input press_restart, //btnC
    input collide, 
    
    output score, 
    output start_game, 
    output [3:0]test, 
    output ready, 
    output frog_onoff
    // assigning states 
    // Idle = Q[0]
    // Ready = Q[1]
    // Play = Q[2]
    // End = Q[3]
    
    );
    
   
     
    wire [3:0]D; 
    wire [3:0]Q; 
    wire twoSecs; 
    wire [9:0] gameseconds_counter; 
    wire test_collide; 
    wire temp_blink; 
    
    count10UDL seconds_counter (.clk(clk), .CE(frame_signal), .r(gameseconds_counter == 10'd128 | start_game | (Q[2]&collide)), .o(gameseconds_counter));
    assign twoSecs = gameseconds_counter == 10'd127;
    assign temp_blink = (gameseconds_counter < 10'd32)? 1'b1: (gameseconds_counter > 10'd31) & (gameseconds_counter < 10'd64)? 1'b0: 
    (gameseconds_counter > 10'd63) & (gameseconds_counter < 10'd96)? 1'b1:1'b0;
    
    assign frog_onoff = (~Q[2] & ~Q[0])? temp_blink: 1'b1;
    //flip flops for the states 
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(1'b1), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(1'b1), .D(D[3]), .Q(Q[3]));
    
    // assigning paths for states 
    assign D[0] = (Q[0] & ~press_start); 
    assign D[1] = (Q[1] & ~twoSecs) | (Q[0] & press_start) | (Q[3] & press_start); 
    assign D[2] = (Q[1] & twoSecs) | (Q[2] & ~collide); 
    assign D[3] = (Q[3] & ~press_start) | (Q[2] & collide); 
    
    
    assign start_game = Q[0] & press_start; 
    assign ready = Q[3] & press_start; 
    assign score = Q[2]; 
    assign test = Q; 
    
    
endmodule
