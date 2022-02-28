--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:44:17 04/16/2020
-- Design Name:   
-- Module Name:   C:/Users/30698/Desktop/mousikh/Proj_Xili/Proj_OH_/MEM_TESTB.vhd
-- Project Name:  Proj_OH_
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEM_TESTB IS
END MEM_TESTB;
 
ARCHITECTURE behavior OF MEM_TESTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         ByteOp : IN  std_logic_vector(1 downto 0);
         clk : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp : std_logic_vector(1 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          ByteOp => ByteOp,
          clk => clk,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_addr => ALU_MEM_addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          MM_Addr => MM_Addr,
          MM_WrEn => MM_WrEn,
          MM_WrData => MM_WrData,
          MM_RdData => MM_RdData
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here
         ALU_MEM_Addr<="00000000000000000000000000000100";
         MEM_DataIn<="00000000000100000001000010001100";
         Mem_WrEn <='1';
     wait for 100 ns ;
	  
	  Mem_WrEn<='0';
	  wait for 100 ns;
	  
	  ALU_MEM_Addr<="00000000000000000000000000001000";
       MEM_DataIn<="00000000000100000001111110000000";
         Mem_WrEn <='1';
     wait for 100 ns ;
	  
	  Mem_WrEn<='0';		

      wait;
   end process;

END;
