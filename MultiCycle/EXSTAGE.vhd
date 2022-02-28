----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:59:20 03/25/2020 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is
component ALU is
	Port (  A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           DOut : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;


component MUX_ALU is
	 Port ( RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           Mout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal sigMout : STD_LOGIC_VECTOR (31 downto 0);
signal sigZero, sigOvf, sigCout : STD_LOGIC;

begin


MUX_ALU1 : MUX_ALU 
	port map( 	RF_B => RF_B,
					Immed => Immed,
					ALU_Bin_sel =>ALU_Bin_sel,
					Mout => sigMout);
  
ALU_1 : ALU 
	port map( 	A =>RF_A,
					B =>sigMout,
					Op =>ALU_func,
					Zero =>sigZero,
					Cout =>sigCout,
					Ovf =>sigOvf,
					Dout =>ALU_out);
					
ALU_zero <= sigZero;	


end Behavioral;

