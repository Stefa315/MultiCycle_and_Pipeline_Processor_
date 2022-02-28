----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:20:34 04/14/2020 
-- Design Name: 
-- Module Name:    Extender - Behavioral 
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

entity Extender is
Port ( Instr15_0 : in  STD_LOGIC_VECTOR (15 downto 0);
	    ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
       OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
       Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end Extender;

architecture Behavioral of Extender is

signal tempout : STD_LOGIC_VECTOR (31 downto 0);
signal temp : STD_LOGIC_VECTOR (31 downto 0);

begin


      temp <= ("1111111111111111" & Instr15_0(15 downto 0)) when ((ImmExt  ="01" OR ImmExt="10") AND Instr15_0(15)='1') else --sign extend AND Instr(15)='1')
                ("0000000000000000" & Instr15_0(15 downto 0)) when ((ImmExt = "01" OR ImmExt ="10")); --AND (Instr(15)='0') ;


		tempout <=  ("0000000000000000" & Instr15_0(15 downto 0)) when  (ImmExt="00") AND  ((OpCode="110010") OR (OpCode="110011")) else   --zero fill

						(Instr15_0(15 downto 0) & "0000000000000000") when (ImmExt="00" AND OpCode="111001") else    --zero fill 

						(temp) when (OpCode="111000") OR (OpCode="110000") OR (OpCode="001111") OR (OpCode="011111") OR (OpCode="000111") OR (OpCode="000011") else   --sign extend 

						(temp(29 downto 0) & "00") when (OpCode="111111") OR (OpCode="000000") OR (OpCode="000001") else    --shift

						tempout;
 
 
 Immed <= tempout;

end Behavioral;

