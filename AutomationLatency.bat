@echo off
color 0a

:start
echo ----------------Root-------------------
adb root
echo ----------------Remount-------------------
adb remount
echo ----------------Remove_System_log-------------------
adb shell "setprop mmsd.log.priority “-“; stop mmd; start mmd;"
echo ----------------Lsmod-------------------
adb shell "insmod /lib/modules/socperf1_2.ko; insmod /lib/modules/socwatch2_0.ko; lsmod | grep soc;"

:Ask
echo -------------------------------------------------
echo ----------------Start_Analysis-------------------
echo -------------------------------------------------
echo 1_  PersonTracking
echo 2_  Cam2Api
echo 3_  CML
set /p input="press here: "

If %INPUT% EQU 1 goto :Ask1
If %INPUT% EQU 2 goto :Ask2
if %INPUT% EQU 3 goto :Ask3
goto Ask

:Ask1  
echo -------------------------------------------------
echo ----------------PersonTracking-------------------
echo -------------------------------------------------
echo 1_  Idle
echo 2_  StandByNoPerson
echo 3_  StandBySingle
echo 4_  StandByMulti
echo 5_  TrackingSingle
echo 6_  TrackingMulti
echo 7_  TrackingMultiAdvanced 
echo ----Other----
echo 8_  SarOutToTxt
echo 9_  PullSar
echo 10_ PullSocwatch
echo 11_ PullPT
echo 12_ DeleteSarFiles
echo 13_ DeleteSocwatchFiles
echo 14_ DeleteLogs
echo 15_ install_PersonTracking
echo 16_ back

set /p input="press here: "

If %INPUT% EQU 1 goto :Idle_PT
If %INPUT% EQU 2 goto :StandByNoPerson
If %INPUT% EQU 3 goto :StandBySingle
If %INPUT% EQU 4 goto :StandByMulti
If %INPUT% EQU 5 goto :TrackingSingle
If %INPUT% EQU 6 goto :TrackingMulti
If %INPUT% EQU 7 goto :TrackingMultiAdvanced
If %INPUT% EQU 8 goto :SarOutToTxt_PT
If %INPUT% EQU 9 goto :PullSar_PT
If %INPUT% EQU 10 goto :PullSocwatch_PT
If %INPUT% EQU 11 goto :Pulllogs_PT
If %INPUT% EQU 12 goto :DeleteSarFiles_PT
If %INPUT% EQU 13 goto :DeleteSocwatchFiles_PT
If %INPUT% EQU 14 goto :DeleteLogs_PT
If %INPUT% EQU 15 goto :install_PT
If %INPUT% EQU 16 goto :Ask
goto Ask1

:Idle_PT
echo ----------------Idle-------------------
timeout /t 5
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 10 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/Idle/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_Idle.out -A 1 40 > /dev/null;"
goto Ask1
:StandByNoPerson
echo ----------------StandByNoPerson-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/StandByNoPerson/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_StandByNoPerson.out -A 1 40 > /dev/null"
goto Ask1
:StandBySingle
echo ----------------StandBySingle-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f fx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/StandBySingle/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_StandBySingle.out -A 1 40 > /dev/null"
goto Ask1
:StandByMulti
echo ----------------StandByMulti-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/StandByMulti/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_StandByMulti.out -A 1 40 > /dev/null"
goto Ask1
:TrackingSingle
echo ----------------TrackingSingle-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/TrackingSingle/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_TrackingSingle.out -A 1 40 > /dev/null"
goto Ask1
:TrackingMulti
echo ----------------TrackingMulti-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/TrackingMulti/socwatch" 
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_TrackingMulti.out -A 1 40 > /dev/null"
goto Ask1
:TrackingMultiAdvanced
echo ----------------TrackingMultiAdvanced-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/TrackingMultiAdvanced/socwatch" 
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_TrackingMultiAdvanced.out -A 1 40 > /dev/null"
goto Ask1
:SarOutToTxt_PT
echo ----------------SarOutToTxt-------------------;
adb shell "cd data/sar; mkdir Idle; export PATH=$PWD; sar -f Sar_Idle.out -A > Idle/sar.txt;"
adb shell "cd data/sar; mkdir StandByNoPerson; export PATH=$PWD; sar -f Sar_StandByNoPerson.out -A > StandByNoPerson/sar.txt;"
adb shell "cd data/sar; mkdir StandBySingle; export PATH=$PWD; sar -f Sar_StandBySingle.out -A > StandBySingle/sar.txt;"
adb shell "cd data/sar; mkdir StandByMulti; export PATH=$PWD; sar -f Sar_StandByMulti.out -A > StandByMulti/sar.txt;"
adb shell "cd data/sar; mkdir TrackingSingle; export PATH=$PWD; sar -f Sar_TrackingSingle.out -A > TrackingSingle/sar.txt;"
adb shell "cd data/sar; mkdir TrackingMulti; export PATH=$PWD; sar -f Sar_TrackingMulti.out -A > TrackingMulti/sar.txt;"
adb shell "cd data/sar; mkdir TrackingMultiAdvanced; export PATH=$PWD;8 sar -f Sar_TrackingMultiAdvanced.out -A > TrackingMultiAdvanced/sar.txt;"
goto Ask1
:PullSar_PT
echo ----------------PullSar-------------------
adb pull /data/sar/Idle
adb pull /data/sar/StandByNoPerson
adb pull /data/sar/StandBySingle
adb pull /data/sar/StandByMulti
adb pull /data/sar/TrackingSingle
adb pull /data/sar/TrackingMulti
adb pull /data/sar/TrackingMultiAdvanced
goto Ask1
:PullSocwatch_PT
echo ----------------PullSocwatch-------------------
adb pull /data/socwatch/PersonTracking
goto Ask1
:Pulllogs_PT
echo ----------------PullPT-------------------
adb pull /sdcard/PT"
goto Ask1
:DeleteSarFiles_PT
echo ----------------DeleteSarFiles-------------------
adb shell "cd /data/sar; rm -r *.out; rm -r Idle; rm -r StandByNoPerson; rm -r StandBySingle; rm -r StandByMulti; rm -r TrackingSingle; rm -r TrackingMulti; rm -r TrackingMultiAdvanced;"
goto Ask1
:DeleteSocwatchFiles_PT
echo ----------------DeleteSocwatchFiles-------------------
adb shell "cd /data/socwatch; rm -r PersonTracking;"
goto Ask1
:DeleteLogs_PT
echo ----------------Deletelogs-------------------
adb shell "cd /sdcard/PT/; rm ;"
goto Ask1
:install_PT
echo ----------------Install_PersonTracking-------------------
adb install PersonTrackingPnPTool-debug.apk
goto Ask1





:Ask2  
echo -------------------------------------------------
echo ---------------------Cam2Api---------------------
echo -------------------------------------------------
echo 1_  Idle
echo 2_  DepthQvga_PcamVga
echo 3_  DepthQvga_Fish_Gyro_Accel
echo 4_  DepthQvga
echo 5_  DepthQvga_PcamQvga
echo 6_  DepthQvga_PcamQvga_Ds4ColorVga
echo ----Other----
echo 7_  SarOutToTxt
echo 8_  PullSar
echo 9_  PullSocwatch
echo 10_ Pulllogs
echo 11_ DeleteSarFiles
echo 12_ DeleteSocwatchFiles
echo 13_ DeleteLogs
echo 14_ Install_Cam2Api
echo 15_ back

set /p input="press here: "

If %INPUT% EQU 1 goto :Idle_Cam2Api
If %INPUT% EQU 2 goto :DepthQvga_PcamVga
If %INPUT% EQU 3 goto :DepthQvga_Fish_Gyro_Accel
If %INPUT% EQU 4 goto :DepthQvga
If %INPUT% EQU 5 goto :DepthQvga_PcamQvga
If %INPUT% EQU 6 goto :DepthQvga_PcamQvga_Ds4ColorVga
If %INPUT% EQU 7 goto :SarOutToTxt_Cam2Api
If %INPUT% EQU 8 goto :PullSar_Cam2Api
If %INPUT% EQU 9 goto :PullSocwatch_Cam2Api
If %INPUT% EQU 10 goto :Pulllogs_Cam2Api
If %INPUT% EQU 11 goto :DeleteSarFiles_Cam2Api
If %INPUT% EQU 12 goto :DeleteSocwatchFiles_Cam2Api
If %INPUT% EQU 13 goto :DeleteLogs_Cam2Api
If %INPUT% EQU 14 goto :Install_Cam2Api
If %INPUT% EQU 15 goto :Ask
goto Ask2

:Idle_Cam2Api
echo ----------------Idle-------------------
timeout /t 5
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 10 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./Cam2Api/Idle/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_Idle.out -A 1 40 > /dev/null;"
goto Ask2
:DepthQvga_PcamVga
echo ----------------DepthQvga_PcamVga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.cameraviewer/com.intel.cameraviewer.MainActivity -e live 80 -e render off -e depthres qvga -e pcres vga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./Cam2Api/DepthQvga_PcamVga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_PcamVga.out -A 1 40 > /dev/null"
goto Ask2
:DepthQvga_Fish_Gyro_Accel
echo ----------------DepthQvga_Fish_Gyro_Accel-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.cameraviewer/com.intel.cameraviewer.MainActivity -e live 80 -e render off -e depthres qvga -e fish on -e gyro on -e accel on
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./Cam2Api/DepthQvga_Fish_Gyro_Accel/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_Fish_Gyro_Accel.out -A 1 40 > /dev/null"
goto Ask2
:DepthQvga
echo ----------------DepthQvga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.cameraviewer/com.intel.cameraviewer.MainActivity -e live 80 -e render off -e depthres qvga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./Cam2Api/DepthQvga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga.out -A 1 40 > /dev/null"
goto Ask2
:DepthQvga_PcamQvga
echo ----------------DepthQvga_PcamQvga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.cameraviewer/com.intel.cameraviewer.MainActivity -e live 80 -e render off -e depthres qvga -e pcres qvga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./Cam2Api/DepthQvga_PcamQvga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_PcamQvga.out -A 1 40 > /dev/null"
goto Ask2
:DepthQvga_PcamQvga_Ds4ColorVga
echo ----------------DepthQvga_PcamQvga_Ds4ColorVga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.cameraviewer/com.intel.cameraviewer.MainActivity -e live 80 -e render off -e depthres qvga -e pcres qvga -e dsres vga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./Cam2Api/DepthQvga_PcamQvga_Ds4ColorVga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_PcamQvga_Ds4ColorVga.out -A 1 40 > /dev/null"
goto Ask2

:SarOutToTxt_Cam2Api
echo ----------------SarOutToTxt-------------------
adb shell "cd data/sar; mkdir Idle; export PATH=$PWD; sar -f Sar_Idle.out -A > Idle/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_PcamVga; export PATH=$PWD; sar -f Sar_DepthQvga_PcamVga.out -A > DepthQvga_PcamVga/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_Fish_Gyro_Accel; export PATH=$PWD; sar -f Sar_DepthQvga_Fish_Gyro_Accel.out -A > DepthQvga_Fish_Gyro_Accel/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga; export PATH=$PWD; sar -f Sar_DepthQvga.out -A > DepthQvga/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_PcamQvga; export PATH=$PWD; sar -f Sar_DepthQvga_PcamQvga.out -A > DepthQvga_PcamQvga/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_PcamQvga_Ds4ColorVga; export PATH=$PWD; sar -f Sar_DepthQvga_PcamQvga_Ds4ColorVga.out -A > DepthQvga_PcamQvga_Ds4ColorVga/sar.txt;"
goto Ask2
:PullSar_Cam2Api
echo ----------------PullSar-------------------
adb pull /data/sar/Idle
adb pull /data/sar/DepthQvga_PcamVga
adb pull /data/sar/DepthQvga_Fish_Gyro_Accel
adb pull /data/sar/DepthQvga
adb pull /data/sar/DepthQvga_PcamQvga
adb pull /data/sar/DepthQvga_PcamQvga_Ds4ColorVga
goto Ask2
:PullSocwatch_Cam2Api
echo ----------------PullSocwatch-------------------
adb pull /data/socwatch/Cam2Api
goto Ask2
:Pulllogs_Cam2Api
echo ----------------PullLogs-------------------
adb pull /sdcard/Cam2Api"
goto Ask2
:DeleteSarFiles_Cam2Api
echo ----------------DeleteSarFiles-------------------
adb shell "cd /data/sar; rm -r *.out; rm -r Idle; rm -r DepthQvga_PcamVga; rm -r DepthQvga_Fish_Gyro_Accel; rm -r DepthQvga; rm -r DepthQvga_PcamQvga; rm -r DepthQvga_PcamQvga_Ds4ColorVga;"
goto Ask2
:DeleteSocwatchFiles_Cam2Api
echo ----------------DeleteSocwatchFiles-------------------
adb shell "cd /data/socwatch; rm -r Cam2Api;"
goto Ask2
:DeleteLogs_Cam2Api
echo ----------------Deletelogs-------------------
adb shell "cd /sdcard/Cam2API/; rm ;"
goto Ask2
:Install_Cam2Api
echo ----------------Install_Cam2Api-------------------
adb install Cam2API_tool.apk
goto Ask2








:Ask3
echo -------------------------------------------------
echo ---------------------CML-------------------------
echo -------------------------------------------------
echo 1_  Idle
echo 2_  DepthQvga_PcamVga
echo 3_  DepthQvga_Fish_Gyro_Accel
echo 4_  DepthQvga
echo 5_  DepthQvga_PcamQvga
echo 6_  DepthQvga_PcamQvga_Ds4ColorVga
echo ----Other----
echo 7_  SarOutToTxt
echo 8_  PullSar
echo 9_  PullSocwatch
echo 10_ Pulllogs
echo 11_ DeleteSarFiles
echo 12_ DeleteSocwatchFiles
echo 13_ DeleteLogs
echo 14_ Install_CML
echo 15_ back

set /p input="press here: "

If %INPUT% EQU 1 goto :Idle_Cam2Api
If %INPUT% EQU 2 goto :DepthQvga_PcamVga
If %INPUT% EQU 3 goto :DepthQvga_Fish_Gyro_Accel
If %INPUT% EQU 4 goto :DepthQvga
If %INPUT% EQU 5 goto :DepthQvga_PcamQvga
If %INPUT% EQU 6 goto :DepthQvga_PcamQvga_Ds4ColorVga
If %INPUT% EQU 7 goto :SarOutToTxt_CML
If %INPUT% EQU 8 goto :PullSar_CML
If %INPUT% EQU 9 goto :PullSocwatch_CML
If %INPUT% EQU 10 goto :Pulllogs_CML
If %INPUT% EQU 11 goto :DeleteSarFiles_CML
If %INPUT% EQU 12 goto :DeleteSocwatchFiles_CML
If %INPUT% EQU 13 goto :DeleteLogs_CML
If %INPUT% EQU 14 goto :Install_CML
If %INPUT% EQU 15 goto :Ask
goto Ask3

:Idle_Cam2Api
echo ----------------Idle-------------------
timeout /t 5
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 10 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./CML/Idle/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_Idle.out -A 1 40 > /dev/null;"
goto Ask3
:DepthQvga_PcamVga
echo ----------------DepthQvga_PcamVga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.PnPmotioncamera/com.intel.sample.depth.PnPmotioncamera.StreamActivity -e live 80 -e depthres qvga -e pcres vga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./CML/DepthQvga_PcamVga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_PcamVga.out -A 1 40 > /dev/null"
goto Ask3
:DepthQvga_Fish_Gyro_Accel
echo ----------------DepthQvga_Fish_Gyro_Accel-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.PnPmotioncamera/com.intel.sample.depth.PnPmotioncamera.StreamActivity -e live 80 -e depthres qvga -e fish on -e gyro on -e accel on -e exp on
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./CML/DepthQvga_Fish_Gyro_Accel/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_Fish_Gyro_Accel.out -A 1 40 > /dev/null"
goto Ask3
:DepthQvga
echo ----------------DepthQvga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.PnPmotioncamera/com.intel.sample.depth.PnPmotioncamera.StreamActivity -e live 80 -e depthres qvga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./CML/DepthQvga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga.out -A 1 40 > /dev/null"
goto Ask3
:DepthQvga_PcamQvga
echo ----------------DepthQvga_PcamQvga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.PnPmotioncamera/com.intel.sample.depth.PnPmotioncamera.StreamActivity -e live 80 -e depthres qvga -e pcres qvga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./CML/DepthQvga_PcamQvga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_PcamQvga.out -A 1 40 > /dev/null"
goto Ask3
:DepthQvga_PcamQvga_Ds4ColorVga
echo ----------------DepthQvga_PcamQvga_Ds4ColorVga-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.PnPmotioncamera/com.intel.sample.depth.PnPmotioncamera.StreamActivity -e live 80 -e depthres qvga -e pcres qvga -e dsres vga
timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./CML/DepthQvga_PcamQvga_Ds4ColorVga/socwatch"
timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_DepthQvga_PcamQvga_Ds4ColorVga.out -A 1 40 > /dev/null"
goto Ask3

:SarOutToTxt_CML
echo ----------------SarOutToTxt-------------------
adb shell "cd data/sar; mkdir Idle; export PATH=$PWD; sar -f Sar_Idle.out -A > Idle/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_PcamVga; export PATH=$PWD; sar -f Sar_DepthQvga_PcamVga.out -A > DepthQvga_PcamVga/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_Fish_Gyro_Accel; export PATH=$PWD; sar -f Sar_DepthQvga_Fish_Gyro_Accel.out -A > DepthQvga_Fish_Gyro_Accel/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga; export PATH=$PWD; sar -f Sar_DepthQvga.out -A > DepthQvga/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_PcamQvga; export PATH=$PWD; sar -f Sar_DepthQvga_PcamQvga.out -A > DepthQvga_PcamQvga/sar.txt;"
adb shell "cd data/sar; mkdir DepthQvga_PcamQvga_Ds4ColorVga; export PATH=$PWD; sar -f Sar_DepthQvga_PcamQvga_Ds4ColorVga.out -A > DepthQvga_PcamQvga_Ds4ColorVga/sar.txt;"
goto Ask3
:PullSar_CML
echo ----------------PullSar-------------------
adb pull /data/sar/Idle
adb pull /data/sar/DepthQvga_PcamVga
adb pull /data/sar/DepthQvga_Fish_Gyro_Accel
adb pull /data/sar/DepthQvga
adb pull /data/sar/DepthQvga_PcamQvga
adb pull /data/sar/DepthQvga_PcamQvga_Ds4ColorVga
goto Ask3
:PullSocwatch_CML
echo ----------------PullSocwatch-------------------
adb pull /data/socwatch/CML
goto Ask3
:Pulllogs_CML
echo ----------------PullLogs-------------------
adb pull /sdcard/CML
goto Ask3
:DeleteSarFiles_CML
echo ----------------DeleteSarFiles-------------------
adb shell "cd /data/sar; rm -r *.out; rm -r Idle; rm -r DepthQvga_PcamVga; rm -r DepthQvga_Fish_Gyro_Accel; rm -r DepthQvga; rm -r DepthQvga_PcamQvga; rm -r DepthQvga_PcamQvga_Ds4ColorVga;"
goto Ask3
:DeleteSocwatchFiles_CML
echo ----------------DeleteSocwatchFiles-------------------
adb shell "cd /data/socwatch; rm -r CML;"
goto Ask3
:DeleteLogs_CML
echo ----------------Deletelogs-------------------
adb shell "cd /sdcard/CML/; rm ;"
goto Ask3
:Install_CML
echo ----------------Install_CML-------------------
adb install PnPStreamControllerSampleJava-debug.apk
goto Ask3


