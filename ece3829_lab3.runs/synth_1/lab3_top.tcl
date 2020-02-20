# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.xpr} [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/Downloads/Debounce.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/imports/sources_1/imports/new/bcd7seg.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/dac_sawtooth.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/imports/new/decoder2to4.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/imports/new/my_counter.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/imports/sources_1/new/seven_seg.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/shift_register_16b.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/slowclk_100K.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/slowclk_1M.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/new/slowclock.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/vga_clk.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/vga_display.v}
  {C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/new/lab3_top.v}
}
read_vhdl -library xil_defaultlib {{C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/imports/ECE3829/vga_controller_640_60.vhd}}
read_ip -quiet {{C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/constrs_1/new/lab3_constraints.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Jeffrey Huang/Documents/WPI/2019-2020/C term/ECE3829/ece3829_lab3/ece3829_lab3.srcs/constrs_1/new/lab3_constraints.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top lab3_top -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef lab3_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file lab3_top_utilization_synth.rpt -pb lab3_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
