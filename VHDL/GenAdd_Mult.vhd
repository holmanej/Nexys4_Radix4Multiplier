----------------------------------------------------------------------------
-- Entity:			GenAdd_Mult
-- Written By:		Eric Holman
-- Date Created:	10/5/16
-- Description:		Top level of IP. Hard-coded for m = n = 8 bits
-- 
-- Dependencies:
--		GenAdd_Unit, GenAddmbit_Unit, GenAdd_Row
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ALL;

entity GenAdd_Mult is
	Port(
		Multiplicand	: in  STD_LOGIC_VECTOR (7 downto 0);
		Multiplier		: in  STD_LOGIC_VECTOR (7 downto 0);
		Product			: out STD_LOGIC_VECTOR (15 downto 0)
	);
end GenAdd_Mult;

architecture Behavioral of GenAdd_Mult is

	component GenAdd_Row is
		Generic(
			m		: INTEGER := 4
		);
		Port(
			X_in	: in  STD_LOGIC_VECTOR (m downto 0);
			A_in	: in  STD_LOGIC_VECTOR (m-1 downto 0);
			B_in	: in  STD_LOGIC_VECTOR (2 downto 0);
			X_out	: out STD_LOGIC_VECTOR (m+2 downto 0)
		);
	end component;
	
	constant m		:	INTEGER := 8;
	
	type x_arr		is ARRAY (0 to 3) of STD_LOGIC_VECTOR (m+2 downto 0);
	signal x_int	:	x_arr;

begin

	-- selects final product
	Product <= x_int(3)(m+1 downto 0) & 
			   x_int(2)(1 downto 0) &
			   x_int(1)(1 downto 0) &
			   x_int(0)(1 downto 0);

		-- static instantiations of partial product rows --
	
	-- special first case: add "100..." to set up intital row
	MBR_0: GenAdd_Row generic map(m) port map (
		X_in	=> (m => '1', others => '0'),
		A_in	=> Multiplicand,
		B_in	=> Multiplier(1 downto 0) & '0',
		X_out	=> x_int(0)
	);
	
	MBR_1: GenAdd_Row generic map(m) port map (
		X_in	=> x_int(0)(m+2 downto 2),
		A_in	=> Multiplicand,
		B_in	=> Multiplier(3 downto 1),
		X_out	=> x_int(1)
	);
	
	MBR_2: GenAdd_Row generic map(m) port map (
		X_in	=> x_int(1)(m+2 downto 2),
		A_in	=> Multiplicand,
		B_in	=> Multiplier(5 downto 3),
		X_out	=> x_int(2)
	);
	
	MBR: GenAdd_Row generic map (m) port map (
		X_in	=> x_int(2)(m+2 downto 2),
		A_in	=> Multiplicand,
		B_in	=> Multiplier(7 downto 5),
		X_out	=> x_int(3)
	);
	
end Behavioral;
