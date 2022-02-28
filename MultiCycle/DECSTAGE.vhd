----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:36 03/25/2020 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
Port (     Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component RF is
	Port ( clk : in  STD_LOGIC;
           WrEn : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0));
end component;

component Extender is
	Port ( Instr15_0 : in  STD_LOGIC_VECTOR (15 downto 0);
			  ImmExt : in STD_LOGIC_VECTOR(1 downto 0);
           OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_WrData is
	Port ( ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           MWrout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_Read is
	Port ( Instr15_11 : in  STD_LOGIC_VECTOR (4 downto 0);
           Instr20_16 : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel : in  STD_LOGIC;
           MRout : out  STD_LOGIC_VECTOR (4 downto 0));
end component;


signal MReadOut:STD_LOGIC_VECTOR(4 downto 0);
signal MRecOut:STD_LOGIC_VECTOR(31 downto 0);

begin

RegisterFile_1:RF 
	port map(   Din=>MRecOut,
					Adr1=>Instr(25 downto 21),
					Adr2=>MReadOut,
					Awr=>Instr(20 downto 16),
					clk=>Clk,
					WrEn=>RF_WrEn,
					Dout1=>RF_A,
					Dout2=>RF_B);
					
					
Extender_1 :Extender 
	port map(   Instr15_0=>Instr(15 downto 0),
					ImmExt=>ImmExt,
					OpCode=>Instr(31 DOWNTO 26),
					Immed=>Immed);
					
					
MUXRec:MUX_WrData 
	port map(   MEM_out=>MEM_out,
					ALU_out=>ALU_out,
					RF_WrData_sel=>RF_WrData_sel,
					MWrOut=>MRecOut); 


MUXRead:MUX_Read 
	port map(   Instr15_11=>Instr(15 downto 11),
					Instr20_16=>Instr(20 downto 16),
					RF_B_sel=>RF_B_sel,
					MRout=>MReadOut);	

end Behavioral;

