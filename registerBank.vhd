LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY CombinationalTools;
USE CombinationalTools.bus_mux_pkg.ALL;
USE CombinationalTools.ALL;
LIBRARY SequentialTools;
USE SequentialTools.ALL;


ENTITY RegisterBank IS
	PORT
	(
		source_register_0       : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_out_0              : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		source_register_1       : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_out_1              : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		destination_register    : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		data_in                 : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		write_register          : IN  STD_LOGIC;
		clk                     : IN  STD_LOGIC
	);
END ENTITY RegisterBank;


ARCHITECTURE RegisterBank_arch of RegisterBank IS

	COMPONENT decoder IS
		PORT (
			input : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT decoder;


	COMPONENT multiplexor IS
		PORT (
			input : IN bus_mux_array(31 DOWNTO 0);
			sel_input : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT multiplexor;


	COMPONENT parallel_register IS
		PORT (
			wr : IN STD_LOGIC;
			data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT parallel_register;

	signal dOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

	signal R : bus_mux_array(31 DOWNTO 0);
	signal tmp : STD_LOGIC;
	signal tmp2 : STD_LOGIC_VECTOR(31 DOWNTO 1);

BEGIN

-- Port and : CLK and EcrireReg
tmp <= '1' when rising_edge(clk) and write_register = '1' 
		else '0';


	-- Decoder
	decoder_inst0 : decoder
		PORT MAP(
			input => destination_register,
			output => dOut);

	-- RO = 0
	R(0) <= x"00000000";

	-- ParallelRegister : R1 à R31
	GEN_REG : FOR i in 1 to 31 generate
		tmp2(i) <= tmp and dOut(i);
		parallelregister_inst : parallel_register PORT MAP
			(
				wr => tmp2(i),
				data_in => data_in,
				data_out => R(i));
	end generate GEN_REG;

	-- Multiplexeur sortie 1
	multiplexor_inst1 : multiplexor 
		PORT MAP(
			input => R,
			sel_input => source_register_0,
			output => data_out_0);

	-- Multiplexeur sortie 2
	multiplexor_inst2 : multiplexor 
		PORT MAP(
			input => R,
			sel_input => source_register_1,
			output => data_out_1);



END RegisterBank_arch ; -- RegisterBank_arch