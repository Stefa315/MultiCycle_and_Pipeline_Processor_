----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:35 04/15/2020 
-- Design Name: 
-- Module Name:    MUX_PC - Behavioral 
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

entity MUX_PC is
    Port ( Mem_plus4 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_add_plusImmed : in  STD_LOGIC_VECTOR (31 downto 0);
           IF_Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in  STD_LOGIC);

end MUX_PC;

architecture Behavioral of MUX_PC is
begin

IF_Mux_out<= Mem_plus4 when mux_sel='0' else
			 Mem_add_plusImmed;


end Behavioral;

