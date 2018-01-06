## General properties
set_property IOSTANDARD LVCMOS33 [get_ports]
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

## Clock signal
set_property PACKAGE_PIN E3 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Switches
set_property PACKAGE_PIN U9 [get_ports {Switches[0]}]
set_property PACKAGE_PIN U8 [get_ports {Switches[1]}]
set_property PACKAGE_PIN R7 [get_ports {Switches[2]}]
set_property PACKAGE_PIN R6 [get_ports {Switches[3]}]
set_property PACKAGE_PIN R5 [get_ports {Switches[4]}]
set_property PACKAGE_PIN V7 [get_ports {Switches[5]}]
set_property PACKAGE_PIN V6 [get_ports {Switches[6]}]
set_property PACKAGE_PIN V5 [get_ports {Switches[7]}]
set_property PACKAGE_PIN U4 [get_ports {Switches[8]}]
set_property PACKAGE_PIN V2	[get_ports {Switches[9]}]
set_property PACKAGE_PIN U2 [get_ports {Switches[10]}]
set_property PACKAGE_PIN T3	[get_ports {Switches[11]}]
set_property PACKAGE_PIN T1 [get_ports {Switches[12]}]
set_property PACKAGE_PIN R3 [get_ports {Switches[13]}]
set_property PACKAGE_PIN P3 [get_ports {Switches[14]}]
set_property PACKAGE_PIN P4 [get_ports {Switches[15]}]

# LEDs
set_property PACKAGE_PIN T8 [get_ports {Leds[0]}]
set_property PACKAGE_PIN V9	[get_ports {Leds[1]}]
set_property PACKAGE_PIN R8 [get_ports {Leds[2]}]
set_property PACKAGE_PIN T6 [get_ports {Leds[3]}]
set_property PACKAGE_PIN T5 [get_ports {Leds[4]}]
set_property PACKAGE_PIN T4 [get_ports {Leds[5]}]
set_property PACKAGE_PIN U7 [get_ports {Leds[6]}]
set_property PACKAGE_PIN U6 [get_ports {Leds[7]}]
set_property PACKAGE_PIN V4 [get_ports {Leds[8]}]
set_property PACKAGE_PIN U3 [get_ports {Leds[9]}]
set_property PACKAGE_PIN V1 [get_ports {Leds[10]}]
set_property PACKAGE_PIN R1 [get_ports {Leds[11]}]
set_property PACKAGE_PIN P5 [get_ports {Leds[12]}]
set_property PACKAGE_PIN U1 [get_ports {Leds[13]}]
set_property PACKAGE_PIN R2 [get_ports {Leds[14]}]
set_property PACKAGE_PIN P2 [get_ports {Leds[15]}]