----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:26:28 05/20/2020 
-- Design Name: 
-- Module Name:    Mux_4to1 - Behavioral 
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

entity Mux_4to1 is
port(		
			SEL: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			A: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			C: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			DOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));	
end Mux_4to1;

architecture Behavioral of Mux_4to1 is

signal tmp_out: STD_LOGIC_VECTOR(31 DOWNTO 0);

begin
tmp_out <=	A WHEN SEL="00" ELSE
				B WHEN SEL="01" ELSE
				C WHEN SEL="10" ELSE
				tmp_out;

DOUT<=tmp_out;

end Behavioral;

