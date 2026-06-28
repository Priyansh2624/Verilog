`timescale 1ns / 1ps
module sync_fifo_tb;
parameter fifo_depth = 8;
parameter data_width = 32;
reg clk=0; //clock
reg cs; //chipselect
reg rst_n; //active low reset 
reg [data_width-1:0]data_in; //input data
reg write_en; //write enable
reg read_en;// read enable
wire [data_width-1:0]data_out; //output data
wire empty;// empty flag
wire full;// full flag

integer i;

sync_fifo dut(.clk(clk),.cs(cs),.rst_n(rst_n),.data_in(data_in),
            .write_en(write_en),.read_en(read_en)
        ,.data_out(data_out),.empty(empty),.full(full));
        
always begin #5 clk=~clk; end

initial begin

    // Initial values
    cs       = 0;
    rst_n    = 0;
    write_en = 0;
    read_en  = 0;
    data_in  = 0;

    // Apply Reset
    #20;
    rst_n = 1;
    cs = 1;

    // Write 8 values
    write_en = 1;

    for(i = 0; i < fifo_depth; i=i+1) begin
        data_in = i + 1;
        #10;
    end
    write_en = 0;
    #20;

    // Read 8 values
    read_en = 1;

    for(i = 0; i < fifo_depth; i = i + 1) begin
        #10;
    end
    read_en = 0;
    #20;
    $finish;

end

initial begin
    $monitor("Time=%0t  Data_in=%0d  Data_out=%0d  Full=%b  Empty=%b",
             $time, data_in, data_out, full, empty);
end
endmodule
