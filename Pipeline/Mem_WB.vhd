----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:51:39 05/20/2020 
-- Design Name: 
-- Module Name:    Mem_WB - Behavioral 
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

entity Mem_WB is
port ( rst          : in std_logic;
				 clk          : in std_logic;
				 rd           : in std_logic_vector(4 downto 0);
				 ALU_OUT      : in  std_logic_vector(31 downto 0);
				 MEM_OUT      : in std_logic_vector(31 downto 0);
				 RF_WR_DATA_SEL: in std_logic;
				 RF_WR_EN     : in std_logic;
				 rd_out           : out std_logic_vector(4 downto 0);
				 ALU_OUT_out      : out  std_logic_vector(31 downto 0);
				 MEM_OUT_out      : out std_logic_vector(31 downto 0);
				 RF_WR_DATA_SEL_out: out std_logic;
				 RF_WR_EN_out     : out std_logic
				 );
end Mem_WB;

architecture Behavioral of Mem_WB is

begin
process(clk,rst)
begin
		if(rst='1') then
		  ALU_OUT_out <="00000000000000000000000000000000";
		  rd_out <="00000";
		  MEM_OUT_out <="00000000000000000000000000000000";
		  
		 
		  RF_WR_DATA_SEL_out <= '0';
		  
		  RF_WR_EN_out     <= '0';
		 elsif RISING_EDGE(clk) then
		  
		  rd_out <= rd;
		  RF_WR_DATA_SEL_out <= RF_WR_DATA_SEL;
		  RF_WR_EN_out     <= RF_WR_EN;
		  MEM_OUT_out <=MEM_OUT;
		  ALU_OUT_out <=ALU_OUT;  
		  end if;
	end process;	  

end Behavioral;

