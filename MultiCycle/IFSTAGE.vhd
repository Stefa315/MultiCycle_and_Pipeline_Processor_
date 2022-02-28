----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:47 03/25/2020 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component Incr_Addr is    --+4 address

Port ( in_addr : in  STD_LOGIC_VECTOR (31 downto 0);
       out_addr_4 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;



component Incr_Immed_Addr is  --+Immed address 

PORT (Addr_Iin : in  STD_LOGIC_VECTOR (31 downto 0);
      Addr_Immedin : in  STD_LOGIC_VECTOR (31 downto 0);
      Add_out : out  STD_LOGIC_VECTOR (31 downto 0));

end component;

component MUX_PC is    --+4 Address or Immediate 
	Port ( Mem_plus4 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mem_add_plusImmed : in  STD_LOGIC_VECTOR (31 downto 0);
           IF_Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           mux_sel : in  STD_LOGIC);
end component;

component PC is
	Port ( clk : in  STD_LOGIC;
	        rst : in  STD_LOGIC;
			  PC_LdEn : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;





signal IFmuxOut, IFPCout, IFIncr4, IFIncrIm, MEM_Instr, MEM_out : STD_LOGIC_VECTOR (31 downto 0);
signal PCOUT: STD_LOGIC_VECTOR (10 downto 0);


begin

PC_1: PC
	port map( 	clk=>clk,
					rst=>Reset,
					Din=>IFMuxOut,
					Dout=>IFPCout,
					PC_LdEn=>PC_LdEn);
					


Incr: Incr_Addr
port map( 	in_addr=>IFPCout,
				out_addr_4=>IFIncr4);
					
					
Incr_Imm: Incr_Immed_Addr
port map( 	Addr_Iin=>IFIncr4,
				Addr_Immedin=>PC_Immed,
				Add_out=>IFIncrIM);	
					

					
					
Mult_PC: MUX_PC
port map( 	Mem_plus4=>IFIncr4,
				Mem_add_plusImmed=>IFIncrIm,
			   IF_Mux_out=>IFMuxOut,
				mux_sel=>PC_sel);					
									
										
PC_out <= IFPCout;				

end Behavioral;

