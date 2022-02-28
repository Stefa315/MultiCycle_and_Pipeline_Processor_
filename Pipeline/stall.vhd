----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:40:31 05/23/2020 
-- Design Name: 
-- Module Name:    stall - Behavioral 
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

entity stall is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
		   opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           rd_dec_ex : in  STD_LOGIC_VECTOR (4 downto 0);
           rs_if_dec : in  STD_LOGIC_VECTOR (4 downto 0);
           rt_if_dec : in  STD_LOGIC_VECTOR (4 downto 0); 
           pc_en : out  STD_LOGIC;
           if_id_en : out  STD_LOGIC);
end Stall;

architecture Behavioral of stall is
type state_type is (A,B);
signal state,next_state: state_type;

begin
	
	process (clk)
	begin
		if (rst ='1') then
			state <= B;
		elsif (rising_edge(clk)) then
		  state <= next_state;
		end if;
	end process;
	
	process(state,opcode,rs_if_dec,rt_if_dec)
	begin
		case state is
		when A =>
			pc_en <= '0';
			if_id_en <= '0';
			next_state <= B;
		when B =>
			if ( opcode = "001111" AND (rs_if_dec = rd_dec_ex OR rt_if_dec =rd_dec_ex)) then
				pc_en <= '0';
				if_id_en <= '1';
				next_state <= A;
			else
				pc_en <= '1';
				if_id_en <= '1';
				next_state <= B;
			end if;
			
		end case;
	end process;

end Behavioral;

