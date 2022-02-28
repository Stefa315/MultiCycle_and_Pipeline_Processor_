----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:28 04/15/2020 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE is
    Port ( ByteOp : in STD_LOGIC;
	        clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_Addr : out STD_LOGIC_VECTOR (31 downto 0);
			  MM_WrEn : out STD_LOGIC;
			  MM_WrData : out STD_LOGIC_VECTOR (31 downto 0);
			  MM_RdData : in STD_LOGIC_VECTOR (31 downto 0));
			  
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

component ByteOP_mux is

Port(
Byte_sig : in STD_LOGIC;
    Mem_dta_in : in STD_LOGIC_VECTOR(31 downto 0);
	 ByteOP_out : out STD_LOGIC_VECTOR(31 downto 0));

end component ByteOP_mux;


	
signal inst_dout ,mem_dout , sigMEM_DataIn , sigMM_WrData , sigMM_RdData , sigMEM_DataOut: std_logic_vector(31 downto 0);
signal BOP : std_logic;
signal addrsignal : std_logic_vector(31 downto 0);

begin

sigMEM_DataIn <= MEM_DataIn; 
sigMM_RdData <= MM_RdData;
BOP <= ByteOP;


BUX : ByteOP_mux 
port map (
Byte_sig => BOP,
Mem_dta_in => sigMEM_DataIn,
ByteOP_out => sigMM_WrData);

BUXez : ByteOP_mux 
port map (
Byte_sig => BOP,
Mem_dta_in => sigMM_RdData,
ByteOP_out => sigMEM_DataOut);


addrsignal<=("00" & ALU_MEM_addr(31 downto 2))+"00000000000000000000010000000000";


MM_WrEn <= MEM_WrEn;
MM_Addr<=addrsignal; -- ( 1024 + addr )

MM_WrData <= sigMM_WrData;
MEM_DataOut <= sigMEM_DataOut;

end Behavioral;

