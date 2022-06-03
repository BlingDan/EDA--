module fenpin(clk_50, clk)
input clk_50;
output clk;

reg [31:0] count;

always@(clk_50)
begin
    if(count == 'b24999999)
    begin
        clk <= ~clk;
        count <= 0;
    end
    else
        count <= count + 1;
end