module maindec (
	input  [31:0] instr     ,
	//
	output        branch    ,
	output        jump      ,
	output        mem_to_reg,
	output        mem_write ,
	output        reg_dst   ,
	output        reg_write ,
	output        alu_src
);

	wire [5:0] opcode;
	assign opcode = instr[31:26];

	wire [5:0] func;
	assign func = instr[5:0];

	wire is_add = ((opcode == 6'h00) & (func == 6'h20));
	wire is_sub = ((opcode == 6'h00) & (func == 6'h22));
	wire is_and = ((opcode == 6'h00) & (func == 6'h24));
	wire is_or  = ((opcode == 6'h00) & (func == 6'h25));
	wire is_slt = ((opcode == 6'h00) & (func == 6'h2A));

	wire is_lw = (opcode == 6'h23);
	wire is_sw = (opcode == 6'h2B);

	wire is_beq  = (opcode == 6'h04);
	wire is_bne = (opcode == 6'h05);
	wire is_bgt = (opcode == 6'h07);
	wire is_bgte = (opcode == 6'h01);
	wire is_ble = (opcode == 6'h06);
	wire is_bleq = (opcode == 6'h03);
	wire is_addi = (opcode == 6'h08);
	wire is_andi = (opcode == 6'h0c);
	wire is_ori = (opcode == 6'h0d);
	wire is_slti = (opcode == 6'h0a);
	wire is_j    = (opcode == 6'h02);

	assign branch     = is_beq| is_bne | is_bgt | is_bgte | is_ble | is_bleq;
	assign jump       = is_j;
	assign mem_to_reg = is_lw;
	assign mem_write  = is_sw;
	assign reg_dst    = is_add | is_sub | is_and | is_or | is_slt;
	assign reg_write  = is_add | is_sub | is_and | is_or | is_slt | is_addi | is_lw| is_andi | is_ori | is_slti;
	assign alu_src    = is_addi | is_lw | is_sw | is_andi | is_ori | is_slti;

endmodule