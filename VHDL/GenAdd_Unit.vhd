----------------------------------------------------------------------------
-- Entity:			GenAdd_Unit
-- Written By:		Eric Holman
-- Date Created:	10/5/16
-- Description:		Generates partial product using modified radix-4
--					booth recoding and adds it with previous partial
--					product. Closely models the Xilinx LUT6 architecture
-- 
-- Dependencies:
--		none
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GenAdd_Unit is
	Port(
		I6		: in  STD_LOGIC;
		I5		: in  STD_LOGIC;
		I4		: in  STD_LOGIC;
		I3		: in  STD_LOGIC;
		I2		: in  STD_LOGIC;
		I1		: in  STD_LOGIC;
		C_in	: in  STD_LOGIC;
		C_out	: out STD_LOGIC;
		Sum		: out STD_LOGIC		
	);
end GenAdd_Unit;

architecture Behavioral of GenAdd_Unit is

	signal B	:	STD_LOGIC_VECTOR (2 downto 0);
	signal O5	:	STD_LOGIC;
	signal O6	:	STD_LOGIC;

begin

	-- bits selected from multipler
	B		<= I5 & I4 & I3;

	-- selection of partial product bit
	-- according to booth recoding
	with B select O5 <=
		'0'		when	"000",
		I2		when	"001",
		I2		when	"010",
		I1		when	"011",
		not I1	when	"100",
		not I2	when	"101",
		not I2	when	"110",
		'1'		when	"111",
		'0'		when others;
		
	-- determines the output of the mux from
	-- the LUT5's
	O6		<= not O5 when (I6 = '1') else O5;
	
	-- determines the carry out in the fast adder net
	C_out	<= C_in when (O6 = '1') else O5;
	-- produces the partial sum bit to be passed down
	Sum		<= C_in xor O6; 

end Behavioral;
