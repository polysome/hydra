source "C:/Users/morpack/AppData/Local/Synplicity/scm_perforce.tcl"
history clear
project -load C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI.prj
project -run  -bg 
project -run  -bg 
set_option -job pr_1 -add par
set_option -job pr_1 -option enable_run 1
impl -add hydra_1 hydra -type fpga
set_option -result_file C:/Users/morpack/Documents/morpack_fpga/hydra/hydra_1/MasterSlave_TRI.edf
set_option -technology Spartan3
set_option -part XC3S5000
set_option -package FG676
set_option -write_verilog 1
project -run constraint_check -bg 
project -run  -bg 
impl -active hydra_1/pr_1
impl -active hydra/pr_1
impl -active hydra_1
impl -remove hydra_1
job pr_1 -name pr
project -run  -bg 
launch_xilinx_ise C:/Xilinx/12.2/ISE_DS/ISE/bin/nt64/ise.exe C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI
launch_xilinx_ise C:/Xilinx/12.2/ISE_DS/ISE/bin/nt64/ise.exe C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI
project -save C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI.prj 
project -close C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI.prj
project -load C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI.prj
project -close C:/Users/morpack/Documents/morpack_fpga/hydra/MasterSlave_TRI.prj
