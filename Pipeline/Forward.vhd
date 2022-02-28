----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:57 05/22/2020 
-- Design Name: 
-- Module Name:    Forward - Behavioral 
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

entity Forward is
    Port ( pc_en : in  STD_LOGIC;
           rs_id_ex : in  STD_LOGIC_VECTOR (4 downto 0);
           rt_id_ex : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_ex_mem : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_mem_wb : in  STD_LOGIC_VECTOR (4 downto 0);
           ex_mem_en : in  STD_LOGIC;
           mem_wb_en : in  STD_LOGIC;
           muxA_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           muxB_Sel : out  STD_LOGIC_VECTOR (1 downto 0));
end Forward;

architecture Behavioral of Forward is

begin
process(rs_id_ex,rt_id_ex,ex_mem_en,mem_wb_en)
begin
   if( (rs_id_ex = rd_ex_mem OR rt_id_ex = rd_ex_mem) AND ex_mem_en = '1' AND pc_en = '1') then         --sig exmem  DEC_EX...EX_MEM
	   if(rs_id_ex = rd_ex_mem) then
		   muxA_sel <= "01";
		else
		   muxA_sel <= "00";
	   end if;
		if(rt_id_ex = rd_ex_mem) then
		   muxB_Sel <= "01";
		else
		   muxB_sel <= "00";
	   end if;
	elsif( (rs_id_ex = rd_mem_wb OR rt_id_ex = rd_mem_wb) AND mem_wb_en = '1' AND pc_en = '1') then    -- sigMEMWB  DEC_EX...MEMWB
	   if(rs_id_ex = rd_mem_wb) then
		   muxA_sel <= "10";                              
		else
		   muxA_sel <= "00";
	   end if;
		if(rt_id_ex = rd_mem_wb) then
		   muxB_Sel <= "10";
		else
		   muxB_sel <= "00";
	   end if;
	else
	   muxA_sel <= "00";
		muxB_Sel <= "00";

	end if;
end process;

end Behavioral;

