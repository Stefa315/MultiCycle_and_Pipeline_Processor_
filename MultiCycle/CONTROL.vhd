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

type FSM_state is (Init,Rtype,Itype,B1,B2,Idle,Beq,Bneq,Load,Load_RF,Store,Store_Ram,Zero_0,Zero_1);
signal st : FSM_state;

begin

fsm_process : process
	begin
		wait until(Clk'event and Clk ='1');
		if Reset = '1' then
			st <= Init;
			PC_sel<='0';
			PC_LdEn<='0';
			ALU_Bin_sel<='0';
			ALU_func<="0000";
			RF_WrEn<='0';
			RF_WrData_sel<='0';
			RF_B_sel<='0';
			Byte_OP_DP<='0'; 
			MEM_WrEN<='0';
		else	
			case st is 
				when Init=>     --initial state 
					case Instru(31 downto 26) is
						--goto Rtype state
						when "100000" =>
							st <= Rtype;
							RF_B_sel <= '0';     
							ALU_Bin_sel<='0';    -- RF_B sthn ALU
							ALU_func<=Instru(3 downto 0);
							PC_LdEn<='1';
							
						--goto Itype state
						when "111000" =>    --li
							st <= Itype;
							ImmExtu<= "01";
							RF_WrEn<='1';          --grapse sto RF
							RF_B_sel <= '1';
							ALU_Bin_sel<='1';     --dialekse to Immed
							ALU_func<="0000";   --prosthese
							PC_LdEn<='1';
							
						when"111001" =>    --lui
							st <= Itype;
							ImmExtu<= "00";
							RF_WrEn<='1';    --grapse sto RF
							RF_B_sel <= '1';
							ALU_Bin_sel<='1';     --dialekse to Immed
							ALU_func<="0000";   --prosthese
							PC_LdEn<='1';

						when "110000" =>  --addi
							st <= Itype;
							ImmExtu<= "01";
							RF_B_sel <= '1';
							ALU_Bin_sel<='1';     --dialekse to Immed
							RF_WrEn<='1';          --grapse sto RF
							ALU_func<= "0000";   --dialekse ti func tha kaneis
							PC_LdEn<='1';
							
						when "110010" =>  --nandi
							st <= Itype;
							ImmExtu<= "00";
							RF_WrEn<='1';    --grapse sto RF
							RF_B_sel <= '1';
							ALU_Bin_sel<='1';     --dialekse to Immed
							ALU_func<="0010";   
							PC_LdEn<='1';
							
						when "110011" =>  -- ori
							st <= Itype;
							ImmExtu<= "00";
							RF_WrEn<='1';          
							RF_B_sel <= '1';
							ALU_Bin_sel<='1';     --dialekse to Immed
							ALU_func<="0011";   --ALU OR
							PC_LdEn<='1';
						
						--goto Branch
						when "111111" =>  --b
							st <= B1;
							ImmExtu<= "01";
							PC_LdEn<='1';   --energopoihsh eggrafhs sto pc
							PC_sel<='1';  
							
						--goto Branch Equal
						when "000000"=>  --beq
							st<=Beq;
							ImmExtu<= "01";
							RF_B_sel<='1';
							ALU_Bin_sel<='0';
							ALU_func<="0001";
							
						
						--goto Branch not Equal
						when "000001"=>   --bneq
							st<=Bneq;
							ImmExtu<= "01";
							RF_B_sel<='1';
							ALU_Bin_sel<='0';
							ALU_func<="0001";
							
						--goto Load Byte
						when "000011"=>
							st<=Load;
							ImmExtu<= "01";
							Byte_OP_DP<='1';   --load byte
							ALU_func<="0000";
							ALU_Bin_sel<='1';
							PC_LdEn<='0';
						--goto Store Byte
						
						when "000111"=>
							st<=Store;
							ImmExtu<= "01";
							Byte_OP_DP<='1';   --theloume monaxa store ena byte 
							ALU_func<="0000";
							ALU_Bin_sel<='1';
							RF_B_sel<='1';
							MEM_WrEn<='0';
							PC_LdEn<='0';
							
						
						--goto Load Word
						when "001111"=>
							st<=Load;
							ImmExtu<= "01";
							Byte_OP_DP<='0';
							ALU_func<="0000";
							ALU_Bin_sel<='1';
							PC_LdEn<='0';
				
						--goto Store Word
						when "011111"=>
							st<=Store;
							ImmExtu<= "01"; --sign extend 
							Byte_OP_DP<='0';  --theloyme na kanoume store oloklhro to word 
							ALU_func<="0000"; --add 
							ALU_Bin_sel<='1';
							RF_B_sel<='1';
							MEM_WrEn<='0';
							PC_LdEn<='0';
						
						when others =>
							st<=Init;
							PC_LdEn<='1';
					end case;
				
				
				when Rtype=>    --Rtype state
					RF_WrData_sel<='0';    --dialekse ALU out
					RF_WrEn<='1';          --grapse sto RF
					st<=Idle;
					PC_LdEn<='0';  
					
				when Itype=>      --Itype state
					RF_WrData_sel<='0';    
					RF_WrEn<='0';          
					st<=Idle;
					PC_LdEn<='0'; 
					ALU_Bin_sel<='0';     -- RF_B eisodos sthn ALU
				
				when B1=>      --Branch state
					st<=B2;
					PC_LdEn<='0';
					PC_sel<='0';       --SignExtend(Immed)*4
					
				when B2=>
					st<=Init;
					PC_LdEn<='0';
					
				when Beq=>
					if Zero='1' then
						st <= B1;
						PC_LdEn<='1';
						PC_sel<='1'; 
					else
						PC_LdEn<='1';
						st <= B1;
						PC_sel<='0'; 
					end if;
				
				when Bneq=>
					if Zero='0' then
						st <= B1;
						PC_LdEn<='1';
						PC_sel<='1'; 
					else
						PC_LdEn<='1';
						st <= B1;
						PC_sel<='0'; 
					end if;
					
				when Load=>
					st<=Load_RF;
					RF_WrData_sel<='1';
					RF_WrEn<='0';
					PC_LdEn<='1';
					ALU_Bin_sel<='1';     
					
				when Load_RF=>
					st<=Idle;
					RF_WrData_sel<='1';
					RF_WrEn<='1';
					PC_LdEn<='0';
					ALU_Bin_sel<='0';  
					
				when Store=>
					st<=Store_Ram;
					PC_LdEn<='1';
					ALU_Bin_sel<='0';     
					MEM_WrEn<='1';
					
				when Store_Ram=>
					st<=Idle;
					PC_LdEn<='0';
					ALU_Bin_sel<='0';     
					MEM_WrEn<='0';
				
				when Idle=>     
					st<=Init;
					RF_WrEn<='0'; 
					RF_WrData_sel<='0';
					PC_sel<='0';   --epanefora tou PC 

				when others=>
					st<=Init;
			end case;
	end if;
	end process;
end Behavioral;






