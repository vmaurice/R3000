LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE bus_mux_pkg IS
	TYPE bus_mux_array IS ARRAY(NATURAL RANGE<>) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
END PACKAGE bus_mux_pkg;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.bus_mux_pkg.ALL;


ENTITY barrel_shifter IS
	GENERIC 
	(
		shift_size : INTEGER := 5;
		shifter_width : INTEGER := 32
	);
	PORT
	(
		input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		shift_amount : IN STD_LOGIC_VECTOR(shift_size-1 DOWNTO 0);
		LeftRight : IN STD_LOGIC;
		LogicArith : IN STD_LOGIC;
		ShiftRotate : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY barrel_shifter;



ARCHITECTURE barrel_shifter_arch of barrel_shifter IS

	signal pass : bus_mux_array(shift_size DOWNTO 0);

BEGIN


	pass(0) <= input;
	output <= pass(shift_size);

	barrel : for i in 0 to shift_size-1 generate
		
		pass(i+1) <= pass(i) when shift_amount(i) = '0' 
			else pass(i)((shifter_width - 2**i - 1) downto 0) & ((2**i - 1) downto 0 => '0') when ShiftRotate = '0' and LeftRight = '0'
			else ((2**i - 1) downto 0 => pass(i)(shifter_width - 1)) & pass(i)(shifter_width - 1 downto 2**i) when ShiftRotate = '0' and LeftRight = '1' and LogicArith = '0'
			else ((2**i - 1) downto 0 => '0') & pass(i)(shifter_width - 1 downto 2**i) when ShiftRotate = '0' and LeftRight = '1' and LogicArith = '1'
			else pass(i)((shifter_width - 2**i - 1) downto 0) & pass(i)(shifter_width - 1 downto (shifter_width - 2**i)) when ShiftRotate = '1' and LeftRight = '0'
			else pass(i)((2**i - 1) downto 0) & pass(i)(shifter_width - 1 downto 2**i);
					

	--		if ShiftRotate = 0 then
	--			if LeftRight = '0' then
	--				pass(i+1) <= pass(i)(shifter_width - 2**i - 1 downto 0) & ((2**i - 1) downto 0 => '0');
	--			else
	--				if LogicArith = '0' then
	--					pass(i + 1) <= ((2**i - 1) downto 0 => pas(i)(shifter_width - 1)) & pass(i)(shifter_width - 1 downto 2**i);
	--				else
	--					pass(i + 1) <= ((2**i - 1) downto 0 => '0') & pass(i)(shifter_width - 1 downto 2**i);
	--				end if;
	--			end if;
	--		else
	--			if LeftRight = '0' then
	--				pass(i + 1) <= pass(i)((shifter_width - 2**i - 1) downto 0) & pass(i)(shifter_width - 1 downto (shifter_width - 2**i));
	--			else
	--				pass(i + 1) <= pass(i)((2**i - 1) downto 0) & pass(i)(shifter_width - 1 downto 2**i);
	--			end if;
	--		end if;


	end generate ; -- barrel



END barrel_shifter_arch ; -- barrel_shifter_arch