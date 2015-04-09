#########################
###  DEFINE VARIABLES ###
#########################
set DesignName	"MasterSlave_TRI"
set FamilyName	"SPARTAN3"
set DeviceName	"xc3s5000"
set PackageName	"FG676"
set SpeedGrade	"-4"
set TopModule	"MasterSlave_TRI"
set EdifFile	"MasterSlave_TRI.edn"


if {![file exists $DesignName.ise]} {

project new $DesignName.ise

project set family $FamilyName
project set device $DeviceName
project set package $PackageName
project set speed $SpeedGrade

xfile add $EdifFile
if {[file exists synplicity.ucf]} {
    xfile add synplicity.ucf
}

project set "Netlist Translation Type" "Timestamp"
project set "Other NGDBuild Command Line Options" "-verbose"
project set "Generate Detailed MAP Report" TRUE

project close
}


file delete -force $DesignName\_xdb

project open $DesignName.ise

process run "Implement Design" -force rerun_all

project close

