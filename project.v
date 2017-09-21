// Part 2 skeleton

module project
	(
	CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
	KEY,
		// The ports below are for the VGA output.  Do not change.
	VGA_CLK,   						//	VGA Clock
	VGA_HS,							//	VGA H_SYNC
	VGA_VS,							//	VGA V_SYNC
	VGA_BLANK_N,						//	VGA BLANK
	VGA_SYNC_N,						//	VGA SYNC
	VGA_R,   						//	VGA Red[9:0]
	VGA_G,	 						//	VGA Green[9:0]
	VGA_B,
	HEX0,
	HEX1,
	HEX2,   						//	VGA Blue[9:0]
	);

	input CLOCK_50;
	input [4:0]KEY;
	wire [1:0]sel_o;
	wire [3:0]sel_b;
	wire reset_e,reset_f,reset_p,reset_r,reset_b,reset_t;
	wire done1, done2, done3, done4,dead,plot,en_motion;
	wire [7:0]x;
	wire [6:0]y;
	wire [2:0]c;
	wire [11:0] timewire;
	wire t_enable;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK_N;				//	VGA BLANK
	output	VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B; 
	output  [6:0]   HEX0,HEX1,HEX2;
	  				//	VGA Blue[9:0]



	// Create the colour, x, y and writeEn wires that are inputs to the controller.


	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(c[2:0]),
			.x(x[7:0]),
			.y(y[6:0]),
			.plot(plot),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";

	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.

    // Instansiate datapath
    // datapath d0(...);





	hex_decoder h0(.hex_digit(timewire[3:0]), .segments(HEX0[6:0]));
	hex_decoder h1(.hex_digit(timewire[7:4]), .segments(HEX1[6:0]));
	hex_decoder h2(.hex_digit(timewire[11:8]), .segments(HEX2[6:0]));


	datapath d0(.clk(CLOCK_50),
	.sel_o(sel_o[1:0]),
	.sel_b(sel_b[3:0]),
	.reset_p(reset_p),
	.reset_e(reset_e),
	.reset_f(reset_f),
	.reset_r(reset_r),
	.reset_b(reset_b),
	.reset_t(reset_t),
	.done1(done1),
	.done2(done2),
	.done3(done3),
	.done4(done4),
	.en_motion(en_motion),
	.xout(x[7:0]),
	.yout(y[6:0]),
	.cout(c[2:0]),
	.left(KEY[3]),
	.right(KEY[2]),
	.timeout(timewire[11:0]),
	.dead(dead),
	.t_enable(t_enable));




    // Instansiate FSM control
    // control c0(...);

	control c0(.clk(CLOCK_50),
	.go(KEY[1]),
	.resetn(KEY[0]),
	.reset_e(reset_e),
	.reset_f(reset_f),
	.reset_p(reset_p),
	.reset_r(reset_r),
	.reset_b(reset_b),
	.reset_t(reset_t),
	.done1(done1),
	.done2(done2),
	.done3(done3),
	.done4(done4),
	.dead(dead),
	.en_motion(en_motion),
	.plot(plot),
	.sel_o(sel_o),
	.sel_b(sel_b),
	.t_enable(t_enable));


endmodule



// hex_decoder module is copied from the template provided by professor
module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule

module control(clk,go,resetn,reset_e,reset_f,reset_p,reset_r,reset_b,reset_t,done1, done2,done3,done4,dead,en_motion,plot,sel_o, sel_b,t_enable);
	input clk,go,resetn;
	input done1;
	input done2;
	input done3;
	input done4;
	input dead;
	output reg t_enable;
	output reg reset_e;
	output reg reset_f;
	output reg reset_p;
	output reg reset_r;
	output reg reset_b;
	output reg reset_t;
	output reg plot;
	output reg en_motion;
	output reg[1:0] sel_o;
	output reg[3:0] sel_b;
	reg [6:0] current_state, next_state;

    localparam  RESET         	= 6'd0,
					 RRED					= 6'd27,
					 DRED					= 6'd28,
					 RE					= 6'd26,
                ERASE	      	= 6'd1,
                RF1        	= 6'd2,
		B1		= 6'd3,
		RF2		= 6'd4,
		B2		= 6'd5,
		RF3		= 6'd6,
		B3		= 6'd7,
		RF4		= 6'd8,
		B4		= 6'd9,
		RF5		= 6'd10,
		B5		= 6'd11,
		RF6		= 6'd12,
		B6		= 6'd13,
		RF7		= 6'd14,
		B7		= 6'd15,
		RF8		= 6'd16,
		B8		= 6'd17,
		RF9		= 6'd18,
		B9		= 6'd19,
		RF10		= 6'd20,
		B10		= 6'd21,
		RR		= 6'd22,
		DELAY		= 6'd23,
		RBALL           = 6'd24,
		DBALL           = 6'd25;

    always@(*)
    begin: state_table
		case (current_state)
			RESET: next_state = go?RESET:RE;
			RRED: next_state = DRED;
			DRED: next_state = DRED;
			RE: next_state = ERASE;
			ERASE: 
				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done1 == 1'b1)
						next_state = RF1;
					else
						next_state = ERASE;			
				end
			RF1: next_state = dead?RRED:B1;
			B1:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF2;
					else
						next_state = B1;			
				end
			RF2: next_state = dead?RRED:B2;
			B2:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF3;
					else
						next_state = B2;			
				end
			RF3: next_state = dead?RRED:B3;
			B3:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF4;
					else
						next_state = B3;			
				end
			RF4: next_state = dead?RRED:B4;
			B4:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF5;
					else
						next_state = B4;			
				end
			RF5: next_state = dead?RRED:B5;
			B5:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF6;
					else
						next_state = B5;			
				end
			RF6: next_state = dead?RRED:B6;
			B6:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF7;
					else
						next_state = B6;			
				end
			RF7: next_state = dead?RRED:B7;
			B7:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF8;
					else
						next_state = B7;			
				end
			RF8: next_state = dead?RRED:B8;
			B8:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF9;
					else
						next_state = B8;			
				end
			RF9: next_state = dead?RRED:B9;
			B9:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RF10;
					else
						next_state = B9;			
				end
			RF10: next_state = dead?RRED:B10;
			B10:  

				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done2 == 1'b1)
						next_state = RBALL;
					else
						next_state = B10;			
				end
			RBALL: next_state = dead?RRED:DBALL;
			DBALL: 
				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done4 == 1'b1)
						next_state = RR;
					else
						next_state = DBALL;			
				end
			RR: next_state = dead?RRED:DELAY;
			DELAY: 
				begin
					if (dead == 1'b1)
						next_state = RRED;
					else if (done3 == 1'b1)
						next_state = RE;
					else
						next_state = DELAY;			
				end
			default:     next_state = RESET;
		endcase
    end

    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        	reset_p = 1'b1;
		reset_e = 1'b1;
		reset_f = 1'b1;
		reset_b =1'b1;
		reset_r = 1'b1;
		reset_t = 1'b1;
		sel_o = 2'd0;
		plot = 1'b0;
		sel_b = 4'd0;
		en_motion = 1'b0;
		t_enable = 1'b1;

        case (current_state)
        RESET: begin
                reset_e = 1'b0;
		reset_p = 1'b0;
		reset_f = 1'b0;
		reset_b = 1'b0;
		reset_t = 1'b0;
		t_enable = 1'b0;
                end
					 
		  RRED: begin
		  reset_e = 1'b0;
		  t_enable = 1'b0;
		  end
		  DRED:begin
		  plot = 1'b1;
		  sel_o = 2'd3;
		  t_enable = 1'b0;
		  end
		  RE: begin
		  reset_e = 1'b0;
		  end
        ERASE: begin
		plot = 1'b1;
                end
        RF1: begin
		reset_f = 1'b0;
                end
        B1: begin
		plot = 1'b1;
		sel_b = 4'd0;
		sel_o = 2'd1;
                end
	RF2: begin
		reset_f = 1'b0;
                end
        B2: begin
 		plot = 1'b1;
		sel_b = 4'd1;
		sel_o = 2'd1;
                end
      	RF3: begin
		reset_f = 1'b0;
                end
        B3: begin
		plot = 1'b1;
		sel_b = 4'd2;
		sel_o = 2'd1;
                end
	RF4: begin
		reset_f = 1'b0;
                end
        B4: begin
		plot = 1'b1;
		sel_b = 4'd3;
		sel_o = 2'd1;
                end
	RF5: begin
		reset_f = 1'b0;
                end
        B5: begin
		plot = 1'b1;
		sel_b = 4'd4;
		sel_o = 2'd1;
                end
	RF6: begin
		reset_f = 1'b0;
                end
        B6: begin
		plot = 1'b1;
		sel_b = 4'd5;
		sel_o = 2'd1;
                end
	RF7: begin
		reset_f = 1'b0;
                end
        B7: begin
		plot = 1'b1;
		sel_b = 4'd6;
		sel_o = 2'd1;
                end
	RF8: begin
		reset_f = 1'b0;
                end
        B8: begin
		plot = 1'b1;
		sel_b = 4'd7;
		sel_o = 2'd1;
                end
	RF9: begin
		reset_f = 1'b0;
                end
        B9: begin
		plot = 1'b1;
		sel_b = 4'd8;
		sel_o = 2'd1;
                end
	RF10: begin
		reset_f = 1'b0;
                end
        B10: begin
		plot = 1'b1;
		sel_b = 4'd9;
		sel_o = 2'd1;
                end
        RR: begin

		reset_r = 1'b0;
                end
        DELAY: begin
		  en_motion = 1'b1;
		reset_r = 1'b1;
                end
	RBALL: begin
		reset_b = 1'b0;
		end
	DBALL: begin
		plot = 1'b1;
		sel_o = 2'd2;
		reset_b = 1'b1;
		end

        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals




    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= RESET;
        else
            current_state <= next_state;
    end

endmodule





module datapath(clk, sel_o, sel_b, reset_p,reset_e,reset_f,reset_r,reset_b,reset_t,en_motion,done1,done2,done3,done4,xout,yout,cout,left,right,timeout,dead,t_enable);
	input clk;
	input reset_e,reset_f,reset_p,reset_r,reset_b,reset_t,en_motion;
	input left,right;
	input t_enable;
	output done1;
	output done2;
	output done3;
	output done4;
	output [11:0] timeout;
	output [7:0] xout;
	output [6:0] yout;
	output [2:0] cout;
	input [1:0] sel_o;
	input[3:0] sel_b;
	output dead;

	wire [7:0]wx1,wx2,wx3,wx4,wx5,wx6,wx7,wx8,wx9,wx10,wxout,wxtomux,exout,fxout,bxout,bxoutomux;
	wire [6:0]wy1,wy2,wy3,wy4,wy5,wy6,wy7,wy8,wy9,wy10,wyout,wytomux,eyout,fyout,byout,byoutomux;
	wire [2:0]wcolor,fcout;
	wire rate_en,time1;
	wire [11:0] time2;


	mux_20to2 m0(.x1(wx1[7:0]),.x2(wx2[7:0]),.x3(wx3[7:0]),.x4(wx4[7:0]),.x5(wx5[7:0]),.x6(wx6[7:0]),.x7(wx7[7:0]),.x8(wx8[7:0]),.x9(wx9[7:0]),.x10(wx10[7:0]),.y1(wy1[6:0]),.y2(wy2[6:0]),.y3(wy3[6:0]),.y4(wy4[6:0]),.y5(wy5[6:0]),.y6(wy6[6:0]),.y7(wy7[6:0]),.y8(wy8[6:0]),.y9(wy9[6:0]),.y10(wy10[6:0]),.sel(sel_b[3:0]),.xout(wxout[7:0]),.yout(wyout[6:0]));

	motionx1 x1(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx1[7:0]));
	motiony1 y1(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy1[6:0]));

	motionx2 x2(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx2[7:0]));
	motiony2 y2(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy2[6:0]));

	motionx3 x3(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx3[7:0]));
	motiony3 y3(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy3[6:0]));

	motionx4 x4(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx4[7:0]));
	motiony4 y4(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy4[6:0]));

	motionx5 x5(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx5[7:0]));
	motiony5 y5(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy5[6:0]));

	motionx6 x6(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx6[7:0]));
	motiony6 y6(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy6[6:0]));

	motionx7 x7(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx7[7:0]));
	motiony7 y7(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy7[6:0]));

	motionx8 x8(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx8[7:0]));
	motiony8 y8(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy8[6:0]));

	motionx9 x9(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx9[7:0]));
	motiony9 y9(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy9[6:0]));

	motionx10 x10(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wx10[7:0]));
	motiony10 y10(.resetn(reset_p),.clock(rate_en),.enable(en_motion),.motion_q(wy10[6:0]));

	bally by(.resetn(reset_p),.clk(rate_en),.motion_q(byout[6:0]),.ballx(bxout[7:0]),.b1x(wx1[7:0]),.b2x(wx2[7:0]),.b3x(wx3[7:0]),.b4x(wx4[7:0]),.b5x(wx5[7:0]),.b6x(wx6[7:0]),.b7x(wx7[7:0]),.b8x(wx8[7:0]),.b9x(wx9[7:0]),.b10x(wx10[7:0]),.b1y(wy1[6:0]),.b2y(wy2[6:0]),.b3y(wy3[6:0]),.b4y(wy4[6:0]),.b5y(wy5[6:0]),.b6y(wy6[6:0]),.b7y(wy7[6:0]),.b8y(wy8[6:0]),.b9y(wy9[6:0]),.b10y(wy10[6:0]),.dead(dead));

	ballx bx(.resetn(reset_p),.clk(rate_en),.motion_q(bxout[7:0]),.left(left),.right(right)); //

	fill_ball f1(.clk(clk),.resetn(reset_b),.ball_x(bxout[7:0]),.ball_y(byout[6:0]),.ballx_out(bxoutomux[7:0]),.bally_out(byoutomux[6:0]),.done(done4));

	fill_block f0(.clk(clk),.resetn(reset_f),.block_x(wxout[7:0]),.block_y(wyout[6:0]),.blockx_out(wxtomux[7:0]),.blocky_out(wytomux[6:0]),.done(done2));
	erase e(.clk(clk),.resetn(reset_e),.xout(exout[7:0]),.yout(eyout[6:0]),.done(done1));
	mux_9to3 m9(.erasex(exout[7:0]),.positionx(wxtomux[7:0]),.ballx(bxoutomux[7:0]),.erasey(eyout[6:0]),.positiony(wytomux[6:0]),.bally(byoutomux[6:0]),.sel(sel_o[1:0]),.tovgax(fxout[7:0]),.tovgay(fyout[6:0]),.tovgac(fcout[2:0]));
	RateDivider_15frames r0(.clk(clk),.resetn(reset_r),.sec(time2),.en(rate_en));


	RateDivider_time r1(.clk(clk),.resetn(reset_t),.en(time1));
	timecounter t0(.clk(time1),.t_enable(t_enable),.resetn(reset_t),.out(time2));
	

	assign xout = fxout;
	assign yout = fyout;
	assign cout = fcout;
	assign done3 = rate_en;
	assign timeout = time2;



endmodule



module erase(clk,resetn,xout,yout,done);
	input clk;
	input resetn;
	output [7:0] xout;
	output [6:0] yout;
	output reg done;

	reg [7:0] q1,q2;

	    always @(posedge clk) // triggered every time clock rises
		begin
			if (resetn == 1'b0)
				begin
					q1 <= 0; // when Clear b is 0
					q2 <= 0;
					done <= 0; // q is set to 0
				end
			else if (q1 == 8'd159 && q2 == 8'd119)
				done <= 1;
			else if (q1 == 8'd159)
				begin
					q1 <= 0;
					q2 <= q2 + 1;
				end
			else
				q1 <= q1 + 1;
		end

	   assign xout = q1[7:0];
	   assign yout = q2[6:0];
endmodule



module mux_9to3(erasex,positionx,ballx,erasey,positiony,bally,sel,tovgax,tovgay,tovgac);
	input [7:0] erasex,positionx,ballx;
	input [6:0] erasey,positiony,bally;
	input [1:0] sel;
	output reg[7:0] tovgax;
	output reg[6:0] tovgay;
	output reg[2:0] tovgac;

	always @(*)
		case (sel)
		    2'h0:
			begin
				tovgax = erasex;
				tovgay = erasey;
				tovgac = 3'b000;
			end
		    2'h1:
			begin
				tovgax = positionx;
				tovgay = positiony;
				tovgac = 3'b111;
			end
		    2'h2:
			begin
				tovgax = ballx;
				tovgay = bally;
				tovgac = 3'b010;
			end
		    2'h3:
			begin
				tovgax = erasex;
				tovgay = erasey;
				tovgac = 3'b100;
			end
		endcase
endmodule




module mux_20to2(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,sel,xout,yout);
	input [7:0] x1,x2,x3,x4,x5,x6,x7,x8,x9,x10;
	input [6:0] y1,y2,y3,y4,y5,y6,y7,y8,y9,y10;
	input [3:0] sel;
	output reg[7:0] xout;
	output reg[6:0] yout;

    always @(*)
        case (sel)
            4'h0:
		begin
			xout = x1;
			yout = y1;
		end
            4'h1:
		begin
			xout = x2;
			yout = y2;
		end
            4'h2:
		begin
			xout = x3;
			yout = y3;
		end
            4'h3:
		begin
			xout = x4;
			yout = y4;
		end
            4'h4:
		begin
			xout = x5;
			yout = y5;
		end
            4'h5:
		begin
			xout = x6;
			yout = y6;
		end
            4'h6:
		begin
			xout = x7;
			yout = y7;
		end
            4'h7:
		begin
			xout = x8;
			yout = y8;
		end
            4'h8:
		begin
			xout = x9;
			yout = y9;
		end
            4'h9:
		begin
			xout = x10;
			yout = y10;
		end
            default:
		begin
			xout = 8'd0;
			yout = 7'd0;
		end
        endcase
endmodule




module  fill_block(clk,resetn,block_x,block_y,blockx_out,blocky_out,done);
	input clk;
    	input resetn;
    	input [7:0] block_x;
    	input [6:0] block_y;
    	output reg [7:0] blockx_out;
    	output reg [6:0] blocky_out;
	output reg done;
    	reg [5:0] q1,q2;

    	// fill the block
    	always@(*)
		begin
			if(resetn == 1'b0)
				begin
		    			blockx_out = 8'b0;
		    			blocky_out = 7'b0;

				end
			else
				begin
					blockx_out = block_x + {2'b0, q1};
					blocky_out = block_y + {1'b0, q2};
				end
    		end



	    always @(posedge clk) // triggered every time clock rises
		begin
			if (resetn == 1'b0)
				begin
					q1 <= 0; // when Clear b is 0
					q2 <= 0; // q is set to 0
					done <= 0;
				end
			else if (q1 == 6'd40 && q2 == 6'd5)
				done <= 1;
			else if (q1 == 6'd40)
				begin
					q1 <= 0;
					q2 <= q2 + 1;
				end
			else
				q1 <= q1 + 1;
		end
endmodule





module RateDivider_15frames(clk,resetn,sec,en);
	input clk,resetn;
	input [11:0]sec;
	output reg en;
	reg [27:0]counter;
	reg [27:0]c;



	always @(*)
	begin
		if (!resetn)
			begin
				c <= 28'd2025000;
			end
		else if (sec == 12'd10)
			begin
				c <= 28'd1500000;
			end
		else if (sec >= 12'd20)
			begin
				c <= 28'd1000000;
			end
	end






	always @(posedge clk)
	begin
		if(!resetn)
			begin
				counter <= 28'd0;
				en <= 1'b0;
			end
		else if( counter == c-1)
			begin
				counter <= 28'd0;
				en <= ~en;
			end
		else
			counter <= counter + 1;
	end

endmodule



module  fill_ball(clk,resetn,ball_x,ball_y,ballx_out,bally_out,done);
	input clk;
    	input resetn;
    	input [7:0] ball_x;
    	input [6:0] ball_y;
    	output reg [7:0] ballx_out;
    	output reg [6:0] bally_out;
	output reg done;
    	reg [5:0] q1,q2;

    	// fill the block
    	always@(*)
		begin
			if(resetn == 1'b0)
				begin
		    			ballx_out = 8'b0;
		    			bally_out = 7'b0;

				end
			else
				begin
					ballx_out = ball_x + {2'b0, q1};
					bally_out = ball_y + {1'b0, q2};
				end
    		end



	    always @(posedge clk) // triggered every time clock rises
		begin
			if (resetn == 1'b0)
				begin
					q1 <= 0; // when Clear b is 0
					q2 <= 0; // q is set to 0
					done <= 0;
				end
			else if (q1 == 6'd2 && q2 == 6'd2)
				done <= 1;
			else if (q1 == 6'd2)
				begin
					q1 <= 0;
					q2 <= q2 + 1;
				end
			else
				q1 <= q1 + 1;
		end
endmodule


module ballx(resetn,clk,motion_q,left,right);
	input resetn;
	input clk;
	input left;
	input right;
	output reg [7:0] motion_q;
	
	always @(posedge clk) // triggered every time key[1] is pressed
		begin
			if (resetn == 1'b0) // when Clear b is 0
				motion_q <= 8'd80; // q is set to 0
			else if(left ==0 && motion_q == 0)
				motion_q <= 8'd159;			
			else if(left ==0 )
				motion_q <= motion_q -8'd1;
			else if(right == 0 && motion_q == 8'd159)
				motion_q <= 0;
			else if(right == 0)
				motion_q <= motion_q + 8'd1;
			else
				motion_q <= motion_q;
		end

	
	
endmodule

module bally(resetn,clk,motion_q,ballx,b1x,b2x,b3x,b4x,b5x,b6x,b7x,b8x,b9x,b10x,b1y,b2y,b3y,b4y,b5y,b6y,b7y,b8y,b9y,b10y,dead);
	input resetn;
	input clk;
	input [7:0] ballx,b1x,b2x,b3x,b4x,b5x,b6x,b7x,b8x,b9x,b10x;
	input [6:0] b1y,b2y,b3y,b4y,b5y,b6y,b7y,b8y,b9y,b10y;
	output reg[6:0] motion_q;
	output reg dead;
	
	always @(posedge clk)
	begin
		if (resetn == 1'b0) // when Clear b is 0
			begin
				motion_q <= 8'd20; // q is set to 0
				dead <= 1'b0;
			end
		else if((b1x-8'd2<ballx) &&(ballx<b1x+8'd40) && (motion_q+7'd2 == b1y))
			motion_q <= motion_q-7'd1;
		else if((b2x-8'd2<ballx) &&(ballx<b2x+8'd40) && (motion_q+7'd2 == b2y))
			motion_q <= motion_q-7'd1;
		else if((b3x-8'd2<ballx) &&(ballx<b3x+8'd40) && (motion_q+7'd2 == b3y))
			motion_q <= motion_q-7'd1;
		else if ((b4x-8'd2<ballx) &&(ballx<b4x+8'd40) && (motion_q+7'd2 == b4y))
			motion_q <= motion_q-7'd1;
		else if ((b5x-8'd2<ballx) &&(ballx<b5x+8'd40) && (motion_q+7'd2 == b5y))
			motion_q <= motion_q-7'd1;
		else if ((b6x-8'd2<ballx) &&(ballx<b6x+8'd40) && (motion_q+7'd2 == b6y))
			motion_q <= motion_q-7'd1;
		else if ((b7x-8'd2<ballx) &&(ballx<b7x+8'd40) && (motion_q+7'd2 == b7y))
			motion_q <= motion_q-7'd1;
		else if ((b8x-8'd2<ballx) &&(ballx<b8x+8'd40) && (motion_q+7'd2 == b8y))
			motion_q <= motion_q-7'd1;
		else if ((b9x-8'd2<ballx) &&(ballx<b9x+8'd40) && (motion_q+7'd2 == b9y))
			motion_q <= motion_q-7'd1;
		else if ((b10x-8'd2<ballx) &&(ballx<b10x+8'd40) && (motion_q+7'd2 == b10y))
			motion_q <= motion_q-7'd1;
		else if((motion_q == 8'd119) | (motion_q == 8'd0))
				dead <= 1'b1;
		else
				motion_q <= motion_q +1;
	end
	

endmodule


module RateDivider_time(clk,resetn,en);
	input clk,resetn;
	output reg en;
	reg [27:0]counter;

	always @(posedge clk)
	begin
		if(!resetn)
			begin
				counter <= 28'd0;
				en <= 1'b0;
			end
		else if( counter == 28'd25000000-1)
			begin
				counter <= 28'd0;
				en <= ~en;
			end
		else
			counter <= counter + 1;
	end

endmodule


module timecounter(clk,t_enable,resetn,out);
	input clk,t_enable,resetn;
	output reg [11:0]out;
	
	always @(posedge clk, negedge resetn)
	begin 
		if (!resetn)
			out <= 12'd0;

		else if (t_enable == 1'b1)
			out <= out + 1;
	end

endmodule


