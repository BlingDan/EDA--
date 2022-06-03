// 自动售货机
// 功能：
//     1. 出饮料
//     2. 找零
//     3. 显示当前投币总数（<9）

//共售卖两种饮品，goods1->RMB4, goods2->RMB5

/*
开发板
key[0] -> 清零
key[1][2] -> 两种硬币
key[3] -> 取饮料
HEX0 显示硬币总数
HEX4 显示取饮料得到的饮料数
*/
module sy5(clk, clr, key, get_goods, out);
(*chip_pin="Y2"*)input clk;
(*chip_pin="M23"*)input clr;  // 清零按钮 
(*chip_pin="M21,N21"*)input reg[1:0] key  //key[1] 两元， key[0] 一元
(*chip_pin="R24"*)input get_goods; // 取饮料按钮
(*chip_pin="G18,F22,E17,L26,L25,J22,H22"*)output reg[6:0] c_coin;
(*chip_pin="AB19,AA19,AG12,AH21,AE19,AF19,AE18"*)output reg[6:0] c_out;


reg [2:0] cs, ns;

parameter   s0 = 3'b000,
            s1 = 3'b001,
            s2 = 3'b010,
            s3 = 3'b011,
            s4 = 3'b100,
            s5 = 3'b101;
            s6 = 3'b110;
            s7 = 3'b111;

always@(posedge clk or posedge clr)
    begin
        if(~clr) 
            cs <= ns;
        else
            cs <= s0;
    end



// always@(cs and (posedge key[0] or posedge key[1]))
always@(posedge key[0] or posedge key[1])
    begin
        case(cs)
            s0: if(key[0]) ns <= s1; if(key[1]) ns <= s2;
            s1: if(key[0]) ns <= s2; if(key[1]) ns <= s3;
            s2: if(key[0]) ns <= s3; if(key[1]) ns <= s4;
            s3: if(key[0]) ns <= s4; if(key[1]) ns <= s5;
            s4: if(key[0]) ns <= s5; if(key[1]) ns <= s6;
            s5: if(key[0]) ns <= s6; if(key[1]) ns <= s7;
        default:
            ns <= s0;
        endcase
    end

//取饮料
always@(posedge get_goods)
    begin
        case(cs)
            s5: begin c_out = 7'b1001111; ns <= s0; end
            s6: begin c_out = 7'b1001111; ns <= s1; end
            s7: begin c_out = 7'b1001111; ns <= s2; end
            default:
            begin
                c_out <= 7'b0000001;
                ns <= ns;
            end
        endcase
    end

//显示当前硬币
show_current_coin(cs, c_coin)
endmodule