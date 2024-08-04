onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xpm -L xbip_utils_v3_0_13 -L axi_utils_v2_0_9 -L c_reg_fd_v12_0_9 -L xbip_dsp48_wrapper_v3_0_6 -L xbip_pipe_v3_0_9 -L xbip_dsp48_addsub_v3_0_9 -L xbip_addsub_v3_0_9 -L c_addsub_v12_0_18 -L c_mux_bit_v12_0_9 -L c_shift_ram_v12_0_17 -L xbip_bram18k_v3_0_9 -L mult_gen_v12_0_21 -L cmpy_v6_0_24 -L floating_point_v7_0_23 -L xfft_v9_1_12 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.FFT0 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {FFT0.udo}

run 1000ns

quit -force
