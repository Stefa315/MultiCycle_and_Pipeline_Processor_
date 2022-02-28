--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:22:03 04/23/2020
-- Design Name:   
-- Module Name:   C:/Users/30698/Desktop/mousikh/Proj_Xili/Proj_OH_/DATAP_TEST.vhd
-- Project Name:  Proj_OH_
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAP_TEST IS
END DATAP_TEST;
 
ARCHITECTURE behavior OF DATAP_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_Sel : IN  std_logic;
         RF_B_Sel : IN  std_logic;
         ImmExtu : IN  std_logic_vector(1 downto 0);
         ALU_bin_Sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN  std_logic;
         Zero : OUT  std_logic;
			Byte_OP_DP : IN STD_LOGIC;
			IfInstrAddr : out  STD_LOGIC_VECTOR (31 downto 0);
			  Instru : in  STD_LOGIC_VECTOR (31 downto 0);

			  MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_WrEn : out  STD_LOGIC;
			  MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_RdDatau : in  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Sel : std_logic := '0';
   signal Instru : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_Sel : std_logic := '0';
   signal RF_B_Sel : std_logic := '0';
   signal ImmExtu : std_logic_vector (1 downto 0) := (others=> '0');
   signal ALU_bin_Sel : std_logic := '0';
   signal ALU_Func : std_logic_vector(3 downto 0) := (others => '0');
   signal MEM_WrEn : std_logic := '0';
   signal Byte_OP_DP :std_logic := '0';
	signal MM_RdDatau :   STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');
	
 	--Outputs
   signal Zero : std_logic;
   signal IfInstrAddr :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
   signal MM_Addr :   STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
	signal  MM_WrEn :   STD_LOGIC:='0';
	signal  MM_WrData :   STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
			  
   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
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
			 Byte_OP_DP=>Byte_OP_DP,
			 IfInstrAddr=>IfInstrAddr,
			 MM_Addr=>MM_Addr,
			 MM_WrEn=>MM_WrEn,
			 MM_WrData=>MM_WrData,
			 MM_RdDatau=>MM_RdDatau
			 
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
     Reset <= '1';
      wait for 100 ns;	
		
		PC_sel <='0'; 
		
		PC_LdEn <='1'; 
		Reset <= '0';
      wait for 100 ns;	
		--wait for 10 ns ;
		Reset <= '0';


		  -- addi r5,r0,8

		Instru<="110000"&"00000"&"00101"&"0000000000001000";
		PC_sel <='0';	
		PC_LdEn<='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out 
		RF_B_sel  <='0';
		ImmExtu<="10";  -- SIGN EXT
		ALU_Bin_sel <='1';  --Immed
		ALU_func <="0000"; --add			
		Mem_WrEn  <='0';
      Byte_OP_DP<='0';
      wait for 100 ns;	
		
		-- ori r3,r0,ABCD]
		
		Instru<="110011"&"00000"&"00011"&"1010101111001101";
		PC_sel <='0'; 			
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out 
		RF_B_sel  <='0';
		ImmExtu<="00"; --zero fill
		ALU_Bin_sel <='1';  --Immed
		ALU_func <="0011"; --OR			
		Mem_WrEn  <='0';
		
      wait for 100 ns;	
		
		-- sw r3 4(r0)
		
		Instru<="011111"&"00000"&"00011"&"0000000000000100";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='0';
		RF_WrData_sel <='0'; --Mem out dont care
		RF_B_sel  <='1';
		ImmExtu<="10";
		ALU_Bin_sel <='1';  --Immed
		ALU_func  <="0000";	--add	
		Mem_WrEn  <='1'; 
		Byte_OP_DP<='0';
      wait for 100 ns;	
    
		-- lw r10,-4(r5)
		
		Instru<="001111"&"00101"&"01010"&"1111111111111100";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Mem out 
		RF_B_sel  <='0';
		ImmExtu<="10";
		ALU_Bin_sel <='1';  --Immed
		ALU_func  <="0000";--add		
		Mem_WrEn  <='0';  
      wait for 100 ns;	
		
		-- lb r16 4(r0)
		
		Instru<="000011"&"00000"&"10000"&"0000000000000100";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='1'; --Mem out 
		RF_B_sel  <='0';
		ImmExtu<="10";
		ALU_Bin_sel <='1';  --Immed
		ALU_func  <="0000"; --add		
		Mem_WrEn  <='0';  
      Byte_OP_DP<='1';
      wait for 100 ns;	
		
		-- nand r4,r0,r16
		
		Instru<="100000"&"01010"&"00100"&"10000"&"00000"&"110010";
		PC_sel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='1'; --Mem out 
		RF_B_sel  <='1'; --rt
		ImmExtu<="00"; -- dont care
		ALU_Bin_sel <='0';  --RF_B
		ALU_func  <="0101"; --nand		
		Mem_WrEn  <='0';  

  
      wait;
   end process;

END;
