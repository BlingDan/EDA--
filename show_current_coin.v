//显示硬币数
module show_current_coin(cs, out)
    input cs ;
    output reg[6:0] out;

    always@(*)
    begin
        case(cs):
            s0: out <= 7'b0000001;
            s1: out <= 7'b1001111;
            s2: out <= 7'b0010010;
            s3: out <= 7'b0000110;
            s4: out <= 7'b1001100;
            s5: out <= 7'b0100100;
            s6: out <= 7'b0100000;
            s7: out <= 7'b0001111;
        endcase
    end
endmodule