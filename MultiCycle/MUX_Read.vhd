----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:10:43 04/15/2020 
-- Design Name: 
-- Module Name:    MUX_Read - Behavioral 
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

entity MUX_Read is
    Port ( Instr15_11 : in  STD_LOGIC_VECTOR (4 downto 0);
           Instr20_16 : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel : in  STD_LOGIC;
           MRout : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX_Read;

architecture Behavioral of MUX_Read is

begin

MRout <= Instr15_11 when (RF_B_sel='0') else --instr15-11
	     Instr20_16;                       --instr16-20


end Behavioral;

