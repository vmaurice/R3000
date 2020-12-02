alias ghdl="/usr/local/opt/ghdl/bin/ghdl"

ghdl -a --ieee=synopsys -fexplicit --work=CombinationalTools CombinationalTools/decoder.vhd CombinationalTools/BarrelShifter.vhd CombinationalTools/multiplexor.vhd
ghdl -a --ieee=synopsys -fexplicit --work=SequentialTools SequentialTools/parallel_register.vhd SequentialTools/SRAM_DPS.vhd

ghdl -a --ieee=synopsys -fexplicit -PCombinationalTools -PSequentialTools alu.vhd adder.vhd CpMuxControler.vhd Extension.vhd instructionDecoder.vhd registerBank.vhd UALControler.vhd r3000.vhd testBench_r3000.vhd
ghdl -e --ieee=synopsys -fexplicit test
ghdl -r --ieee=synopsys -fexplicit test --wave=r3000.ghw
#ghdl -r --ieee=synopsys -fexplicit test --wave=registerbank.ghw