module Open(
    input clk,           // System clock, clk = 1k
    input reset,         // Reset signal assign pulse
    input [7:0]switch,       // Switch 
    output reg [7:0] row,    // Rows of LED matrix
    output reg [7:0] col     // Columns of LED matrix   
);

// Declare state variables
reg [7:0] display_row_memory [0:500];  // Memory for storing display data (text: "OPEN")
reg [7:0] display_col_memory [0:7];
reg [8:0] scroll_counter;         // Counter for scrolling text
reg clkd;
reg [23:0] count1;
reg clk_scroll;
reg [23:0] count2;
reg [2:0] col_counter;
reg [8:0] scroll_counter_initial;
reg [8:0] scroll_counter_final;

reg clk_frame;
reg [23:0]count3;
reg [5:0]frame_counter;
// Initialize the display memory with "OPEN" text pattern (binary representation of each character)
initial begin
    // Binary data for scrolling "OPEN" on 8x8 matrix
    col_counter <= 0;
    scroll_counter <=0;
    count1 <=0;    
    clkd <=0;
    clk_scroll<=0;
    count2 <=0;
	scroll_counter_initial<=0;
	scroll_counter_final<=0;
	
	display_col_memory [0] <= 8'b10000000;
    display_col_memory [1] <= 8'b01000000; 
    display_col_memory [2] <= 8'b00100000;
    display_col_memory [3] <= 8'b00010000;
    display_col_memory [4] <= 8'b00001000;
    display_col_memory [5] <= 8'b00000100;
    display_col_memory [6] <= 8'b00000010; 
    display_col_memory [7] <= 8'b00000001;
    //Blank
  	display_row_memory[0]  <= 8'b00000000;//blank frame 
	display_row_memory[1]  <= 8'b00000000;
	display_row_memory[2]  <= 8'b00000000;
	display_row_memory[3]  <= 8'b00000000;
	display_row_memory[4]  <= 8'b00000000;
	display_row_memory[5]  <= 8'b00000000;
	display_row_memory[6]  <= 8'b00000000;
	display_row_memory[7]  <= 8'b00000000;  
    //ENTRY/SW1	
    display_row_memory[8]  <= 8'b00000000;//E
	display_row_memory[9]  <= 8'b11111111;
	display_row_memory[10]  <= 8'b11111111;
	display_row_memory[11]  <= 8'b11011011;
	display_row_memory[12]  <= 8'b11011011;
	display_row_memory[13]  <= 8'b11011011;
	display_row_memory[14]  <= 8'b11011011;
	display_row_memory[15]  <= 8'b00000000;
	
	display_row_memory[16]  <= 8'b00000000;//N
	display_row_memory[17]  <= 8'b11111111;
	display_row_memory[18]  <= 8'b01111111;
	display_row_memory[19]  <= 8'b00111000;
	display_row_memory[20]  <= 8'b00011100;
	display_row_memory[21]  <= 8'b11111110;
	display_row_memory[22]  <= 8'b11111111;
	display_row_memory[23]  <= 8'b00000000;	
	
	display_row_memory[24]  <= 8'b00000000;//T
	display_row_memory[25]  <= 8'b11000000;
	display_row_memory[26]  <= 8'b11000000;
	display_row_memory[27]  <= 8'b11111111;
	display_row_memory[28]  <= 8'b11111111;
	display_row_memory[29]  <= 8'b11000000;
	display_row_memory[30]  <= 8'b11000000;
	display_row_memory[31]  <= 8'b00000000;
	
	display_row_memory[32]  <= 8'b00000000;//R
	display_row_memory[33]  <= 8'b11111111;
	display_row_memory[34]  <= 8'b11111111;
	display_row_memory[35]  <= 8'b11011100;
	display_row_memory[36]  <= 8'b11011110;
	display_row_memory[37]  <= 8'b11111011;
	display_row_memory[38]  <= 8'b01110001;
	display_row_memory[39]  <= 8'b00000000;		
	
	display_row_memory[40]  <= 8'b00000000;//Y
	display_row_memory[41]  <= 8'b11000000;
	display_row_memory[42]  <= 8'b01100000;
	display_row_memory[43]  <= 8'b00111111;
	display_row_memory[44]  <= 8'b00111111;
	display_row_memory[45]  <= 8'b01100000;
	display_row_memory[46]  <= 8'b11000000;
	display_row_memory[47]  <= 8'b00000000;	
//EXIT/sw2
    display_row_memory[48]  <= 8'b00000000;//E
	display_row_memory[49]  <= 8'b11111111;
	display_row_memory[50]  <= 8'b11111111;
	display_row_memory[51]  <= 8'b11011011;
	display_row_memory[52]  <= 8'b11011011;
	display_row_memory[53]  <= 8'b11011011;
	display_row_memory[54]  <= 8'b11011011;
	display_row_memory[55]  <= 8'b00000000;

    display_row_memory[56]  <= 8'b00000000; //X
    display_row_memory[57]  <= 8'b10000001;
    display_row_memory[58]  <= 8'b11000011;
    display_row_memory[59]  <= 8'b01100110;
    display_row_memory[60]  <= 8'b00111100;
    display_row_memory[61]  <= 8'b01100110;
    display_row_memory[62]  <= 8'b11000011;
    display_row_memory[63]  <= 8'b10000001;
    
    display_row_memory[64]  <= 8'b00000000;//I
    display_row_memory[65]  <= 8'b10000001;
    display_row_memory[66]  <= 8'b11111111;
    display_row_memory[67]  <= 8'b11111111;
    display_row_memory[68]  <= 8'b10000001;
	
	display_row_memory[69]  <= 8'b00000000;//T
	display_row_memory[70]  <= 8'b11000000;
	display_row_memory[71]  <= 8'b11000000;
	display_row_memory[72]  <= 8'b11111111;
	display_row_memory[73]  <= 8'b11111111;
	display_row_memory[74]  <= 8'b11000000;
	display_row_memory[75]  <= 8'b11000000;
	display_row_memory[76]  <= 8'b00000000;	
    display_row_memory[77]  <= 8'b00000000;
//right arrow/sw3/down sw6
	display_row_memory[78]  <= 8'b00000000;
	display_row_memory[79]  <= 8'b00011000;
	display_row_memory[80]  <= 8'b00011000;
	display_row_memory[81]  <= 8'b00011000;
	display_row_memory[82]  <= 8'b01111110;
	display_row_memory[83]  <= 8'b00111100;
	display_row_memory[84]  <= 8'b00011000;
	display_row_memory[85]  <= 8'b00000000;
//left arrow/sw4/up sw5
    display_row_memory[86]  <= 8'b00000000;
	display_row_memory[87]  <= 8'b00011000;
	display_row_memory[88]  <= 8'b00111100;
	display_row_memory[89]  <= 8'b01111110;
	display_row_memory[90]  <= 8'b00011000;
	display_row_memory[91]  <= 8'b00011000;
	display_row_memory[92]  <= 8'b00011000;
	display_row_memory[93]  <= 8'b00000000;
//STOP/sw7
	display_row_memory[94]  <= 8'b00000000;//S
	display_row_memory[95]  <= 8'b01110011;
	display_row_memory[96]  <= 8'b11111011;
	display_row_memory[97]  <= 8'b11011011;
	display_row_memory[98]  <= 8'b11011011;
	display_row_memory[99]  <= 8'b11011111;
	display_row_memory[100]  <= 8'b11001110;
	display_row_memory[101]  <= 8'b00000000;
	
	display_row_memory[102]  <= 8'b00000000;//T
	display_row_memory[103]  <= 8'b11000000;
	display_row_memory[104]  <= 8'b11000000;
	display_row_memory[105]  <= 8'b11111111;
	display_row_memory[106]  <= 8'b11111111;
	display_row_memory[107]  <= 8'b11000000;
	display_row_memory[108]  <= 8'b11000000;
	display_row_memory[109]  <= 8'b00000000;
	
	display_row_memory[110]  <= 8'b00000000;//0
	display_row_memory[111]  <= 8'b00111100;
	display_row_memory[112]  <= 8'b01111110;
	display_row_memory[113]  <= 8'b10000001;
	display_row_memory[114]  <= 8'b10000001;
	display_row_memory[115]  <= 8'b01111110;
	display_row_memory[116]  <= 8'b00111100;
	display_row_memory[117]  <= 8'b00000000;
	
    display_row_memory[118]  <= 8'b00000000;//p
	display_row_memory[119]  <= 8'b11111111;
	display_row_memory[120]  <= 8'b11111111;
	display_row_memory[121]  <= 8'b11011000;
	display_row_memory[122]  <= 8'b11011000;
	display_row_memory[123]  <= 8'b11111000;
	display_row_memory[124]  <= 8'b01110000;
	display_row_memory[125]  <= 8'b00000000;
		      		
////walking person/sw8
	display_row_memory[126]  <= 8'b00000000;//frame1
	display_row_memory[127]  <= 8'b00001001;
	display_row_memory[128]  <= 8'b11010010;
	display_row_memory[129]  <= 8'b11111100;
	display_row_memory[130]  <= 8'b11111100;
	display_row_memory[131]  <= 8'b11010010;
	display_row_memory[132]  <= 8'b00001001;
	display_row_memory[133]  <= 8'b00000000;
	
	display_row_memory[134]  <= 8'b00000000;//frame2
	display_row_memory[135]  <= 8'b00001000;
	display_row_memory[136]  <= 8'b11010010;
	display_row_memory[137]  <= 8'b11111101;
	display_row_memory[138]  <= 8'b11111100;
	display_row_memory[139]  <= 8'b11010010;
	display_row_memory[140]  <= 8'b00001001;
	display_row_memory[141]  <= 8'b00000000;
	
	display_row_memory[142]  <= 8'b00000000;//frame3
	display_row_memory[143]  <= 8'b00001001;
	display_row_memory[144]  <= 8'b11010010;
	display_row_memory[145]  <= 8'b11111100;
	display_row_memory[146]  <= 8'b11111100;
	display_row_memory[147]  <= 8'b11010010;
	display_row_memory[148]  <= 8'b00001001;
	display_row_memory[149]  <= 8'b00000000;
	
	display_row_memory[150]  <= 8'b00000000;//frame3
	display_row_memory[151]  <= 8'b00001001;
	display_row_memory[152]  <= 8'b11010010;
	display_row_memory[153]  <= 8'b11111100;
	display_row_memory[154]  <= 8'b11111101;
	display_row_memory[155]  <= 8'b11010010;
	display_row_memory[156]  <= 8'b00001000;
	display_row_memory[157]  <= 8'b00000000;

//error
	display_row_memory[158]  <= 8'b00111100;
	display_row_memory[159]  <= 8'b01000010;
	display_row_memory[160]  <= 8'b10100101;
	display_row_memory[161]  <= 8'b10011001;
	display_row_memory[162]  <= 8'b10011001;
	display_row_memory[163]  <= 8'b10100101;
	display_row_memory[164]  <= 8'b01000010;
	display_row_memory[165]  <= 8'b00111100;
					
end
//col clock
always @(posedge clk) begin
       count1 <= count1+1;
       if (count1 >=10000) begin
		count1 <=0;
		clkd = ~clkd;
		end
end
//scroll clock
always @(posedge clk) begin
       count2 <= count2+1;
       if (count2 >=200000) begin
		count2 <=0;
		clk_scroll = ~clk_scroll;
		end
end
//frame clock
always @(posedge clk) begin
       count3 <= count3+1;
       if (count3 >=50000) begin
		count3 <=0;
		clk_frame = ~clk_frame;
		end
end

//col control logic
always @(posedge clkd or posedge reset) begin
    if (reset) begin
        col_counter <= 0;
    end 
    else begin
        col_counter <= col_counter + 1;
		if (col_counter >= 7)  // Loop the text
            col_counter <= 0;
    end
end

//frame control logic
always @(posedge clk_frame or posedge reset) begin
    if (reset) begin
        frame_counter <= 0;
    end 
    else if(switch==8'b00000001) begin
        frame_counter <= frame_counter + 8;
		if (frame_counter >= 32)  // Loop the frame
            frame_counter <= 0;
    end
    else begin
        frame_counter <= 0;
    end
end

//// Scrolling control logic
always @(switch) begin
    case(switch)
    8'b00000000: begin
					scroll_counter_initial <=0;
					scroll_counter_final <=7;
				 end
	8'b10000000: begin
					scroll_counter_initial <=8;
					scroll_counter_final <=47;
				 end
    8'b01000000: begin
					scroll_counter_initial <=48;
					scroll_counter_final <=77;
				 end
    8'b00100000: begin
					scroll_counter_initial =78;
					scroll_counter_final =85;
				 end
	8'b00010000: begin
					scroll_counter_initial =86;
					scroll_counter_final =93;
				 end	
    8'b00001000: begin
					scroll_counter_initial =86;
					scroll_counter_final =93;
				 end
    8'b00000100: begin
					scroll_counter_initial =78;
					scroll_counter_final =85;
				 end	
    8'b00000010: begin
					scroll_counter_initial =94;
					scroll_counter_final =125;
				 end	
    8'b00000001: begin
					scroll_counter_initial =126;
					scroll_counter_final =133;
				 end
	default :    begin//multiple switch
					scroll_counter_initial =158;
					scroll_counter_final =165;
				 end
	endcase
end

always @(posedge clk_scroll or posedge reset) begin
    if (reset) begin
        scroll_counter <= scroll_counter_initial;
    end 
    else if((switch==8'b00010000)||(switch==8'b00001000)) begin       
        scroll_counter <= scroll_counter - 1;
		if (scroll_counter <= scroll_counter_initial) 
            scroll_counter <= scroll_counter_final;         
		if (scroll_counter >= scroll_counter_final) 
            scroll_counter <= scroll_counter_final;
    end    
    else begin
 		if (scroll_counter <= scroll_counter_initial) 
            scroll_counter <= scroll_counter_initial;    
        scroll_counter <= scroll_counter + 1;
		if (scroll_counter >= scroll_counter_final) 
            scroll_counter <= scroll_counter_initial;
    end
end

// LED Matrix control logic
always @(posedge clkd) begin
    // Set row and column data based on scrolling counter (fade effect)
    if((switch==8'b00001000)||(switch==8'b00000100)) begin
			row <= display_col_memory[col_counter];   // Get column data for current scroll position
			if ((col_counter+scroll_counter)>scroll_counter_final)
				col <= display_row_memory[scroll_counter_initial+(col_counter+scroll_counter)-scroll_counter_final];
			else 
				col <= display_row_memory[col_counter+scroll_counter];
		end
    else begin
			col <= display_col_memory[col_counter];   // Get column data for current scroll position
			if ((col_counter+scroll_counter)>scroll_counter_final)
				row <= display_row_memory[scroll_counter_initial+frame_counter+(col_counter+scroll_counter)-scroll_counter_final];
			else 
				row <= display_row_memory[col_counter+frame_counter+scroll_counter];
	     end
end
endmodule
