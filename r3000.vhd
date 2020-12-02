-- Standard libraries
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- User-defined libraries
LIBRARY CombinationalTools;
USE CombinationalTools.ALL;
USE CombinationalTools.bus_mux_pkg.ALL;
LIBRARY SequentialTools;
USE SequentialTools.ALL;



ENTITY R3000 IS
	PORT (
		CLK : IN STD_LOGIC;
		DMem_Abus, IMem_Abus : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		IMem_WR : IN STD_LOGIC;
		DMem_Dbus, IMem_Dbus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		DMem_WR : IN STD_LOGIC );
END ENTITY;

ARCHITECTURE R3000_arch of R3000 IS
 
	COMPONENT RegisterBank IS
	PORT (
		source_register_0       : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_out_0              : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		source_register_1       : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_out_1              : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		destination_register    : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_in                 : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		write_register          : IN  STD_LOGIC;
		clk                     : IN  STD_LOGIC
	);
	END COMPONENT RegisterBank;


	COMPONENT InstructionDecoder IS
		PORT
		(
			code_op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			func_code : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			Saut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			EcrireMem_W : OUT STD_LOGIC;
			EcrireMem_H : OUT STD_LOGIC;
			EcrireMem_B : OUT STD_LOGIC;
			LireMem_W : OUT STD_LOGIC;
			LireMem_UH : OUT STD_LOGIC;
			LireMem_UB : OUT STD_LOGIC;
			LireMem_SH : OUT STD_LOGIC;
			LireMem_SB : OUT STD_LOGIC;
			B_ltz_ltzAl_gez_gezAl : OUT STD_LOGIC;
			B_gtz : OUT STD_LOGIC;
			B_lez : OUT STD_LOGIC;
			B_ne : OUT STD_LOGIC;
			B_eq : OUT STD_LOGIC;
			UALOp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			UALSrc : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			EcrireReg : OUT STD_LOGIC;
			RegDst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			OpExt : OUT STD_LOGIC;
			MemVersReg : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT InstructionDecoder;

	COMPONENT CpMuxControler IS
		PORT
		(
			B_ltz_ltzAl_gez_gezAl : IN STD_LOGIC;
			B_gtz : IN STD_LOGIC;
			B_lez : IN STD_LOGIC;
			B_ne : IN STD_LOGIC;
			B_eq : IN STD_LOGIC;
			N : IN STD_LOGIC;
			Z : IN STD_LOGIC;
			rt0 : IN STD_LOGIC;
			CPSrc : OUT STD_LOGIC
		);
	END COMPONENT CpMuxControler;


	COMPONENT UALControler IS
	PORT
	(
		op : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		f : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		UALOp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Enable_V : OUT STD_LOGIC;
		Slt_Slti : OUT STD_LOGIC;
		Sel : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
	END COMPONENT UALControler;


	COMPONENT ALU IS
	PORT (
		A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Enable_V : IN STD_LOGIC;
		ValDec : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Slt : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		Res : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		N : OUT STD_LOGIC;
		Z : OUT STD_LOGIC;
		C : OUT STD_LOGIC;
		V : OUT STD_LOGIC
	);
	END COMPONENT ALU;

	COMPONENT Extension IS
		PORT
		(
			OpExt : IN STD_LOGIC;
			inst : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT Extension;

	COMPONENT SRAM_DPS IS
		PORT (
			address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
			data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
			WE, CS, OE, CLK : IN STD_LOGIC
		);
	END COMPONENT SRAM_DPS;


	signal inst, r_ext, rb1, rb2, rb_data, i2_Alu, res_Alu : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rd : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal r_Sel : STD_LOGIC_VECTOR(3 DOWNTO 0);
	signal r_Enable_V, r_Slt_Slti, r_N, r_Z, r_C, r_V, r_CPSrc : STD_LOGIC;

	-- instructionDecoder
	signal r_Saut, r_UALOp, r_UALSrc, r_RegDst, r_MemVersReg : STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal r_EcrireMem_W, r_EcrireMem_H, r_EcrireMem_B, r_LireMem_W, r_LireMem_UH, r_LireMem_UB, r_LireMem_SH, r_LireMem_SB : STD_LOGIC;
	signal r_B_ltz_ltzAl_gez_gezAl, r_B_gtz, r_B_lez, r_B_ne, r_B_eq, r_EcrireReg, r_OpExt : STD_LOGIC;


	-- SSRAM
	signal WE, OE : STD_LOGIC;

	BEGIN

	inst <= IMem_Dbus;

	-- instructionDecoder
	instructionDecoder_inst : instructionDecoder
		PORT MAP(
			code_op 					=> inst(31 DOWNTO 26),
			func_code 					=> inst(5 DOWNTO 0),
			Saut						=> r_Saut,
			EcrireMem_W					=> r_EcrireMem_W,
			EcrireMem_H					=> r_EcrireMem_H,
			EcrireMem_B					=> r_EcrireMem_B,
			LireMem_W					=> r_LireMem_W,
			LireMem_UH					=> r_LireMem_UH,
			LireMem_UB					=> r_LireMem_UB,
			LireMem_SH					=> r_LireMem_SH,
			LireMem_SB					=> r_LireMem_SB,
			B_ltz_ltzAl_gez_gezAl		=> r_B_ltz_ltzAl_gez_gezAl,
			B_gtz						=> r_B_gtz,
			B_lez						=> r_B_lez,
			B_ne						=> r_B_ne,
			B_eq						=> r_B_eq,
			UALOp						=> r_UALOp,
			UALSrc						=> r_UALSrc,
			EcrireReg					=> r_EcrireReg,
			RegDst						=> r_RegDst,
			OpExt						=> r_OpExt,
			MemVersReg					=> r_MemVersReg
		);


	-- Extension
	extension_inst : Extension
		PORT MAP(
			OpExt 	=> r_OpExt,
			inst 	=> inst(15 DOWNTO 0),
			output 	=> r_ext
		);



	rd <= inst(20 DOWNTO 16) when r_RegDst = "00"
			else inst(15 DOWNTO 11) when r_RegDst = "01"
			else "11111";

	rb_data <= DMem_Dbus when r_MemVersReg = "01"
			else res_Alu when r_MemVersReg = "00" 
			else res_Alu when r_MemVersReg = "10" and r_Saut = "10"
			else x"00000000";

	-- RegisterBank
	registerBank_inst : RegisterBank
		PORT MAP(
			source_register_0 		=> inst(25 DOWNTO 21),
			data_out_0 				=> rb1,
			source_register_1       => inst(20 DOWNTO 16),
			data_out_1              => rb2,
			destination_register    => rd,
			data_in                 => rb_data,
			write_register          => r_EcrireReg,
			clk 					=> CLK);

	
	-- UALControler
	aluControler_inst : UALControler
		PORT MAP(
			op			=> inst(31 DOWNTO 26),
			f			=> inst(5 DOWNTO 0),
			UALOp 		=> r_UALOp,
			Enable_V	=> r_Enable_V,
			Slt_Slti	=> r_Slt_Slti,
			Sel			=> r_Sel);


	-- Multiplexor ALU input 2
	i2_Alu <= rb2 when r_UALSrc = "00"
			else r_ext when r_UALSrc = "01"
			else x"00000000" when r_UALSrc = "10"
			else inst(15 DOWNTO 0) & x"0000";

	-- ALU 
	alu_inst : ALU
		PORT MAP(
			A 			=> rb1,
			B 			=> i2_Alu,
			sel 		=> r_sel,
			Enable_V 	=> r_Enable_V,
			ValDec		=> inst(10 DOWNTO 6),
			Slt 		=> r_Slt_Slti,
			CLK			=> CLK,
			Res			=> res_Alu,
			N			=> r_N,
			Z			=> r_Z,
			C			=> r_C,
			V			=> r_V
		);

	-- CpMuxControler
	CpMuxControler_inst : CpMuxControler
		PORT MAP(
			B_ltz_ltzAl_gez_gezAl	=> r_B_ltz_ltzAl_gez_gezAl,
			B_gtz					=> r_B_gtz,
			B_lez					=> r_B_lez,
			B_ne					=> r_B_ne,
			B_eq					=> r_B_eq,
			N						=> r_N,
			Z						=> r_Z,
			rt0						=> inst(16),
			CPSrc					=> r_CPSrc
		);

	WE <= '0' when r_EcrireMem_W = '1' or r_EcrireMem_H = '1' or r_EcrireMem_B = '1' else '1';
	OE <= '0' when r_LireMem_W = '1' or r_LireMem_UH = '1' or r_LireMem_UB = '1' or r_LireMem_SH = '1' or r_LireMem_SB = '1' else '1';

	-- SRAM
	sram_inst : SRAM_DPS
		PORT MAP(
				address 	=> res_Alu,
				data_in 	=> rb2,
				data_out 	=> DMem_Dbus,
				WE			=> WE, 
				CS			=> DMem_WR, 
				OE			=> OE,
				CLK			=> CLK
			);
	

END R3000_arch ; -- R3000_arch