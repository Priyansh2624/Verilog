`timescale 1ns / 1ps
 
module sync_fifo#(parameter fifo_depth=8,
parameter data_width=32)(
input clk, //clock
input cs, //chipselect
input rst_n, //active low reset 
input [data_width-1:0]data_in, //input data
input write_en, //write enable
input read_en,// read enable
output reg [data_width-1:0]data_out, //output data
output empty,// empty flag
output full// full flag
);
    localparam fifo_depth_log = $clog2(fifo_depth); 
    //number of bits required to calculate the number of locations
    
    reg [data_width-1:0] fifo [0:fifo_depth-1];
    
    reg [fifo_depth_log:0] r_pointer;  //read pointer
    reg [fifo_depth_log:0] w_pointer;  //write pointer
    
    //write operation
    always@(posedge clk) begin
     if(!rst_n) begin
        w_pointer<=0;
        end
     else if(cs && write_en && !full) begin
        fifo[w_pointer[fifo_depth_log-1:0]]<=data_in;
        w_pointer<=w_pointer+1'b1;
    end
    end
    
    //read
    always@(posedge clk)begin
    if(!rst_n)begin
    r_pointer <= 0;
    data_out<=0;
    end
    else if(cs && !empty && read_en)begin
    data_out <= fifo[r_pointer[fifo_depth_log-1:0]];
    r_pointer <= r_pointer+1'b1;
    end
    end
    
    assign empty = (r_pointer==w_pointer);
    assign full = (r_pointer=={~w_pointer[fifo_depth_log], w_pointer[fifo_depth_log-1:0]});  
endmodule
