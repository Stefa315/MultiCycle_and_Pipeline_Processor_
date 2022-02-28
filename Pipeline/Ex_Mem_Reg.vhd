----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:13:41 05/20/2020 
-- Design Name: 
-- Module Name:    Ex_Mem_Reg - Behavioral 
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

entity Ex_Mem_Reg is
port ( rst          : in std_logic;
				 clk          : in std_logic;
				 rfb          : in std_logic_vector(31 downto 0);	
				 rd           : in std_logic_vector(4 downto 0);
				 alu_in : in std_logic_vector(31 downto 0);
				 alu_out : out std_logic_vector(31 downto 0);
				 RF_WR_DATA_SEL : in std_logic;
				 RF_WR_EN     : in std_logic;
				 MEM_WR_EN    : in std_logic;
				 RF_WR_DATA_SEL_out : out std_logic;
				 RF_WR_EN_out     : out std_logic;
				 MEM_WR_EN_out    : out std_logic;
				 rfb_out      : out std_logic_vector(31 downto 0);	
				 rd_out       : out std_logic_vector(4 downto 0));
end Ex_Mem_Reg;

architecture Behavioral of Ex_Mem_Reg is

begin
process(clk,rst)
begin
		if(rst='1') then
		 alu_out <="00000000000000000000000000000000";
		  rfb_out <="00000000000000000000000000000000";
		  rd_out <="00000";
		  RF_WR_DATA_SEL_out <= '0';
		  RF_WR_EN_out     <= '0';
		  MEM_WR_EN_out    <= '0'; 
		 elsif RISING_EDGE(clk) then
		  alu_out <= alu_in;
		  rfb_out <= rfb;
		  rd_out <= rd;
		  RF_WR_DATA_SEL_out <= RF_WR_DATA_SEL;
		  RF_WR_EN_out     <= RF_WR_EN;
		  MEM_WR_EN_out    <= MEM_WR_EN;
		  end if;
	end process;	  

end Behavioral;

