transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xpm
vlib activehdl/xbip_utils_v3_0_13
vlib activehdl/axi_utils_v2_0_9
vlib activehdl/c_reg_fd_v12_0_9
vlib activehdl/xbip_dsp48_wrapper_v3_0_6
vlib activehdl/xbip_pipe_v3_0_9
vlib activehdl/xbip_dsp48_addsub_v3_0_9
vlib activehdl/xbip_addsub_v3_0_9
vlib activehdl/c_addsub_v12_0_18
vlib activehdl/c_mux_bit_v12_0_9
vlib activehdl/c_shift_ram_v12_0_17
vlib activehdl/xbip_bram18k_v3_0_9
vlib activehdl/mult_gen_v12_0_21
vlib activehdl/cmpy_v6_0_24
vlib activehdl/floating_point_v7_0_23
vlib activehdl/xfft_v9_1_12
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xbip_utils_v3_0_13 activehdl/xbip_utils_v3_0_13
vmap axi_utils_v2_0_9 activehdl/axi_utils_v2_0_9
vmap c_reg_fd_v12_0_9 activehdl/c_reg_fd_v12_0_9
vmap xbip_dsp48_wrapper_v3_0_6 activehdl/xbip_dsp48_wrapper_v3_0_6
vmap xbip_pipe_v3_0_9 activehdl/xbip_pipe_v3_0_9
vmap xbip_dsp48_addsub_v3_0_9 activehdl/xbip_dsp48_addsub_v3_0_9
vmap xbip_addsub_v3_0_9 activehdl/xbip_addsub_v3_0_9
vmap c_addsub_v12_0_18 activehdl/c_addsub_v12_0_18
vmap c_mux_bit_v12_0_9 activehdl/c_mux_bit_v12_0_9
vmap c_shift_ram_v12_0_17 activehdl/c_shift_ram_v12_0_17
vmap xbip_bram18k_v3_0_9 activehdl/xbip_bram18k_v3_0_9
vmap mult_gen_v12_0_21 activehdl/mult_gen_v12_0_21
vmap cmpy_v6_0_24 activehdl/cmpy_v6_0_24
vmap floating_point_v7_0_23 activehdl/floating_point_v7_0_23
vmap xfft_v9_1_12 activehdl/xfft_v9_1_12
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 -l xpm -l xbip_utils_v3_0_13 -l axi_utils_v2_0_9 -l c_reg_fd_v12_0_9 -l xbip_dsp48_wrapper_v3_0_6 -l xbip_pipe_v3_0_9 -l xbip_dsp48_addsub_v3_0_9 -l xbip_addsub_v3_0_9 -l c_addsub_v12_0_18 -l c_mux_bit_v12_0_9 -l c_shift_ram_v12_0_17 -l xbip_bram18k_v3_0_9 -l mult_gen_v12_0_21 -l cmpy_v6_0_24 -l floating_point_v7_0_23 -l xfft_v9_1_12 -l xil_defaultlib \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xbip_utils_v3_0_13 -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_9 -93  \
"../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_9 -93  \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_6 -93  \
"../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_9 -93  \
"../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_addsub_v3_0_9 -93  \
"../../../ipstatic/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \

vcom -work xbip_addsub_v3_0_9 -93  \
"../../../ipstatic/hdl/xbip_addsub_v3_0_vh_rfs.vhd" \

vcom -work c_addsub_v12_0_18 -93  \
"../../../ipstatic/hdl/c_addsub_v12_0_vh_rfs.vhd" \

vcom -work c_mux_bit_v12_0_9 -93  \
"../../../ipstatic/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \

vcom -work c_shift_ram_v12_0_17 -93  \
"../../../ipstatic/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \

vcom -work xbip_bram18k_v3_0_9 -93  \
"../../../ipstatic/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_21 -93  \
"../../../ipstatic/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work cmpy_v6_0_24 -93  \
"../../../ipstatic/hdl/cmpy_v6_0_vh_rfs.vhd" \

vcom -work floating_point_v7_0_23 -93  \
"../../../ipstatic/hdl/floating_point_v7_0_vh_rfs.vhd" \

vcom -work xfft_v9_1_12 -2008  \
"../../../ipstatic/hdl/float_pkg.vhd" \
"../../../ipstatic/hdl/cfloat_pkg.vhd" \
"../../../ipstatic/hdl/DELAY.vhd" \
"../../../ipstatic/hdl/CDELAY.vhd" \
"../../../ipstatic/hdl/BDELAY.vhd" \
"../../../ipstatic/hdl/DS.vhd" \
"../../../ipstatic/hdl/CB.vhd" \
"../../../ipstatic/hdl/DSN.vhd" \
"../../../ipstatic/hdl/DSPFP32_GW.vhd" \
"../../../ipstatic/hdl/InputSwap.vhd" \
"../../../ipstatic/hdl/PARFFT2.vhd" \
"../../../ipstatic/hdl/PARFFT4.vhd" \
"../../../ipstatic/hdl/PARFFT.vhd" \
"../../../ipstatic/hdl/R2BUTTERFLY.vhd" \
"../../../ipstatic/hdl/R2TableFP32.vhd" \
"../../../ipstatic/hdl/R4BUTTERFLY.vhd" \
"../../../ipstatic/hdl/R4TableFP32.vhd" \
"../../../ipstatic/hdl/STAGE.vhd" \
"../../../ipstatic/hdl/SystolicFFT.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_core_ssr.vhd" \

vcom -work xfft_v9_1_12 -93  \
"../../../ipstatic/hdl/xfft_v9_1_viv_comp.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_comp.vhd" \
"../../../ipstatic/hdl/pkg.vhd" \
"../../../ipstatic/hdl/half_sincos_tw_table.vhd" \
"../../../ipstatic/hdl/quarter_sin_tw_table.vhd" \
"../../../ipstatic/hdl/quarter2_sin_tw_table.vhd" \
"../../../ipstatic/hdl/adder.vhd" \
"../../../ipstatic/hdl/adder_bypass.vhd" \
"../../../ipstatic/hdl/logic_gate.vhd" \
"../../../ipstatic/hdl/equ_rtl.vhd" \
"../../../ipstatic/hdl/cnt_sat.vhd" \
"../../../ipstatic/hdl/cnt_tc_rtl.vhd" \
"../../../ipstatic/hdl/cnt_tc_rtl_a.vhd" \
"../../../ipstatic/hdl/cnt_tc_rtl_b.vhd" \
"../../../ipstatic/hdl/shift_ram.vhd" \
"../../../ipstatic/hdl/srl_fifo.vhd" \
"../../../ipstatic/hdl/mux_bus2.vhd" \
"../../../ipstatic/hdl/mux_bus4.vhd" \
"../../../ipstatic/hdl/mux_bus8.vhd" \
"../../../ipstatic/hdl/mux_bus16.vhd" \
"../../../ipstatic/hdl/mux_bus32.vhd" \
"../../../ipstatic/hdl/dist_mem.vhd" \
"../../../ipstatic/hdl/dpm.vhd" \
"../../../ipstatic/hdl/dpm_hybrid.vhd" \
"../../../ipstatic/hdl/reg_rs_rtl.vhd" \
"../../../ipstatic/hdl/sub_byp.vhd" \
"../../../ipstatic/hdl/sub_byp_j.vhd" \
"../../../ipstatic/hdl/subtracter.vhd" \
"../../../ipstatic/hdl/xor_bit_gate.vhd" \
"../../../ipstatic/hdl/arith_shift1.vhd" \
"../../../ipstatic/hdl/arith_shift3.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_hybrid.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_bypass.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_bypass_hybrid.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_mul_j_bypass.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_mul_j_bypass_hybrid.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_simd.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_simd_bypass.vhd" \
"../../../ipstatic/hdl/butterfly_dsp48e_simd_mul_j_bypass.vhd" \
"../../../ipstatic/hdl/bf_dsp.vhd" \
"../../../ipstatic/hdl/bf_dsp_bypass.vhd" \
"../../../ipstatic/hdl/bf_dsp_mul_j_bypass.vhd" \
"../../../ipstatic/hdl/bfly_byp.vhd" \
"../../../ipstatic/hdl/bfly_byp_j.vhd" \
"../../../ipstatic/hdl/butterfly.vhd" \
"../../../ipstatic/hdl/twos_comp.vhd" \
"../../../ipstatic/hdl/cmpy.vhd" \
"../../../ipstatic/hdl/dfly_byp.vhd" \
"../../../ipstatic/hdl/dragonfly_dsp48_bypass.vhd" \
"../../../ipstatic/hdl/so_xk_counter.vhd" \
"../../../ipstatic/hdl/flow_control_b.vhd" \
"../../../ipstatic/hdl/flow_control_c.vhd" \
"../../../ipstatic/hdl/max2_2.vhd" \
"../../../ipstatic/hdl/in_ranger.vhd" \
"../../../ipstatic/hdl/in_switch4.vhd" \
"../../../ipstatic/hdl/out_addr_gen_b.vhd" \
"../../../ipstatic/hdl/out_switch4.vhd" \
"../../../ipstatic/hdl/overflow_gen.vhd" \
"../../../ipstatic/hdl/unbiased_round.vhd" \
"../../../ipstatic/hdl/pe4.vhd" \
"../../../ipstatic/hdl/r2_in_addr.vhd" \
"../../../ipstatic/hdl/r2_ovflo_gen.vhd" \
"../../../ipstatic/hdl/r2_pe.vhd" \
"../../../ipstatic/hdl/range_r2.vhd" \
"../../../ipstatic/hdl/r2_ranger.vhd" \
"../../../ipstatic/hdl/r2_rw_addr.vhd" \
"../../../ipstatic/hdl/r2_tw_addr.vhd" \
"../../../ipstatic/hdl/twgen_distmem.vhd" \
"../../../ipstatic/hdl/twgen_distmem_so.vhd" \
"../../../ipstatic/hdl/twgen_half_sincos.vhd" \
"../../../ipstatic/hdl/twgen_quarter_sin.vhd" \
"../../../ipstatic/hdl/twiddle_gen.vhd" \
"../../../ipstatic/hdl/r2_control.vhd" \
"../../../ipstatic/hdl/scale_logic.vhd" \
"../../../ipstatic/hdl/r2_datapath.vhd" \
"../../../ipstatic/hdl/rw_addr_gen_b.vhd" \
"../../../ipstatic/hdl/tw_gen_p2.vhd" \
"../../../ipstatic/hdl/tw_gen_p4.vhd" \
"../../../ipstatic/hdl/tw_addr_gen.vhd" \
"../../../ipstatic/hdl/r4_control.vhd" \
"../../../ipstatic/hdl/range_r4.vhd" \
"../../../ipstatic/hdl/r4_ranger.vhd" \
"../../../ipstatic/hdl/r4_datapath.vhd" \
"../../../ipstatic/hdl/r22_twos_comp_mux.vhd" \
"../../../ipstatic/hdl/r22_delay_mux.vhd" \
"../../../ipstatic/hdl/r22_srl_memory.vhd" \
"../../../ipstatic/hdl/r22_memory.vhd" \
"../../../ipstatic/hdl/r22_bfly_byp.vhd" \
"../../../ipstatic/hdl/r22_bf.vhd" \
"../../../ipstatic/hdl/r22_bf_sp.vhd" \
"../../../ipstatic/hdl/r22_cnt_ctrl.vhd" \
"../../../ipstatic/hdl/r22_flow_ctrl.vhd" \
"../../../ipstatic/hdl/r22_ovflo.vhd" \
"../../../ipstatic/hdl/r22_busy.vhd" \
"../../../ipstatic/hdl/r22_tw_gen.vhd" \
"../../../ipstatic/hdl/r22_pe.vhd" \
"../../../ipstatic/hdl/r22_right_shift.vhd" \
"../../../ipstatic/hdl/r22_shift_decode.vhd" \
"../../../ipstatic/hdl/r22_var_unbiased_round.vhd" \
"../../../ipstatic/hdl/so_n_counter.vhd" \
"../../../ipstatic/hdl/so_io_addr_gen.vhd" \
"../../../ipstatic/hdl/so_run_addr_gen_rotator.vhd" \
"../../../ipstatic/hdl/so_run_addr_gen_left_shift.vhd" \
"../../../ipstatic/hdl/so_run_addr_gen.vhd" \
"../../../ipstatic/hdl/so_addr_gen.vhd" \
"../../../ipstatic/hdl/so_control_fsm.vhd" \
"../../../ipstatic/hdl/so_control.vhd" \
"../../../ipstatic/hdl/so_memory.vhd" \
"../../../ipstatic/hdl/so_ranger.vhd" \
"../../../ipstatic/hdl/so_datapath.vhd" \
"../../../ipstatic/hdl/pipe_blank.vhd" \
"../../../ipstatic/hdl/fp_get_block_max_exp.vhd" \
"../../../ipstatic/hdl/fp_convert_to_block_fp.vhd" \
"../../../ipstatic/hdl/fp_convert_to_fp.vhd" \
"../../../ipstatic/hdl/fp_shift_ram_clr_op.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_axi_pkg.vhd" \
"../../../ipstatic/hdl/axi_wrapper_input_fifo.vhd" \
"../../../ipstatic/hdl/axi_wrapper_output_fifo.vhd" \
"../../../ipstatic/hdl/axi_wrapper.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_b.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_c.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_d.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_e.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_fp.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_core.vhd" \
"../../../ipstatic/hdl/xfft_v9_1_viv.vhd" \
"../../../ipstatic/hdl/xfft_v9_1.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../FMCW.gen/sources_1/ip/FFT0/sim/FFT0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

