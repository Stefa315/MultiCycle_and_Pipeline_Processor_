----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:00 05/20/2020 
-- Design Name: 
-- Module Name:    IF_Dec_Reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_DEC is
    Port ( RST 	  : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
			  we       : in std_logic;
           INST_IN  : in  STD_LOGIC_VECTOR (31 downto 0);
           INST_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_Dec_Reg;

architecture Behavioral of IF_Dec_Reg is

begin
process(CLK,RST)
	begin
	
			if (RST='1')then
					tmp_out <= "00000000000000000000000000000000";
			elsif RISING_EDGE(CLK) then
					if ( we = '1') then
					tmp_out <= INST_IN;
					else
					tmp_out <= tmp_out;
					end if;
			end if;
	
	end process;
	
	
INST_OUT<= tmp_out;

end Behavioral;

