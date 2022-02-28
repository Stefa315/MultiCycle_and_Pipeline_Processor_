----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:23 04/15/2020 
-- Design Name: 
-- Module Name:    Incr_Immed_Addr - Behavioral 
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Incr_Immed_Addr is
    Port ( Addr_Iin : in  STD_LOGIC_VECTOR (31 downto 0);
           Addr_Immedin : in  STD_LOGIC_VECTOR (31 downto 0);
           Add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Incr_Immed_Addr;

architecture Behavioral of Incr_Immed_Addr is

signal result :STD_LOGIC_VECTOR(31 downto 0);

begin

	--result<= Addr_Iin + (Addr_Immedin *"00000000000000000000000000000100");
result<= Addr_Iin + Addr_Immedin ;
	Add_out<=result;




end Behavioral;

