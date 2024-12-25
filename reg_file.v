//reg_file for single cycle cpu with 16 register each of 16 bits
//have 2 read ports and 1 write port

module reg_file(
    input clk,
    input wr_en,
    input [3:0] rd_addr1, rd_addr2, wr_addr,
    input [18:0] wr_data,
    output [18:0] rd_data1, rd_data2
);

reg [18:0] reg_file_arr [0:15];
integer i;

initial
    begin
    for(i=0; i<16; i=i+1) begin
        reg_file_arr[i]=0;
        end
     end
     
 always@(posedge clk) begin
 if(wr_en) reg_file_arr[wr_addr] <= wr_data;
 end
 
 assign rd_data1 = (rd_addr1 != 0) ? reg_file_arr[rd_addr1] : 0;
 assign rd_data2 = (rd_addr2 != 0) ? reg_file_arr[rd_addr2] : 0;
 
endmodule
 