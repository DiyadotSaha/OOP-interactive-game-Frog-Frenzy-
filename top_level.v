`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2022 11:18:52 AM
// Design Name: 
// Module Name: top_level
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


module top_level(
    input clkin, 
    input btnR,
    input btnU, 
    input btnD,  
    input btnC, 
    input  [15:0] sw, 
    output [3:0] an, 
    output dp, 
    output [6:0]seg, 
    output [15:0]led, 
    output HS, 
    output VS, 
    output [3:0]vgaRed,
    output [3:0]vgaBlue,
    output [3:0]vgaGreen
    );
    
    wire clk; 
    wire digsel; 
    wire [3:0]ringcounter_output; 
    
    wire frame_signal, game_frame_signal, two_secs_handle, ready_game;
    wire [9:0]frame_counter, game_frame_counter; 
    wire [9:0]gameseconds_counter; 
    wire up_sig, down_fupsig, up_fdownsig, down_sig; 
    
    wire [15:0]score_output; 
    wire [3:0] selector_output; 
    
    wire [4:0] tester;  
    wire [3:0] gametester;
 
    wire twoseconds; 
    wire onesecond; 
 
    wire startGame, detect_collision,score ; 
    
    wire syncbtnU, syncbtnD, syncbtnC; 
    wire frog_active_signal; 
    
    lab7_clks not_so_slow (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    //synchronizing all the buttons
    FDRE #(.INIT(1'b0)) sync1 (.C(clk), .CE(1'b1), .D(btnD),.Q(syncbtnD));
    FDRE #(.INIT(1'b0)) sync2 (.C(clk), .CE(1'b1), .D(btnU),.Q(syncbtnU));
    FDRE #(.INIT(1'b0)) sync3 (.C(clk), .CE(1'b1), .D(btnC),.Q(syncbtnC));
    
    //generating the frame signal 
    Edge_detector frame_rate (.x(VS), .clk(clk), .o(frame_signal));
    
    assign two_secs_handle = frame_signal & gametester[1]; 
    
    assign game_frame_signal =  frame_signal & gametester[2];
     
    //capturing the frog state machine
    frog_sm frog_move(.clk(clk), .press_up(syncbtnU), .press_down(syncbtnD), .frame_signal(game_frame_signal), .up_signal(up_sig), .down_signal(down_sig),
    .down_fromup(down_fupsig),.gameStates(gametester), .up_fromdown(up_fdownsig), .test(tester));
    
    //generating the overall frames 
    count10UDL frames (.clk(clk), .CE(frame_signal), .r(frame_counter > 10'd64), .o(frame_counter));
    
    //synching the frames with the game state machine
    //count10UDL game_machine_frames (.clk(clk), .CE(frame_signal & (startGame | ~detect_collision)), .r(frame_counter > 10'd96), .o(game_frame_counter));
    
     
    VGA_controller v1 (.HS(HS), .VS(VS), .clk(clk), .red(vgaRed), .green(vgaGreen), .blue(vgaBlue), .btnU(syncbtnU), .btnD(syncbtnD), .frame(game_frame_signal), .frog_goingup(up_sig),
    .frog_goingdown(down_sig), .frog_goingup_fd(up_fdownsig), .frog_goingdown_fu(down_fupsig), .framecounter(frame_counter), .frogStates(tester), .collided(detect_collision), .frogblink(frog_active_signal)
    , .gameStates(gametester), .ready(ready_game), .score_counter(score_output));
    
//    count10UDL seconds_counter (.clk(clk), .CE(frame_signal), .r(frame_counter == 10'd120), .o(gameseconds_counter));
//    assign onesecond = gameseconds_counter ==10'd60; 
//    assign twoseconds = (gameseconds_counter == 10'd120)?1'b1:1'b0; 
    
    
    //assign detect_collision = 1'b1; 
    Game_state_machine game(.clk(clk), .frame_signal(frame_signal), .press_start(syncbtnC), .collide(detect_collision), .start_game(startGame), .score(score), 
    .test(gametester), .frog_onoff(frog_active_signal), .ready(ready_game)); 
    //this needs to be 64 frames 
    RingCounter rc1 (.advance(digsel), .clk(clk), .o(ringcounter_output)); 
    
    Selector s1 (.N(score_output), .H(selector_output), .sel(ringcounter_output));
    //Selector s1 (.N(v1.leaf1), .H(selector_output), .sel(ringcounter_output));
    hex7seg hex1 (.n(selector_output), .seg(seg)); 
    
    
    
    assign an[0] = (frog_active_signal)? ~ringcounter_output[0] : 1'b1;
    assign an[1] = (frog_active_signal)? ~ringcounter_output[1] : 1'b1;
    assign an[2] = (frog_active_signal)? ~ringcounter_output[2] : 1'b1;
    assign an[3] = (frog_active_signal)? ~ringcounter_output[3] : 1'b1;
    
    assign dp = 1'b1;
    
    
    assign led[0] = tester[0];
    assign led[1] = tester[1];
    assign led[2] = tester[2];
    assign led[3] = tester[3];
    assign led[4] = tester[4];
    
    assign led[15] = gametester[3]; 
    assign led[14] = gametester[2]; 
    assign led[13] = gametester[1]; 
    assign led[12] = gametester[0]; 
    
   
     
    
    //game statemachine 
    //frog state machine 
    // plant mechanics 
    //RIngcounter 
    //selector 
    // hex seg 
      
    
    
    //assign mux_out = select ?: way1: way0
    
    
    
endmodule
