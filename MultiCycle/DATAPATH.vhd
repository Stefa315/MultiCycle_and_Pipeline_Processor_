----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:55:25 04/20/2020 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
    Port ( PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  RF_WrData_Sel : in  STD_LOGIC;
           RF_B_Sel : in  STD_LOGIC;
           ImmExtu : in  STD_LOGIC_VECTOR(1 downto 0);
           ALU_bin_Sel : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : in  STD_LOGIC;
           Zero : out  STD_LOGIC;
			  Byte_OP_DP :in STD_LOGIC;
			  
			  IfInstrAddr : out  STD_LOGIC_VECTOR (31 downto 0);
			  Instru : in  STD_LOGIC_VECTOR (31 downto 0);

			  MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_WrEn : out  STD_LOGIC;
			  MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_RdDatau : in  STD_LOGIC_VECTOR (31 downto 0)
			  );
end DATAPATH;

architecture Behavioral of DATAPATH is

component IFSTAGE is 
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component IFSTAGE;


component DECSTAGE is
Port (     Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component DECSTAGE;


component  MEMSTAGE is
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

			  
end component MEMSTAGE;

component EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end component EXSTAGE;


signal  Instr_address,Instr_sig, Immed_sig, AluOut_sig,  regRFA, regRFB ,data_mem_out ,sigMM_WrData , sigMM_RdData: STD_LOGIC_VECTOR (31 downto 0);
signal WrData_sel,ImmEx_DP: STD_LOGIC_VECTOR (1 downto 0);
signal ByteOP_sig , sigMM_WrEn: STD_LOGIC;
signal sigMM_Addr : STD_LOGIC_VECTOR (31 downto 0);


begin

--MM_RdData=> sigMM_RdData;

IFstage_1: IFSTAGE
	Port map ( 	  PC_Immed =>Immed_sig,
						PC_sel =>PC_Sel,
						PC_LdEn =>PC_LdEn,
						RESET =>Reset,
						clk =>Clk,
						PC_out =>Instr_address);

Decstage_1: DECSTAGE 
PORT MAP(  Instr=> Instr_sig,
			  RF_WrEn=> RF_WrEn,
           ALU_out=> AluOut_sig,
           MEM_out => data_mem_out,
           RF_WrData_sel => RF_WrData_Sel,
           RF_B_sel => RF_B_Sel,
           ImmExt => ImmEx_DP,
           Clk => Clk,
           Immed => Immed_sig,
           RF_A => regRFA,
           RF_B => regRFB);
			  
			  			  			  
MemStage_1: MEMSTAGE
		Port map (  	ByteOp=>ByteOP_sig,
                		CLK => Clk,
							Mem_WrEn => MEM_WrEn,
							ALU_MEM_addr =>AluOut_sig,
							MEM_DataIn =>regRFB,
							MEM_DataOut =>data_mem_out,			  
			            MM_Addr => sigMM_Addr,
		               MM_WrEn => sigMM_WrEn,
				         MM_WrData => sigMM_WrData,
					      MM_RdData => sigMM_RdData);
			  
					  
EXSTAGE_1: EXSTAGE
	Port map( 	  RF_A =>regRFA,
						RF_B =>regRFB,
						Immed =>Immed_sig,
						ALU_Bin_sel =>ALU_Bin_Sel,
						ALU_func =>ALU_Func,
						ALU_out=> AluOut_sig,
						ALU_zero =>Zero);			  
			  
			  
			  
Instr_sig <=Instru;
ByteOP_sig<=Byte_OP_DP;
ImmEx_DP<=ImmExtu;
IfInstrAddr <= Instr_address;	
MM_Addr <= sigMM_Addr;
MM_WrEn <= sigMM_WrEn;
MM_WrData <= sigMM_WrData;
sigMM_RdData <= MM_RdDatau;  
			  
			  
			  
end Behavioral;

