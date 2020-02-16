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
echo 1_  Idle
echo ----PersonTracking----
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

set /p input="press here: "

If %INPUT% EQU 1 goto :Idle
If %INPUT% EQU 2 goto :StandByNoPerson
If %INPUT% EQU 3 goto :StandBySingle
If %INPUT% EQU 4 goto :StandByMulti
If %INPUT% EQU 5 goto :TrackingSingle
If %INPUT% EQU 6 goto :TrackingMulti
If %INPUT% EQU 7 goto :TrackingMultiAdvanced
If %INPUT% EQU 8 goto :SarOutToTxt
If %INPUT% EQU 9 goto :PullSar
If %INPUT% EQU 10 goto :PullSocwatch
If %INPUT% EQU 11 goto :PullPT
If %INPUT% EQU 12 goto :DeleteSarFiles
If %INPUT% EQU 13 goto :DeleteSocwatchFiles
goto Ask

:Idle
echo ----------------Idle-------------------
timeout /t 5

start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 10 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/Idle/socwatch"

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_Idle.out -A 1 40 > /dev/null;"

goto Ask

:StandByNoPerson
echo ----------------StandByNoPerson-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off

timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/StandByNoPerson/socwatch"

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_StandByNoPerson.out -A 1 40 > /dev/null"

goto Ask

:StandBySingle
echo ----------------StandBySingle-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off

timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f fx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/StandBySingle/socwatch"

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_StandBySingle.out -A 1 40 > /dev/null"

goto Ask

:StandByMulti
echo ----------------StandByMulti-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off

timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/StandByMulti/socwatch"

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_StandByMulti.out -A 1 40 > /dev/null"

goto Ask

:TrackingSingle
echo ----------------TrackingSingle-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off

timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/TrackingSingle/socwatch"

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_TrackingSingle.out -A 1 40 > /dev/null"

goto Ask

:TrackingMulti
echo ----------------TrackingMulti-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off

timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/TrackingMulti/socwatch" 

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_TrackingMulti.out -A 1 40 > /dev/null"

goto Ask

:TrackingMultiAdvanced
echo ----------------TrackingMultiAdvanced-------------------
timeout /t 5
start cmd.exe /k adb shell am start -n com.intel.sample.depth.ptnativePnPTool/com.intel.sample.depth.ptnativePnPTool.MainActivity -e live 80 -e render on -e depthRes qvga -e PCMain on -e PCRes vga -e DS4color off -e tracking off

timeout /t 10
start cmd.exe /c adb shell "cd /data/socwatch; . ./setup_socwatch_env.sh; ./socwatch -t 60 -f gfx-cstate -f ddr-bw -f temp -f cpu-cstate -m -o ./PersonTracking/TrackingMultiAdvanced/socwatch" 

timeout /t 10
start cmd.exe /c adb shell "echo ---sar---; cd data/sar; export PATH=$PWD; sar -o ./Sar_TrackingMultiAdvanced.out -A 1 40 > /dev/null"

goto Ask





:SarOutToTxt
echo ----------------SarOutToTxt-------------------;
adb shell "cd data/sar; mkdir Idle; export PATH=$PWD; sar -f Sar_Idle.out -A > Idle/sar.txt;"
adb shell "cd data/sar; mkdir StandByNoPerson; export PATH=$PWD; sar -f Sar_StandByNoPerson.out -A > StandByNoPerson/sar.txt;"
adb shell "cd data/sar; mkdir StandBySingle; export PATH=$PWD; sar -f Sar_StandBySingle.out -A > StandBySingle/sar.txt;"
adb shell "cd data/sar; mkdir StandByMulti; export PATH=$PWD; sar -f Sar_StandByMulti.out -A > StandByMulti/sar.txt;"
adb shell "cd data/sar; mkdir TrackingSingle; export PATH=$PWD; sar -f Sar_TrackingSingle.out -A > TrackingSingle/sar.txt;"
adb shell "cd data/sar; mkdir TrackingMulti; export PATH=$PWD; sar -f Sar_TrackingMulti.out -A > TrackingMulti/sar.txt;"
adb shell "cd data/sar; mkdir TrackingMultiAdvanced; export PATH=$PWD;8 sar -f Sar_TrackingMultiAdvanced.out -A > TrackingMultiAdvanced/sar.txt;"
goto Ask

:PullSar
echo ----------------PullSar-------------------
adb pull /data/sar/Idle
adb pull /data/sar/StandByNoPerson
adb pull /data/sar/StandBySingle
adb pull /data/sar/StandByMulti
adb pull /data/sar/TrackingSingle
adb pull /data/sar/TrackingMulti
adb pull /data/sar/TrackingMultiAdvanced
goto Ask

:PullSocwatch
echo ----------------PullSocwatch-------------------
adb pull /data/socwatch/PersonTracking
goto Ask

:PullPT
echo ----------------PullPT-------------------
adb pull /sdcard/PT"
goto Ask

:DeleteSarFiles
echo ----------------DeleteSarFiles-------------------
adb shell "cd /data/sar; rm -r *.out; rm -r Idle; rm -r StandByNoPerson; rm -r StandBySingle; rm -r StandByMulti; rm -r TrackingSingle; rm -r TrackingMulti; rm -r TrackingMultiAdvanced;"
goto Ask

:DeleteSocwatchFiles
echo ----------------DeleteSocwatchFiles-------------------
adb shell "cd /data/socwatch; rm -r PersonTracking;"
goto Ask







