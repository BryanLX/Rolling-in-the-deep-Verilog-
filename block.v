
module motionx1(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0
			begin
				motion_q <= 8'd2; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin			
				motion_q <= 8'd40;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd20;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd30;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;
		end
endmodule

module motiony1(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;


	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd0; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx2(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0
			begin			
				motion_q <= 8'd100; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd120;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd110;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd95;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;

		end
endmodule

module motiony2(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd0; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx3(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg direction = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 8'd80; // q is set to 0
		 	else if (motion_q == 1 && direction ==0)
				direction <= 1;
			else if (motion_q == 8'd119 && direction == 1)
				direction <= 0;
			else if (direction == 1)
				motion_q <= motion_q + 1;
			else if (direction == 0)
				motion_q <= motion_q - 1;

		end
endmodule

module motiony3(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd20; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx4(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0	
			begin		
				motion_q <= 8'd30; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd50;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd40;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd10;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;
		end
endmodule

module motiony4(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd40; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx5(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0
			begin			
				motion_q <= 8'd120; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd110;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd120;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd100;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;
		end
endmodule

module motiony5(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd40; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx6(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0
			begin			
				motion_q <= 8'd2; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd20;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd5;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd45;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;
		end
endmodule

module motiony6(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd60; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx7(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0	
			begin		
				motion_q <= 8'd70; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd80;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd100;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd110;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;
		end
endmodule

module motiony7(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd60; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx8(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg direction = 1;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0
				motion_q <= 8'd40; // q is set to 0
		 	else if (motion_q == 1 && direction ==0)
				direction <= 1;
			else if (motion_q == 8'd119 && direction == 1)
				direction <= 0;
			else if (direction == 1)
				motion_q <= motion_q + 1;
			else if (direction == 0)
				motion_q <= motion_q - 1;

		end
endmodule

module motiony8(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd80; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx9(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0
			begin			
				motion_q <= 8'd10; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd20;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd30;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd5;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;
		end
endmodule

module motiony9(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd100; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule


module motionx10(resetn,clock,enable,motion_q);
	input resetn;
	input clock; 
	input enable;
	output reg [7:0] motion_q;
	reg [1:0] temp = 0;
	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0 && temp == 2'd0) // when Clear b is 0
			begin			
				motion_q <= 8'd120; // q is set to 0
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd1)
			begin
				motion_q <= 8'd100;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd2)
			begin
				motion_q <= 8'd110;
				temp<= temp +1;
			end
			else if (resetn == 1'b0 && temp == 2'd3)
			begin
				motion_q <= 8'd105;
				temp<= 2'd0;
			end
			else
				motion_q <= motion_q;

		end
endmodule

module motiony10(resetn,clock,enable,motion_q);
	input resetn;
	input clock;
	input enable;
	output reg [6:0] motion_q;

	always @(posedge clock) // triggered every time clock rises
		begin
			if (resetn == 1'b0) // when Clear b is 0			
				motion_q <= 7'd100; // q is set to 0
			else if (motion_q == 0 && enable == 1 )
				motion_q <= 7'd119;
			else if (enable == 1)
				motion_q <= motion_q - 1;
			else
				motion_q <= motion_q;
		end
endmodule





