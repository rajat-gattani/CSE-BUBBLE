module aludec (
	input  [31:0] instr     ,
	output [ 2:0] alucontrol,
	output [2:0] branchcontrol
);

	reg [2:0] alucontrol;
	reg [2:0] branchcontrol;

	always @(instr) begin
		casex ({instr[31:26], instr[5:0]})
			12'b001100xxxxxx : alucontrol = 3'b000; // andi
			12'b001101xxxxxx : alucontrol = 3'b001; // ori
			//12'b000100xxxxxx : alucontrol = 3'b110; //beq
			12'b001010xxxxxx : alucontrol = 3'b111;
			12'b001000xxxxxx : alucontrol = 3'b010;
			12'bxxxxxx100000 : alucontrol = 3'b010;
			12'bxxxxxx100010 : alucontrol = 3'b110;
			12'bxxxxxx100100 : alucontrol = 3'b000;
			12'bxxxxxx100101 : alucontrol = 3'b001;
			12'bxxxxxx101010 : alucontrol = 3'b111;
			default          : alucontrol = 3'b010;
		endcase
		casex (instr[31:26])
			6'b000001: branchcontrol = 3'b000;   //bgte
			6'b000011: branchcontrol = 3'b001;   //bleq
			6'b000100: branchcontrol = 3'b010;	 //beq
			6'b000101: branchcontrol = 3'b011;   //bne
			6'b000110: branchcontrol = 3'b100;   //ble
			6'b000111: branchcontrol = 3'b101;   //bgt
			default: branchcontrol = 3'b111;
		endcase
	end

endmodule
