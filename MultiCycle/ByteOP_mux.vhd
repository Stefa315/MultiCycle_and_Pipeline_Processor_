----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:11:51 04/24/2020 
-- Design Name: 
-- Module Name:    ByteOP_mux - Behavioral 
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

entity ByteOP_mux is
Port(Byte_sig : in STD_LOGIC;
    Mem_dta_in : in STD_LOGIC_VECTOR(31 downto 0);
	 ByteOP_out : out STD_LOGIC_VECTOR(31 downto 0));

end ByteOP_mux;

architecture Behavioral of ByteOP_mux is

begin
ByteOP_out<=Mem_dta_in when (Byte_sig='0') else 
     ("000000000000000000000000" & Mem_dta_in(7 downto 0));

end Behavioral;

