--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:53:01 04/18/2020
-- Design Name:   
-- Module Name:   C:/Users/30698/Desktop/mousikh/Proj_Xili/Proj_OH_/PLEASE_TEST_EX.vhd
-- Project Name:  Proj_OH_
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGE_2
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
 
ENTITY PLEASE_TEST_EX IS
END PLEASE_TEST_EX;
 
ARCHITECTURE behavior OF PLEASE_TEST_EX IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );

   -- Clock process definitions

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     

      -- insert stimulus here 
	RF_A<="00000000000000001010000001001000";
	Immed<="00000000000000001000110001000000";
	RF_B<="00000000000000000010011101000111";
	ALU_Bin_sel<='1';
	ALU_func<="0000";
      -- hold reset state for 100 ns.
		 wait for 100 ns;
		 
		 
   RF_A<="00000000000000001010010001001000";
	Immed<="00000000000000001000110001001100";
	RF_B<="00000000000000000010000101000111";
	ALU_Bin_sel<='0';
	ALU_func<="0001"; 
wait for 100 ns;

   RF_A<="00000000000000001010010001001000";
	Immed<="00000000000000001000110001001100";
	RF_B<="00000000000000000000000101000111";
	ALU_Bin_sel<='0';
	ALU_func<="0100"; 
	wait for 100 ns;
	
	   RF_A<="00000000000000001010010001001000";
	Immed<="00000000000000001000110001001100";
	RF_B<="00000000000000000000000101000111";
	ALU_Bin_sel<='0';
	ALU_func<="0101"; 
	wait for 100 ns;
	
      wait;
   end process;

END;
