alias ghdl="/usr/local/opt/ghdl/bin/ghdl"

ghdl -a --ieee=synopsys -fexplicit --work=CombinationalTools CombinationalTools/decoder.vhd CombinationalTools/multiplexor.vhd CombinationalTools/BarrelShifter.vhd
ghdl -a --ieee=synopsys -fexplicit --work=SequentialTools SequentialTools/parallel_register.vhd

ghdl -a --ieee=synopsys -fexplicit -PCombinationalTools -PSequentialTools alu.vhd testBench_alu.vhd
ghdl -e --ieee=synopsys -fexplicit test
ghdl -r --ieee=synopsys -fexplicit test --wave=alu.ghw