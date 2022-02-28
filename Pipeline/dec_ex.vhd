----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:39:27 05/23/2020 
-- Design Name: 
-- Module Name:    dec_ex - Behavioral 
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

entity dec_ex is
		port ( rst          : in std_logic;
				 clk          : in std_logic;
				 rfa          : in std_logic_vector(31 downto 0);
				 rfb          : in std_logic_vector(31 downto 0);	
				 rs           : in std_logic_vector(4 downto 0);
				 rt           : in std_logic_vector(4 downto 0);
				 rd           : in std_logic_vector(4 downto 0);
				 opcode       : in std_logic_vector(5 downto 0);
				 ALU_FUNC     : in std_logic_vector(3 downto 0);
				 RF_WR_DATA_SEL : in std_logic;
				 immed : in std_logic_vector(31 downto 0);
				 immed_out : out std_logic_vector(31 downto 0);
				 RF_WR_EN     : in std_logic;
				 MEM_WR_EN    : in std_logic;
				 ALU_BIN_SEL  : in std_logic;
				 mux_a_decex_sel: in std_logic;
				 mux_a_decex_sel_out: out std_logic;
				 ALU_BIN_SEL_out  : out std_logic;
				 RF_WR_DATA_SEL_out : out std_logic;
				 RF_WR_EN_out     : out std_logic;
				 MEM_WR_EN_out    : out std_logic;
				 rfa_out      : out std_logic_vector(31 downto 0);
				 rfb_out      : out std_logic_vector(31 downto 0);	
				 rs_out       : out std_logic_vector(4 downto 0);
				 rt_out       : out std_logic_vector(4 downto 0);
				 rd_out       : out std_logic_vector(4 downto 0);
				 opcode_out   : out std_logic_vector(5 downto 0);
				 ALU_FUNC_out : out std_logic_vector(3 downto 0));
				 
end dec_ex;

architecture Behavioral of DEC_EX is

begin
process(clk,rst)
begin
		if(rst='1') then
		  immed_out <= "00000000000000000000000000000000";
		  rfa_out <="00000000000000000000000000000000";
		  rfb_out <="00000000000000000000000000000000";
		  mux_a_decex_sel_out <= '0';
		  rs_out <="00000";
		  rt_out <="00000";
		  rd_out <="00000";
		  opcode_out <="000000";
		  ALU_FUNC_out <="0000";
		  RF_WR_DATA_SEL_out <= '0';
		  ALU_BIN_SEL_out  <= '0';
		  RF_WR_EN_out     <= '0';
		  MEM_WR_EN_out    <= '0';
		 elsif RISING_EDGE(clk) then
		  rfa_out <= rfa;
		  rfb_out <= rfb;
		  rs_out <= rs;
		  rt_out <= rt;
		  rd_out <= rd;
		  opcode_out <= opcode;
		  mux_a_decex_sel_out <= mux_a_decex_sel;
		  immed_out <= IMMED;
		  ALU_FUNC_out <= ALU_FUNC;
		  RF_WR_DATA_SEL_out <= RF_WR_DATA_SEL;
		  ALU_BIN_SEL_out  <= ALU_BIN_SEL;
		  RF_WR_EN_out     <= RF_WR_EN;
		  MEM_WR_EN_out    <= MEM_WR_EN;
		  end if;
	end process;	  
		 

end Behavioral;

