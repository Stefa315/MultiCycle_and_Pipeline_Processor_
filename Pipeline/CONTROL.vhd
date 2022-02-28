----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:35:57 04/24/2020 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
Port ( PC_Sel : out  STD_LOGIC;
			  Instru : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : out  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
			  RF_WrData_Sel : out  STD_LOGIC;
           RF_B_Sel : out  STD_LOGIC;
           ImmExtu : out STD_LOGIC_VECTOR(1 downto 0);
           ALU_bin_Sel : out  STD_LOGIC;
           ALU_Func : out  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : out  STD_LOGIC;
           Zero : in  STD_LOGIC;
			  Byte_OP_DP :out STD_LOGIC
			  );
end CONTROL;


architecture Behavioral of CONTROL is


begin
process(clk,rst,instr)
begin
					
						--goto Rtype state
					if(Instru(31 downto 26)= "100000" ) then 
							st <= Rtype;
							RF_B_sel <= '0';     
							ALU_Bin_sel<='0';    -- RF_B sthn ALU
							ALU_func<=Instru(3 downto 0);
							PC_LdEn<='1';
							mux_a_decex_sel <= '0';
				         RF_WrEn <= '1';
							mem_we  <='0';
							rf_wr_datasel <= '0';
										
						--goto Itype state
						elsif (Instru(31 downto 26)= "111000") then      --li
							
							ImmExtu<= "01";
							RF_WrEn<='1';          --grapse sto RF
							RF_B_sel <= '1';
							ALU_Bin_sel<='1';     --dialekse to Immed
							ALU_func<="0000";   --prosthese
							PC_LdEn<='1';
							mux_a_decex_sel <= '1';
							mem_we <= '0';
							rf_wr_datasel <= '0';
								
						--goto Load Word
						elsif(Instru(31 downto 26)= "001111") then 
							
							ImmExtu<= "01";
							Byte_OP_DP<='0';
							ALU_func<="0000";
							ALU_Bin_sel<='1';
							PC_LdEn<='0';
				         mem_we <= '0';
							
							
							
						--goto Store Word
						elsif(Instru(31 downto 26)= "011111") then 
							ImmExtu<= "01"; --sign extend 
							Byte_OP_DP<='0';  --theloyme na kanoume store oloklhro to word 
							ALU_func<="0000"; --add 
							ALU_Bin_sel<='1';
							RF_B_sel<='1';
							MEM_WrEn<='0';
							PC_LdEn<='0';
						
						
	end if;
	end process;
end Behavioral;






