--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:01:10 04/25/2020
-- Design Name:   
-- Module Name:   C:/Users/30698/Desktop/mousikh/Proj_Xili/Proj_OH_/CONTROL_TEST.vhd
-- Project Name:  Proj_OH_
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CONTROL_TEST IS
END CONTROL_TEST;
 
ARCHITECTURE behavior OF CONTROL_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         PC_Sel : OUT  std_logic;
         Instru : IN  std_logic_vector(31 downto 0);
         PC_LdEn : OUT  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_Sel : OUT  std_logic;
         RF_B_Sel : OUT  std_logic;
         ImmExtu : OUT   std_logic_vector(1 downto 0);
         ALU_bin_Sel : OUT  std_logic;
         ALU_Func : OUT  std_logic_vector(3 downto 0);
         MEM_WrEn : OUT  std_logic;
         Zero : IN  std_logic;
         Byte_OP_DP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instru : std_logic_vector(31 downto 0) := (others => '0');
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Zero : std_logic := '0';

 	--Outputs
   signal PC_Sel : std_logic;
   signal PC_LdEn : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_Sel : std_logic;
   signal RF_B_Sel : std_logic;
   signal ALU_bin_Sel : std_logic;
   signal ALU_Func : std_logic_vector(3 downto 0);
   signal MEM_WrEn : std_logic;
   signal Byte_OP_DP : std_logic;
   signal ImmExtu : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          PC_Sel => PC_Sel,
          Instru => Instru,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          RF_WrEn => RF_WrEn,
          RF_WrData_Sel => RF_WrData_Sel,
          RF_B_Sel => RF_B_Sel,
          ImmExtu => ImmExtu,
          ALU_bin_Sel => ALU_bin_Sel,
          ALU_Func => ALU_Func,
          MEM_WrEn => MEM_WrEn,
          Zero => Zero,
          Byte_OP_DP => Byte_OP_DP
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 
Instru<=x"00000000";
		Reset<='1';
		Zero<='1';
      wait for 100 ns;	
		
		Instru<="10000000000000000000000000000000"; --ALU
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
		
		Instru<="11100000000000000000000000000000";  --li (sign EXT)
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
		
		Instru<="00000100000000000000000000000000";    --bne
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
		
		Instru<="00001100000000000000000000000000";    --lb
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
		
		Instru<="00011100000000000000000000000000";   --sb
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
  
  
      Instru<="00111100000000000000000000000000";   --lw
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
  
      Instru<="11001100000000000000000000000000";  --ori
		Reset<='0';
		Zero<='1';
      wait for 100 ns;
     
  
      wait;
   end process;

END;
