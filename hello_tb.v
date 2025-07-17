`include "hello.v"

module hello_tb;

reg reset, clk;
reg [1:0] Hour_in1;
reg [3:0] Hour_in0, Minute_in1, Minute_in0;
reg Load_time, Load_alarm, Stop_alarm, Al_On;

wire Alarm;
wire [1:0] Hour_out1;
wire [3:0] Hour_out0, Minute_out1, Minute_out0, Second_out1, Second_out0;

// Instantiate DUT
hello uut (
    .reset(reset),
    .clk(clk),
    .Hour_in1(Hour_in1),
    .Hour_in0(Hour_in0),
    .Minute_in1(Minute_in1),
    .Minute_in0(Minute_in0),
    .Load_time(Load_time),
    .Load_alarm(Load_alarm),
    .Stop_alarm(Stop_alarm),
    .Al_On(Al_On),
    .Alarm(Alarm),
    .Hour_out1(Hour_out1),
    .Hour_out0(Hour_out0),
    .Minute_out1(Minute_out1),
    .Minute_out0(Minute_out0),
    .Second_out1(Second_out1),
    .Second_out0(Second_out0)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;  // Fast clock for simulation

// Monitor output
always @(posedge clk) begin
    $display("Time: %0d%0d:%0d%0d:%0d%0d | Alarm: %b", 
        Hour_out1, Hour_out0, Minute_out1, Minute_out0, Second_out1, Second_out0, Alarm);
end

// Stimulus
initial begin
    $dumpfile("hello.vcd");
    $dumpvars(0, hello_tb);

    // Initialize
    reset = 1; Load_time = 0; Load_alarm = 0; Stop_alarm = 0; Al_On = 0;
    Hour_in1 = 2; Hour_in0 = 3; // Start Time = 23
    Minute_in1 = 5; Minute_in0 = 8; // 58 minutes
    #20;

    reset = 0; Load_time = 1; #10; Load_time = 0;

    // Set alarm at 23:59:02
    #10;
    Hour_in1 = 2; Hour_in0 = 3;
    Minute_in1 = 5; Minute_in0 = 9;
    Load_alarm = 1; Al_On = 1; 
    #10; Load_alarm = 0;

    // Wait until alarm triggers
    wait (Alarm == 1);
    $display(">>> Alarm Triggered at %0d%0d:%0d%0d:%0d%0d", 
        Hour_out1, Hour_out0, Minute_out1, Minute_out0, Second_out1, Second_out0);

    #20; Stop_alarm = 1;
    #10; Stop_alarm = 0;

    #50;
    $finish;
end

endmodule
