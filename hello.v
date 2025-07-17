`timescale 1ns / 1ps
module hello(
    input clk,
    input reset,
    input [1:0] Hour_in1,
    input [3:0] Hour_in0,
    input [3:0] Minute_in1,
    input [3:0] Minute_in0,
    input Load_time,
    input Load_alarm,
    input Stop_alarm,
    input Al_On,
    output reg Alarm,
    output [1:0] Hour_out1,
    output [3:0] Hour_out0,
    output [3:0] Minute_out1,
    output [3:0] Minute_out0,
    output [3:0] Second_out1,
    output [3:0] Second_out0
);

reg [5:0] temp_hour, temp_minute, temp_second;
reg [1:0] c_hour1, a_hour1;
reg [3:0] c_hour0, a_hour0, c_min1, a_min1, c_min0, a_min0, c_sec1, a_sec1, c_sec0, a_sec0;

// Function to get tens digit
function [3:0] mod_10(input [5:0] number);
    mod_10 = number / 10;
endfunction

// Time and alarm loading / updating
always @(posedge clk or posedge reset) begin
    if (reset) begin
        {a_hour1, a_hour0, a_min1, a_min0, a_sec1, a_sec0} <= 0;
        temp_hour <= Hour_in1 * 10 + Hour_in0;
        temp_minute <= Minute_in1 * 10 + Minute_in0;
        temp_second <= 0;
    end else begin
        if (Load_alarm) begin
            {a_hour1, a_hour0, a_min1, a_min0, a_sec1, a_sec0} <= {Hour_in1, Hour_in0, Minute_in1, Minute_in0, 4'b0, 4'b0};
        end else if (Load_time) begin
            temp_hour <= Hour_in1 * 10 + Hour_in0;
            temp_minute <= Minute_in1 * 10 + Minute_in0;
            temp_second <= 0;
        end else begin
            temp_second <= temp_second + 1;
            if (temp_second >= 60) begin
                temp_second <= 0;
                temp_minute <= temp_minute + 1;
                if (temp_minute >= 60) begin
                    temp_minute <= 0;
                    temp_hour <= temp_hour + 1;
                    if (temp_hour >= 24) temp_hour <= 0;
                end
            end
        end
    end
end

// BCD Conversion
always @(*) begin
    c_hour1 = temp_hour / 10;
    c_hour0 = temp_hour % 10;
    c_min1 = temp_minute / 10;
    c_min0 = temp_minute % 10;
    c_sec1 = temp_second / 10;
    c_sec0 = temp_second % 10;
end

// Alarm logic
always @(posedge clk or posedge reset) begin
    if (reset)
        Alarm <= 0;
    else begin
        if ({a_hour1, a_hour0, a_min1, a_min0, a_sec1, a_sec0} == {c_hour1, c_hour0, c_min1, c_min0, c_sec1, c_sec0})
            if (Al_On) Alarm <= 1;
        if (Stop_alarm) Alarm <= 0;
    end
end

assign Hour_out1 = c_hour1;
assign Hour_out0 = c_hour0;
assign Minute_out1 = c_min1;
assign Minute_out0 = c_min0;
assign Second_out1 = c_sec1;
assign Second_out0 = c_sec0;

endmodule
