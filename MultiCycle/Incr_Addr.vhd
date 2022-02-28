----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:50:25 04/15/2020 
-- Design Name: 
-- Module Name:    Incr_Addr - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Incr_Addr is

Port ( in_addr : in  STD_LOGIC_VECTOR (31 downto 0);
        out_addr_4 : out  STD_LOGIC_VECTOR (31 downto 0));
		  
end Incr_Addr;

architecture Behavioral of Incr_Addr is

signal final_addr :STD_LOGIC_VECTOR(31 downto 0);

begin

final_addr <=(in_addr+"00000000000000000000000000000100");
out_addr_4 <=final_addr;

end Behavioral;

