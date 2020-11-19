LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY CombinationalTools;
USE CombinationalTools.bus_mux_pkg.ALL;
LIBRARY SequentialTools;
USE SequentialTools.ALL;

ENTITY CpMuxControler IS
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
END ENTITY CpMuxControler;

ARCHITECTURE CpMuxControler_arch of CpMuxControler IS

BEGIN

    CPSrc <=    (B_eq and Z) or (B_ne and not Z) or (B_lez and (N or Z)) or
                (B_gtz and not N and not Z) or (B_ltz_ltzAl_gez_gezAl and ( (N and not Z and not rt0) or ((not N or Z) and rt0) ));

END CpMuxControler_arch ; -- CpMuxControler_arch