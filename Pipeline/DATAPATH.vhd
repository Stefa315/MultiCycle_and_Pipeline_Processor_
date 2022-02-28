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
			  
			  forward_A : in STD_LOGIC_VECTOR(1 downto 0);
			  forward_B : in STD_LOGIC_VECTOR(1 downto 0);
			  
			  ALU_OUT_EXMEM : in std_logic_vector(31 downto 0);
			  MEM_OUT_MEMWB : in std_logic_vector(31 downto 0);
			  mux_a_decex_sel: in std_logic;
			  
			  ALU_Bin_sel_1:in STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
			  
			  
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end component EXSTAGE;


component MEM_WB is
		port ( ResetReset          : in std_logic;
				 clk          : in std_logic;
				 rd           : in std_logic_vector(4 downto 0);
				 ALU_OUT      : in  std_logic_vector(31 downto 0);
				 MEM_OUT      : in std_logic_vector(31 downto 0);
				 RF_WR_DATA_SEL: in std_logic;
				 RF_WR_EN     : in std_logic;
				 rd_out           : out std_logic_vector(4 downto 0);
				 ALU_OUT_out      : out  std_logic_vector(31 downto 0);
				 MEM_OUT_out      : out std_logic_vector(31 downto 0);
				 RF_WR_DATA_SEL_out: out std_logic;
				 RF_WR_EN_out     : out std_logic
				 );
end component;		 
				 
component IF_Dec_Reg is
    Port ( Reset 	  : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
			  we       : in std_logic;
           INST_IN  : in  STD_LOGIC_VECTOR (31 downto 0);
           INST_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


component dec_ex is
		port ( Reset          : in std_logic;
				 clk          : in std_logic;
				 rfa          : in std_logic_vector(31 downto 0);
				 rfb          : in std_logic_vector(31 downto 0);	
				 rs           : in std_logic_vector(4 downto 0);
				 rt           : in std_logic_vector(4 downto 0);
				 rd           : in std_logic_vector(4 downto 0);
				 opcode       : in std_logic_vector(5 downto 0);
				 ALU_FUNC     : in std_logic_vector(3 downto 0);
				 RF_WR_DATA_SEL : in std_logic;
				 immed : in std_logic_vector(31 downto 0);
				 immed_out : out std_logic_vector(31 downto 0);
				 RF_WR_EN     : in std_logic;
				 MEM_WR_EN    : in std_logic;
				 ALU_BIN_SEL  : in std_logic;
				 mux_a_decex_sel: in std_logic;
				 mux_a_decex_sel_out: out std_logic;				 
				 ALU_BIN_SEL_out  : out std_logic;
				 RF_WR_DATA_SEL_out : out std_logic;
				 RF_WR_EN_out     : out std_logic;
				 MEM_WR_EN_out    : out std_logic;
				 rfa_out      : out std_logic_vector(31 downto 0);
				 rfb_out      : out std_logic_vector(31 downto 0);	
				 rs_out       : out std_logic_vector(4 downto 0);
				 rt_out       : out std_logic_vector(4 downto 0);
				 rd_out       : out std_logic_vector(4 downto 0);
				 opcode_out   : out std_logic_vector(5 downto 0);
				 ALU_FUNC_out : out std_logic_vector(3 downto 0));
				 
end component;


component Ex_Mem_Reg is
		port ( Reset          : in std_logic;
				 clk          : in std_logic;
				 rfb          : in std_logic_vector(31 downto 0);	
				 rd           : in std_logic_vector(4 downto 0);
				 RF_WR_DATA_SEL : in std_logic;
				 RF_WR_EN     : in std_logic;
				 alu_in : in std_logic_vector(31 downto 0);
				 alu_out : out std_logic_vector(31 downto 0);
				 MEM_WR_EN    : in std_logic;
				 RF_WR_DATA_SEL_out : out std_logic;
				 RF_WR_EN_out     : out std_logic;
				 MEM_WR_EN_out    : out std_logic;
				 rfb_out      : out std_logic_vector(31 downto 0);	
				 rd_out       : out std_logic_vector(4 downto 0));
				 
end component;

component IF_Dec_Reg is
    Port ( Reset 	  : in  STD_LOGIC;
           CLK      : in  STD_LOGIC;
			  we       : in std_logic;
           INST_IN  : in  STD_LOGIC_VECTOR (31 downto 0);
           INST_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Forward is
    Port ( pc_en : in  STD_LOGIC;
           rs_id_ex : in  STD_LOGIC_VECTOR (4 downto 0);
           rt_id_ex : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_ex_mem : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_mem_wb : in  STD_LOGIC_VECTOR (4 downto 0);
           ex_mem_en : in  STD_LOGIC;
           mem_wb_en : in  STD_LOGIC;
           muxA_sel : out  STD_LOGIC_VECTOR (1 downto 0);
           muxB_Sel : out  STD_LOGIC_VECTOR (1 downto 0));
end component;



component stall is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           rd_dec_ex : in  STD_LOGIC_VECTOR (4 downto 0);
           rs_if_dec : in  STD_LOGIC_VECTOR (4 downto 0);
           rt_if_dec : in  STD_LOGIC_VECTOR (4 downto 0); 
           pc_en : out  STD_LOGIC;
           if_id_en : out  STD_LOGIC);
end component;

signal  Instr_address,Instr_sig, Immed_sig, AluOut_sig,AluOut_sig_1 , ALUFunc,ALUFunc_1, regRFA, regRFB ,data_mem_out ,sigMM_WrData , sigMM_RdData: STD_LOGIC_VECTOR (31 downto 0);
signal WrData_sel,ImmEx_DP: STD_LOGIC_VECTOR (1 downto 0);
signal ByteOP_sig , sigMM_WrEn,MEM_WR_EN_SIGNAL,we_ifdec_signal,RF_WrEn_MEMWB_sig: STD_LOGIC;
signal sigMM_Addr ,sig_RFA,sig_RFB,rs_out_sig,rt_out_sig,rd_out_sig: STD_LOGIC_VECTOR (31 downto 0);


begin


IFstage_1: IFSTAGE
	Port map ( 	  PC_Immed =>Immed_sig,--
						PC_sel =>PC_Sel,--
						PC_LdEn =>PC_LdEn,--
						RESET =>Reset,--
						clk =>Clk,--
						PC_out =>Instr_address);--
ifdec : IF_Dec_Reg
		port map(Reset  => Reset,--
           CLK  => clk,--
			  we   => we_ifdec_signal,--
           INST_IN  => Instr_address,--
           INST_OUT => Instr_sig);			--			

Decstage_1: DECSTAGE 
PORT MAP(  Instr=> Instr_sig,--
			  RF_WrEn=> RF_WrEn_MEMWB_sig,
           ALU_out=> AluOut_sig,--
           MEM_out => data_mem_out,
           RF_WrData_sel => RF_WrData_Sel,
           RF_B_sel => RF_B_Sel,
           ImmExt => ImmEx_DP,
           Clk => Clk,
           Immed => Immed_sig,
           RF_A => regRFA,
           RF_B => regRFB);
			  
Dec_ex_1:  dec_ex 
		port map ( Reset => Reset,        
				 clk =>  clk ,  
				 rfa =>   regRFA ,     
				 rfb =>  regRFB ,      	
				 rs  =>  Instr_sig(25 downto 21),       
				 rt  =>  Instr_sig(15 downto 11),       
				 rd =>    Instr_sig(20 downto 16),      
				 opcode =>  Instr_sig(31 downto 26),    
				 ALU_FUNC =>   ALUFunc,    --syndesh me datapath 
				 RF_WR_DATA_SEL=> RF_WR_EN_Decex , 
				 immed => Immed_sig, --
				 immed_out=> Immed_sig_Decex , 
				 RF_WR_EN   =>  RF_WR_EN_Decex , 
				 MEM_WR_EN    =>  MEM_WR_EN_SIGNAL,
				 ALU_BIN_SEL  => ALU_BIN_SEL_Decex,
				 mux_a_decex_sel=> mux_a_decex_sel_control_Decex, --
				 mux_a_decex_sel_out	=>	mux_a_decex_sel_out_Decex,		 --
				 ALU_BIN_SEL_out  =>  ALU_BIN_SEL_out_Decex,--
				 RF_WR_DATA_SEL_out => RF_WR_DATA_SEL_out_Decex,--
				 RF_WR_EN_out     => RF_WR_EN_out_Decex,--
				 MEM_WR_EN_out    =>  MEM_WR_EN_out_Decex,--
				 rfa_out  =>  regRFA_decex,--
				 rfb_out =>   regRFB_decex,--
				 rs_out  =>   rs_out_sig,--
				 rt_out  =>   rt_out_sig ,--
				 rd_out  =>   rd_out_sig, --
				 opcode_out  => opcode_out_Decex, --
				 ALU_FUNC_out => AluFunc_1
				 );

exmem : Ex_Mem_Reg		
		port map( Reset     => Reset,  --
				 clk     => clk,     --
				 rfb    => regRFB_decex, 	--
				 rd     => rd_out_sig,  --
				 RF_WR_DATA_SEL => RF_WR_DATA_SEL_out_Decex,  --
				 RF_WR_EN      => RF_WR_EN_out_Decex, --
				 alu_in => AluOut_sig_1, --
				 alu_out => AluOut_sig,--
				 MEM_WR_EN    => MEM_WR_EN_out_Decex,--
				 RF_WR_DATA_SEL_out => RF_WrData_sel_signalEXMEM, --
				 RF_WR_EN_out      => rf_wren_sigEXMEM,  
				 MEM_WR_EN_out    => MEM_WR_EN_SIGNALEXMEM,
				 rfb_out   => RFB_OUTEXMEM,	
				 rd_out  => rd_outEXMEM);   



		  			  			  
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
emwb : MEM_WB
		port map( Reset   => Reset,
				 clk   => clk,
				 rd    => rd_outEXMEM, --gia forward
				 ALU_OUT  => sigMM_Addr,
				 MEM_OUT => data_mem_out,     
				 RF_WR_DATA_SEL => RF_WrData_sel_signalEXMEM, --
				 RF_WR_EN     => rf_wren_sigEXMEM,
				 rd_out       => rd_out_signalMEMWB,
				 ALU_OUT_out   => alu_out_out_signalMEMWB,
				 MEM_OUT_out    => MEM_out_out_signalMEMWB,
				 RF_WR_DATA_SEL_out => RF_WR_DATA_SEL_out_signalMEMWB,
				 RF_WR_EN_out    => RF_WR_EN_out_SIGNALMEMWB
				 );			  
					  
EXSTAGE_1: EXSTAGE
	Port map( 	  RF_A =>regRFA,
						RF_B =>regRFB,
						Immed =>Immed_sig,
						ALU_Bin_sel =>ALU_Bin_Sel,
						ALU_func =>ALUFunc_1,
						ALU_out=> AluOut_sig,
						ALU_zero =>Zero ,
						forward_A   => forward_A_sig,
				      forward_B   => forward_B_sig
						
						
						
						
						);			  

FW : forward
		port map(pc_en => pc_en_signal,
           rs_id_ex => rs_out_signal,
           rt_id_ex => rt_out_signal,
           rd_ex_mem => rd_outEXMEM,
           rd_mem_wb => rd_out_signalMEMWB,
           ex_mem_en => rf_wren_sigEXMEM,
           mem_wb_en => RF_WR_EN_out_SIGNALMEMWB,
           muxA_sel => forward_A_sig,
           muxB_Sel => forward_B_sig);
			  
ST : stall 
    Port map( clk => clk,
           Reset => Reset, 
			  opcode => Instr_sig(31 downto 26),
           rd_dec_ex => rd_out_signal,                  --- to rd apo dec_ex
           rs_if_dec => Instr_sig(25 downto 21),			-- to isntr apo if_dec
           rt_if_dec => Instr_sig(15 downto 11),  
           pc_en => pc_en_signal,
           if_id_en =>we_ifdec_signal);


RF_WrEn <= RF_WR_EN_Decex ;			  
ALU_bin_Sel <=	ALU_BIN_SEL_Decex;		  
ALU_Func<= ALUFunc;			  
Instr_sig <=Instru;
ByteOP_sig<=Byte_OP_DP;
ImmEx_DP<=ImmExtu;
IfInstrAddr <= Instr_address;	
MM_Addr <= sigMM_Addr;
MM_WrEn <= sigMM_WrEn;
MM_WrData <= sigMM_WrData;
MEM_OUT <= MM_RdDatau;  
			  
			  
			  
end Behavioral;

