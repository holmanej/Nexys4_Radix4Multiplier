----------------------------------------------------------------------------
-- Entity:			GenAdd_Row
-- Written By:		Eric Holman
-- Date Created:	10/5/16
-- Description:		Generates 'm' GenAdd_Units to produce a row of partial
--					products
-- 
-- Dependencies:
--		GenAdd_Unit, GenAddmbit_Unit
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GenAdd_Row is
	Generic(
		m		: INTEGER := 4
	);
	Port(
		X_in	: in  STD_LOGIC_VECTOR (m downto 0);
		A_in	: in  STD_LOGIC_VECTOR (m-1 downto 0);
		B_in	: in  STD_LOGIC_VECTOR (2 downto 0);
		X_out	: out STD_LOGIC_VECTOR (m+2 downto 0)
	);
end GenAdd_Row;

architecture Behavioral of GenAdd_Row is

	component GenAdd_Unit is
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
	end component;
	
	component GenAdd_mbitUnit is
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
	end component;
	
	signal x_int	:	STD_LOGIC_VECTOR (m+2 downto 0);
	signal carry	:	STD_LOGIC_VECTOR (m+1 downto 0);
	
begin

	-- assigns the "Op" bit to the carry to
	-- determine operation (add/sub)
	carry(0) <= B_in(2);
	
	-- least-significant LUT special case
	Pp_0: GenAdd_Unit port map (
		I6		=> X_in(0),
		I5		=> B_in(2),
		I4		=> B_in(1),
		I3		=> B_in(0),
		I2		=> A_in(0),
		I1		=> '0',
		C_in	=> carry(0),
		C_out	=> carry(1),
		Sum		=> X_int(0)
	);
	
	-- generic instantiation of LUTs between
	-- Pp_m and Pp_0
	PpGen: for i in 1 to m-1 generate
		GAU_gen: GenAdd_Unit port map (
			I6		=> X_in(i),
			I5		=> B_in(2),
			I4		=> B_in(1),
			I3		=> B_in(0),
			I2		=> A_in(i),
			I1		=> A_in(i-1),
			C_in	=> carry(i),
			C_out	=> carry(i+1),
			Sum		=> X_int(i)
		);
	end generate;
	
	-- m-bit LUT special case, outputs of
	-- LUT5's are switched
	Pp_m: GenAdd_mbitUnit port map (
		I6		=> X_in(m),
		I5		=> B_in(2),
		I4		=> B_in(1),
		I3		=> B_in(0),
		I2		=> A_in(m-1),
		I1		=> A_in(m-1),
		C_in	=> carry(m),
		C_out	=> carry(m+1),
		Sum		=> X_int(m)
	);
	
	-- the "m+1 LUT" is optimised out as
	-- it outputs a static '1'
	x_int(m+1) <= not carry(m+1);
	-- the carry out from "m+1 LUT" and MSB
	x_int(m+2) <= carry(m+1);
	
	-- assignment to the output port
	X_out <= x_int;

end Behavioral;
