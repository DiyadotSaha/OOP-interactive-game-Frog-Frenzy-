`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2022 11:46:00 AM
// Design Name: 
// Module Name: VGA_controller
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


module VGA_controller(
    input btnU,  
    input btnD, 
    output HS, 
    output VS, 
    input frame, 
    input [9:0]framecounter, 
    input clk, 
    input ready, 
    output [3:0]red, 
    output [3:0]green, 
    output [3:0]blue, 
    input frog_goingup, 
    input frog_goingdown, 
    input frog_goingup_fd, 
    input frog_goingdown_fu, 
    input [4:0]frogStates, 
    input [3:0]gameStates, 
    output [15:0]score_counter, 
    output collided, 
    input frogblink
    );
    wire [9:0] hold_frog_pos, hold_leaf_pos, hold_leaf2_pos, hold_leaf3_pos;  
    wire [9:0]horizontal_output, vertical_output; 
    wire active_region, water_active, frog_active, plant1_active, plant2_active, plant3_active,vertical_active, horizontal_active; 
    wire [9:0]total_frog_offset, leaf_offset, newleaf_offset;
    wire speed, hold1, hold2, hold3;
    wire [9:0] leafright_edge, leafleft_edge, leaf2right_edge, leaf2left_edge, leaf3right_edge, leaf3left_edge; 
    wire [7:0] temp_rand; 
    wire [3:0] temp_leaf_offset; 
    wire [9:0] random_leaf_offset; 
    wire [9:0] tempmove_frog, move_frog; 
    wire[9:0] bottom_edge; 
    wire [9:0]water_depth; 
    wire [3:0]WHITE = 4'hf; 
    wire [3:0]water_depth_blue;
    wire [3:0]BLACK = 4'h0;    
    wire [9:0] leaf_topedge; 
    wire utc_useless, dtc_useless; 
    wire [9:0]leaf1, leaf2, leaf3, temp_din, temp_din2, temp_din3; 
    //assign speed = frame; 
    
    //changing the speed from 1pix/frame to 3pix/frame
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(1'b1), .D(frame), .Q(hold1));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(hold1), .Q(hold2));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(1'b1), .D(hold2), .Q(hold3));  
    assign speed = hold1 | hold2 | hold3;   
    //assign collided = 1'b0; 
    assign collided = frog_active & (plant1_active | plant2_active | plant3_active); 
    //assign collided = frog_active & (plant1_active); 
    
    assign red = (frog_active & active_region) ? WHITE : BLACK; 
    assign green = (frog_active & active_region) ? WHITE: (plant1_active & active_region) ? WHITE :(plant2_active & active_region)? WHITE: (plant3_active & active_region)? WHITE: BLACK;
    //assign green = (frog_active & active_region) ? WHITE: (plant1_active & active_region)? WHITE: BLACK; 
    assign blue = (frog_active & active_region) ? WHITE : (water_active & ~plant1_active & ~plant2_active & ~plant3_active & active_region) ? (water_depth_blue): BLACK; 
    //assign blue = (frog_active & active_region) ? WHITE : (water_active & ~plant1_active & active_region) ? (water_depth_blue): BLACK; 
    
    assign active_region = (horizontal_output <= 10'd639) & (vertical_output <= 10'd479); 
    
    assign HS = horizontal_output <= 10'd654 |  horizontal_output >= 10'd751; 
    assign VS = vertical_output <= 10'd488 | vertical_output >=10'd491; 
 
    
    assign frog_active = (((horizontal_output >= 10'd120) && (horizontal_output <= 10'd136)) & 
    ((vertical_output >= move_frog) && (vertical_output <= bottom_edge))) & frogblink;
    assign bottom_edge = (move_frog + 10'd16); 
    
    //assign move_frog = (gameStates[1]) ? 10'd232: move_frog;
   //assign move_frog = gameStates[1] ? 10'd232: move_frog; 
    
    FDRE #(.INIT(1'b0)) f0_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[0]), .Q(hold_frog_pos[0]));
    FDRE #(.INIT(1'b0)) f1_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[1]), .Q(hold_frog_pos[1]));
    FDRE #(.INIT(1'b0)) f2_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[2]), .Q(hold_frog_pos[2]));
    FDRE #(.INIT(1'b0)) f3_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[3]), .Q(hold_frog_pos[3]));
    FDRE #(.INIT(1'b0)) f4_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[4]), .Q(hold_frog_pos[4]));
    FDRE #(.INIT(1'b1)) f5_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[5]), .Q(hold_frog_pos[5]));
    FDRE #(.INIT(1'b0)) f6_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[6]), .Q(hold_frog_pos[6]));
    FDRE #(.INIT(1'b0)) f7_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[7]), .Q(hold_frog_pos[7]));
    FDRE #(.INIT(1'b0)) f8_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[8]), .Q(hold_frog_pos[8]));
    FDRE #(.INIT(1'b0)) f9_FF (.C(clk), .CE(gameStates[2] & collided), .R(gameStates[1]), .D(move_frog[9]), .Q(hold_frog_pos[9]));
    
    assign move_frog = (frogStates[1] & ~(gameStates[1])) ? (10'd232 - total_frog_offset): (frogStates[3]& ~(gameStates[1])) ? (10'd232 + total_frog_offset): (frogStates[2]& ~(gameStates[1]))? (10'd136 + total_frog_offset):
    (frogStates[4]& ~(gameStates[1]))? (10'd328 - total_frog_offset):(gameStates[3])? hold_frog_pos: 10'd232;
     
 
    
    assign water_active =  (vertical_output >= 10'd240) & (horizontal_output <= 10'd639); 
    assign water_depth = vertical_output - 10'd240; //water depth is the distance from the middle 
    assign water_depth_blue = WHITE - water_depth[7:4];
    
    
    //assign leafright_edge = gameStates[1] ? 10'd300 : leaf_offset; 
    assign leafright_edge = leaf1; 
    assign leaf2right_edge =  leaf2;
    assign leaf3right_edge = leaf3;
    
    //assign leafright_edge = leaf_offset;  //making plant move 
    // sorting all of the plant edges 
    assign leafleft_edge = leafright_edge - 10'd40; 
    //assign leaf2right_edge = leafright_edge + 10'd240; 
    assign leaf2left_edge = leaf2right_edge - 10'd40; 
    //assign leaf3right_edge = leafright_edge + 10'd480;
    assign leaf3left_edge = leaf3right_edge - 10'd40; 
    
    assign leaf_topedge = 10'd192; 
    //assign plant active regions     
    assign plant1_active = (horizontal_output>=leafleft_edge | (leafright_edge < 10'd40)) & (horizontal_output <= (leafright_edge)) & (vertical_output >= leaf_topedge) & (vertical_output <= leaf_topedge + 10'd96);
    assign plant2_active = (horizontal_output>=leaf2left_edge | (leaf2right_edge < 10'd40)) & (horizontal_output <= leaf2right_edge) & ((vertical_output >= leaf_topedge) & (vertical_output <= leaf_topedge+10'd96));
    assign plant3_active = (horizontal_output>=leaf3left_edge | (leaf3right_edge < 10'd40)) & (horizontal_output <= leaf3right_edge) & (vertical_output >= leaf_topedge) & (vertical_output <= leaf_topedge+10'd96);
    
    FDRE #(.INIT(10'd192)) leaf1_FF[9:0] (.C(clk), .CE(leaf1 == 10'd680), .D(random_leaf_offset), .Q(hold_leaf_pos));
    FDRE #(.INIT(10'd192)) leaf2_FF[9:0] (.C(clk), .CE(leaf2 == 10'd680), .D(random_leaf_offset), .Q(hold_leaf2_pos));
    FDRE #(.INIT(10'd192)) leaf3_FF[9:0] (.C(clk), .CE(leaf3 == 10'd680), .D(random_leaf_offset), .Q(hold_leaf3_pos));

    
    random randnum (.clk(clk), .out(temp_rand)); 
     
      assign temp_leaf_offset = temp_rand[3:0]; 
    
    assign random_leaf_offset = (temp_leaf_offset == 4'h0)? leaf_topedge - 10'd28:(temp_leaf_offset == 4'h1)? leaf_topedge - 10'd24: (temp_leaf_offset == 4'h2)? leaf_topedge - 10'd20:
    (temp_leaf_offset == 4'h3)? leaf_topedge - 10'd16:(temp_leaf_offset == 4'h4)? leaf_topedge - 10'd12: (temp_leaf_offset == 4'h5)? leaf_topedge - 10'd8:
    (temp_leaf_offset == 4'h6)? leaf_topedge - 10'd4:(temp_leaf_offset == 4'h7)? leaf_topedge : (temp_leaf_offset == 4'h8)? leaf_topedge + 10'd4:
    (temp_leaf_offset == 4'h9)? leaf_topedge + 10'd8:(temp_leaf_offset == 4'ha)? leaf_topedge + 10'd12: (temp_leaf_offset == 4'hb)? leaf_topedge + 10'd16:
    (temp_leaf_offset == 4'hc)? leaf_topedge + 10'd20:(temp_leaf_offset == 4'hd)? leaf_topedge + 10'd24: (temp_leaf_offset == 4'he)? leaf_topedge + 10'd28:
    leaf_topedge; 
    
    //counters to handle frames for everything
    count10UDL horizontal_counter (.clk(clk), .CE(1'b1), .r(horizontal_output > 10'd798), .o(horizontal_output));
    count10UDL vertical_counter (.clk(clk), .CE(horizontal_output == 10'd799), .r(vertical_output == 10'd524), .o(vertical_output));
    count10UDL frog_counter (.clk(clk), .CE(speed), .r((total_frog_offset == 10'd96)|frog_goingup|frog_goingdown|frog_goingdown_fu|frog_goingup_fd), .o(total_frog_offset));
    
    count10UDL scoring (.clk(clk), .CE(frog_goingdown_fu|frog_goingup_fd), .r(ready), .o(score_counter));
    
    assign temp_din = (gameStates[1]|gameStates[0]) ? 10'd240: 10'd680; 
    assign temp_din2 =(gameStates[1]|gameStates[0]) ? 10'd480: 10'd680; 
    assign temp_din3 =(gameStates[1]|gameStates[0]) ? 10'd720: 10'd680;
    
    leaf_counter leaf_counter1 (.clk(clk), .Dw(1'b1), .Up(1'b0) , .LD((leaf1[9:0] == 10'd0)|gameStates[1]),  .Din(temp_din), .Q(leaf1), .frame_signal(speed));
    leaf_counter leaf_counter2 (.clk(clk), .Dw(1'b1), .Up(1'b0) , .LD((leaf2[9:0] == 10'd0)|gameStates[1]),  .Din(temp_din2), .Q(leaf2), .frame_signal(speed));
    leaf_counter leaf_counter3 (.clk(clk), .Dw(1'b1), .Up(1'b0) , .LD((leaf3[9:0] == 10'd0)|gameStates[1]),  .Din(temp_din3), .Q(leaf3), .frame_signal(speed));
   
    //leaf_counter leaf_counter3 (.clk(clk), .Dw(1'b1), .Up(1'b0) , .LD(leaf3[9:0] == 10'd0),  .Din(10'd680), .Q(leaf3), .frame_signal(speed));
    

endmodule
