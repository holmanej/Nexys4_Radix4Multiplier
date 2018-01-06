----------------------------------------------------------------------------
-- Entity:			Top
-- Written By:		Eric Holman
-- Date Created:	10/5/16
-- Description:		Implementation top level for GenAdd_Mult, m = n = 8
--					switches => A & B
--					LEDs => Product
-- 
-- Dependencies:
--		GenAdd_Unit, GenAddmbit_Unit, GenAdd_Row, GenAdd_Mult
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Nexys4_Radix4Multiplier is
	Port(
		clk			: in  STD_LOGIC;
		Switches	: in  STD_LOGIC_VECTOR (15 downto 0);
		Leds		: out STD_LOGIC_VECTOR (15 downto 0)
	);
end Nexys4_Radix4Multiplier;

architecture Behavioral of Nexys4_Radix4Multiplier is

	component GenAdd_Mult is
		Port(
			Multiplicand	: in  STD_LOGIC_VECTOR (7 downto 0);
			Multiplier		: in  STD_LOGIC_VECTOR (7 downto 0);
			Product			: out STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;
	
	signal sw_int	:	STD_LOGIC_VECTOR (15 downto 0);
	signal led_int	:	STD_LOGIC_VECTOR (15 downto 0);

begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			Leds <= led_int;
			sw_int <= Switches;
		end if;
	end process;

	uut: GenAdd_Mult port map (
		Multiplicand	=> sw_int(15 downto 8),
		Multiplier		=> sw_int(7 downto 0),
		Product			=> led_int
	);

end Behavioral;
