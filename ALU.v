module alu (
    input  [31:0] a_in, b_in,
    input  [ 2:0] f_in ,
    input branch,
    input   [2:0] branchcontrol,
    output        zero,
    output        c_out,
    output [31:0] y_out
);

    wire [31:0] not_b_in;
    assign not_b_in = ~ b_in;

    wire [31:0] b_mux_not_b;
    assign b_mux_not_b = (1'b0 == f_in[2]) ? b_in : not_b_in;

    wire [31:0] fx00;
    assign fx00 = a_in & b_mux_not_b;

    wire [31:0] fx01;
    assign fx01 = a_in | b_mux_not_b;

    wire [31:0] fx10;
    assign {c_out, fx10} = a_in + b_mux_not_b + f_in[2];

    wire [31:0] fx11;
    assign fx11 = {{31{1'b0}}, ((a_in[31] == not_b_in[31]) && (fx10[31] != a_in[31])) ? ~(fx10[31]) : fx10[31]};


    //reg [31:0] out;

    //out <= 2'b00 == f_in[1:0] ? fx00 : (2'b01 == f_in[1:0] ? fx01 : (2'b10 == f_in[1:0] ? fx10 : fx11 ));

    reg if_branch;

    always @(*) begin
            case (branchcontrol)
                3'b000: if_branch = (a_in >= b_in);
                3'b001: if_branch = (a_in <= b_in);
                3'b010: if_branch = (a_in == b_in);
                3'b011: if_branch = (a_in != b_in);
                3'b100: if_branch = (a_in > b_in);
                3'b101: if_branch = (a_in < b_in);
                default: if_branch = 0;
            endcase
    end

    wire [31:0] b_out;
    assign b_out = {{31{1'b0}},if_branch};

    wire [31:0] a_out;
    assign a_out = 2'b00 == f_in[1:0] ? fx00 : (2'b01 == f_in[1:0] ? fx01 : (2'b10 == f_in[1:0] ? fx10 : fx11 ));

    assign y_out = branch ? b_out : a_out;

    assign zero = ~| y_out;
    
endmodule