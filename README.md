# ⏰Verilog-Alarm-Clock-
This repository contains a Verilog-based Alarm Clock using verilog with an accompanying testbench for simulation and validation. The clock system supports time tracking, alarm setting, and alarm activation upon time match.
Clock counts hours, minutes, seconds

Input Signals:

clk (1-bit Clock signal): Drives the sequential logic. Each positive edge updates time counters and triggers time/alarm logic.

reset	(1-bit	Reset signal): Asynchronous reset that initializes the clock to the loaded time and resets seconds to zero. Also clears the alarm signal.
Hour_in1(2-bit	Hour Tens Digit Input): Used to load the tens place of the hour (0 to 2). For example, for hour = 23, Hour_in1 = 2.
Hour_in0 (4-bit	Hour Units Digit Input): Used to load the units place of the hour (0 to 9). For hour = 23, Hour_in0 = 3.
Minute_in1 (4-bit	Minute Tens Digit Input): Used to load the tens place of minutes (0 to 5). For minute = 58, Minute_in1 = 5.
Minute_in0	(4-bit	Minute Units Digit Input): Used to load the units place of minutes (0 to 9). For minute = 58, Minute_in0 = 8.
Load_time	(1-bit	Time Load Control): When high, the current time is set to the provided hour and minute inputs, and seconds are reset to zero.
Load_alarm	(1-bit	Alarm Set Control0: When high, the alarm time is set to the hour and minute inputs. Alarm seconds are always zero.
Stop_alarm	(1-bit	Alarm Stop Control): When asserted (high), it stops or clears the active alarm signal (Alarm).
Al_On	(1-bit	Alarm Enable): Activates the alarm system. If low, alarm will not trigger even if the time matches.

Output Signals:
Alarm	(1-bit	Alarm Indicator): Goes high (1) when current time matches the alarm time and Al_On is enabled. Cleared by Stop_alarm or reset.
Hour_out1	(2-bit	Hour Tens Digit Output): The tens digit of the current hour, for display or monitoring.
Hour_out0	(4-bit	Hour Units Digit Output): The units digit of the current hour.
Minute_out1	(4-bit	Minute Tens Digit Output): The tens digit of the current minute.
Minute_out0	(4-bit	Minute Units Digit Output): The units digit of the current minute.
Second_out1	(4-bit	Second Tens Digit Output): The tens digit of the current second.
Second_out0	(4-bit	Second Units Digit Output): The units digit of the current second.
