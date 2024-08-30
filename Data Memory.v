module dmem (
	input         clk  ,
	input         we   ,
	input  [31:0] addr ,
	input  [31:0] wdata,
	output [31:0] rdata
);

	reg [31:0] memdata [31:0];
	
	integer f;

	initial
 		begin
  			$readmemb("data_memory.txt", memdata,0,31);
 		end

	assign rdata = memdata[addr];

	always @(posedge clk) begin
		if(1'b1 == we) begin
			memdata[addr] = wdata;
			$display("%b value written to address %b",wdata,addr);
		end
		$writememb("data_final.txt",memdata,0,31);
	end

endmodule