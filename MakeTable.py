import csv
import sys
import os
import datetime

#CONFIGURATION
Maturity = 'Beta'
Active = 'Active'

NOSLAM =''
NOMMU = ''
NOPT = ''
NOOR = ''
NOCML = ''

FT_ABOVE = '>'
FT_UNDER = '<'
FT_SYMBOL = ''
Unit_Percent = '%'

FT_CPU_Utilization = '100'
TFR_CPU_Utilization = '100'

FT_CPU_Utilization_All = '25'
TFR_CPU_Utilization_All = '25'

FT_CPU_Utilization_AVG = '25'
TFR_CPU_Utilization_AVG = '25'

FT_CORE_CC0 = '25'
TFR_CORE_CC0 = '25'

FT_GRAPHICS_RC0 = '4'
TFR_GRAPHICS_RC0 = '4'

UNIT_CPU_Utilization = '%'

FT_FPS = '28'
TFR_FPS = '28'
UNIT_FPS = 'FPS'

FT_Fisheye = '28'
TFR_Fisheye = '28'
UNIT_Fisheye = 'FPS_Fisheye'

FT_Depth = '28'
TFR_Depth = '28'
UNIT_Depth = 'Unit_Depth'

FT_Gyroscope = '190'
TFR_Gyroscope = '190'
UNIT_Gyroscope = 'FPS_Gyro'

FT_Accelerometer = '230'
TFR_Accelerometer = '230'
UNIT_Accelerometer = 'FPS_Accel'

FT_Color = '28'
TFR_Color = '28'
UNIT_Color = 'FPS_Color'

FT_System_Power = '5'
TFR_System_Power = '5'
UNIT_System_Power = 'W'

FT_CORE_Temperature = '80'
TFR_CORE_Temperature = '80'
Temperature = u'\N{DEGREE SIGN}C'
UNIT_Temperature = Temperature.encode('utf-8')

FT_Context_Switch  = '2500'
TFR_Context_Switch  = '2500'
UNIT_Context_Switch  = 'cswch/s'

FT_Interrupt = '8000'
TFR_Interrupt = '8000'
UNIT_Interrupt = 'intr/'

FT_CORE_FREQUENCY = '8000'
TFR_CORE_FREQUENCY = '8000'
UNIT_CORE_FREQUENCY = 'MHz'

KPI_DESCRIPTION = ''

#VALUES
flagBand = False
flagTSM = False
flagCPU = False

folderSoc =''
folderSar = ''
folderFisheye =''
folderDepth = ''
folderFps =''
folderColor = ''
folderAccel =''
folderGyro = ''
folderGyro = ''
folderState = ''
folderMain = ''

KPI_Name = ''

avgCore = 0
count = 0
countCpu = 0

#Functions 
def getScore( tfr ,  score):
  if (isinstance(score, int)):
    tfr_temp = int(tfr)
    if(tfr_temp >score):
     return '>'
    elif(tfr_temp <score):
     return '<'
    else:
      return '='
    
  if (isinstance(score, float)):
    tfr_temp = float(tfr)
    if(tfr_temp >score):
     return '>'
    elif(tfr_temp <score):
     return '<'
    else:
      return '='
    
  if (isinstance(score, str)):
    tfr_temp = float(tfr)
    score_temp = float(score)
    if(tfr_temp >score_temp):
     return '>'
    elif(tfr_temp <score_temp):
     return '<'
    else:
      return '='
    


#INPUT
if(len (sys.argv))>1 :
 folderMain = sys.argv[1]
 KPI_Name = (sys.argv[1].rsplit('\\', 1)[-1])
 if(len (sys.argv))>2 :
  Active = sys.argv[2]
else:
 print"No Folder Path Was Given "
 sys.exit(0)
 

if("SLAM" in KPI_Name):
  NOSLAM = '_no'
if("MMU" in KPI_Name):
  NOMMU = '_no'
if("PT" in KPI_Name):
  NOPT = '_no'
if("OR" in KPI_Name):
  NOOR = '_no'
if("CML" in KPI_Name):
  NOCML = '_no'

  
#Getting The Name Of Each Data File
for s in os.listdir(folderMain):
  if 'Socwatch' in s or 'socwatch' in s:
            folderSoc = folderMain + "/"+ s
            continue
  if 'Sar.txt' in s or 'sar.txt' in s:
           folderSar = folderMain + "/"+ s
           continue
  if 'Fps' in s or 'fps' in s:
            folderFps = folderMain + "/"+ s
            continue
  if 'Fisheye' in s or 'fisheye' in s:
           folderFisheye = folderMain + "/"+ s
           continue
  if 'Gyro' in s or 'gyro' in s:
            folderGyro = folderMain + "/"+ s
            continue
  if 'Accel' in s or 'accel' in s:
           folderAccel = folderMain + "/"+ s
           continue
  if 'Color' in s or 'color' in s:
            folderColor = folderMain + "/"+ s
            continue
  if 'State_change' in s or 'State_Change' in s or 'state_shange' in s:
           folderState = folderMain + "/"+ s
           continue
  if 'Depth' in s or 'depth' in s:
            folderDepth = folderMain + "/"+ s
            continue
          

 
# Creating 2 Files One For PNP Team One For OnTrack
now = datetime.datetime.now()
with open ('PnP_Results_' + KPI_Name +str(now.year) + str(now.month) + str(now.day) + '.csv' , "wb") as PnPResult:
 writerPNPResults = csv.writer(PnPResult)
 writerPNPResults.writerow(["KPI_Name","KPI_Description","Maturity","Units","Final_Target","Target_For_Release","Sign","Score"]);

 KPI_Name = KPI_Name.replace("SLAM_","")
 KPI_Name = KPI_Name.replace("OR","")
 KPI_Name = KPI_Name.replace("PT","")
 
 if(os.path.isfile(folderFps)):
  with open(folderFps, 'rb') as Fep:
   reader1 = csv.reader(Fep)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Args:') :
              s ="".join(str(x) for x in row)
              s = s.replace(",","")
              #writer.writerow([s])
              KPI_DESCRIPTION = s
        if s.startswith('Average FPS:') :
            FT_SYMBOL = getScore(TFR_FPS, float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " -  Avg FPS_" + Active , KPI_DESCRIPTION  +NOSLAM+ NOCML + NOOR+NOMMU  , Maturity , UNIT_FPS , FT_FPS, TFR_FPS , FT_SYMBOL , float(s.split()[-1])])


  Fep.closed
 
#Reading The SocWatch File
 if(os.path.isfile(folderSoc)):
  with open(folderSoc, 'rb') as Soc:
    reader = csv.reader(Soc)
    for row in reader:
     if row:
        if 'PC0' in row[0]:
            score_str = row[1].replace("%","")
            FT_SYMBOL = getScore(TFR_Depth , score_str) 
            writerPNPResults.writerow([ KPI_Name+ " -"+ row[0]+ " - Package CState Residency Summary_" + Active , KPI_DESCRIPTION + NOSLAM + NOCML + NOOR+NOMMU +NOPT ,Maturity,UNIT_Depth,FT_Depth,TFR_Depth,FT_SYMBOL,score_str] )
            continue
          
        if 'CC0' in row[0]:
           for index, item in enumerate(row):
              row[index] = item.replace('%','')
              
           score_num = ( (float(row[1])+float(row[2])+float(row[3])+float(row[4])) /4  )
           FT_SYMBOL = getScore(TFR_CORE_CC0 , score_num) 
           writerPNPResults.writerow([ KPI_Name+ " -"+ row[0]+ "- Core CState Residency Summary_" + Active ,KPI_DESCRIPTION + NOCML ,Maturity, Unit_Percent,FT_CORE_CC0,TFR_CORE_CC0,FT_SYMBOL, score_num ])
           continue
          
        if 'RC0' in row[0]:
          FT_SYMBOL = getScore(TFR_GRAPHICS_RC0 , row[1].replace("%",""))
          writerPNPResults.writerow([ KPI_Name+ " -"+ row[0]+"- Graphics CState Residency Summary_" + Active, KPI_DESCRIPTION+ NOSLAM + NOCML + NOMMU +NOPT ,Maturity, Unit_Percent,FT_GRAPHICS_RC0,TFR_GRAPHICS_RC0,FT_SYMBOL,row[1]] )
        
        if 'Bandwidth' in row[0]:
            flagBand = True
            continue
          
        if 'Total' in row[0] and flagBand :
         # writer.writerow( ['Bandwidth (ddr-bw) Rate Summary  Total',row[2]] )
          flag = False
          
        if 'Thermal Sample Min' in row[0]:
          flagTSM = True
          continue
        
        if flagTSM :
         if 'Core_0' in row[0] or 'Core_1' in row[0] or 'Core_2' in row[0] :
          if('%' in row[3]):
           FT_SYMBOL = getScore(TFR_CORE_Temperature , row[3].replace("%",""))
          else:
           FT_SYMBOL = getScore(TFR_CORE_Temperature , row[3])
          writerPNPResults.writerow([ KPI_Name+ " -"+ row[0]+ "_"+Active , KPI_DESCRIPTION + NOSLAM + NOCML + NOOR+NOMMU +NOPT ,Maturity, UNIT_Temperature,FT_CORE_Temperature,TFR_CORE_Temperature ,FT_SYMBOL, row[3] ])
          avgCore +=  float(row[3])
         
         if 'Core_3' in row[0]:
          FT_SYMBOL = getScore(TFR_CORE_Temperature , row[3].replace("%",""))
          writerPNPResults.writerow([ KPI_Name+ " -"+ row[0]+ "_"+Active , KPI_DESCRIPTION+ NOSLAM + NOCML + NOOR+NOMMU +NOPT ,Maturity, UNIT_Temperature,FT_CORE_Temperature,TFR_CORE_Temperature ,FT_SYMBOL, row[3] ])
          avgCore +=  float(row[3])
          FT_SYMBOL = getScore(TFR_CORE_Temperature, avgCore/4) 
          writerPNPResults.writerow([ KPI_Name+ " - AVG. Core Temp_ "+ Active , KPI_DESCRIPTION + NOCML  ,Maturity, UNIT_Temperature,FT_CORE_Temperature,TFR_CORE_Temperature ,FT_SYMBOL, avgCore/4 ])
          flagTSM = False
        '''
        if 'SoC_DTS_0' in row[0]:
          writer.writerow( [row[0] + " - Thermal Sample Average",row[3]] )
        if 'SoC_DTS_1' in row[0]:
          writer.writerow( [row[0] + " - Thermal Sample Average",row[3]] )
        if 'FrontSkin' in row[0]:
          writer.writerow( [row[0] + " - Thermal Sample Average",row[3]] )
        if 'BackSkin' in row[0]:
          writer.writerow( [row[0] + " - Thermal Sample Average",row[3]] )
        '''
  Soc.closed
#########################################################################################################################################
#Reading The Sar File
 if(os.path.isfile(folderSar)):
  with open(folderSar, 'rb') as Sar:
   reader1 = csv.reader(Sar)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Average') and count ==5 :
            count+=1
            FT_SYMBOL = getScore(TFR_Context_Switch , float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name + " - Contact Switch_"+ Active , KPI_DESCRIPTION + NOSLAM + NOOR + NOMMU + NOPT , Maturity, UNIT_Context_Switch , FT_Context_Switch , TFR_Context_Switch , FT_SYMBOL , float(s.split()[-1])])
  
        if s.startswith('Average') and count <5 :
            FT_SYMBOL = getScore(TFR_CPU_Utilization , (s.split()[-1]))
            if(count==0):
             writerPNPResults.writerow([ KPI_Name+ " - ALL CPU Utilization_" + Active , KPI_DESCRIPTION, Maturity, UNIT_CPU_Utilization , FT_CPU_Utilization , TFR_CPU_Utilization , FT_SYMBOL , float(s.split()[-1])])
            else:
             writerPNPResults.writerow([ KPI_Name+ " - CPU Utilization_CORE" + s.split()[1]+"_"+ Active , KPI_DESCRIPTION + NOSLAM + NOCML + NOOR+NOMMU +NOPT, Maturity, UNIT_CPU_Utilization , FT_CPU_Utilization , TFR_CPU_Utilization , FT_SYMBOL , float(s.split()[-1])])
            count += 1
            
        if s.startswith('Average:          sum ') :
            FT_SYMBOL = getScore(TFR_Interrupt , (s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " - Interrupts_"+Active , KPI_DESCRIPTION + NOSLAM  + NOOR+NOMMU +NOPT, Maturity , UNIT_Interrupt , FT_Interrupt , TFR_Interrupt , FT_SYMBOL , (s.split()[-1])])
        
        if 'CPU' in row[0] and 'MHz' in row[0]:
            flagCPU = True
            continue
        
        if s.startswith('Average') and flagCPU and countCpu <5 :
            countCpu +=1
            if s.split()[1].startswith('all'):
             FT_SYMBOL = getScore(TFR_CORE_FREQUENCY , float(s.split()[-1]))
             writerPNPResults.writerow([ KPI_Name+ " - Core Frequency_" + Active, KPI_DESCRIPTION  + NOSLAM  + NOOR+NOMMU +NOPT, Maturity , UNIT_CORE_FREQUENCY , FT_CORE_FREQUENCY , TFR_CORE_FREQUENCY , FT_SYMBOL , float(s.split()[-1])])

  Sar.closed
  
 if(os.path.isfile(folderAccel)):
  with open(folderAccel, 'rb') as Ace:
   reader1 = csv.reader(Ace)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Average FPS:') :
            FT_SYMBOL = getScore(TFR_Accelerometer , float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " - Accelerometer FPS_"+ Active, KPI_DESCRIPTION + NOSLAM + NOCML + NOOR +NOPT, Maturity , UNIT_Accelerometer , FT_Accelerometer, TFR_Accelerometer , FT_SYMBOL , float(s.split()[-1])])
  Ace.closed
  
 if(os.path.isfile(folderColor)):
  with open(folderColor, 'rb') as Col:
   reader1 = csv.reader(Col)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Average FPS:') :
            FT_SYMBOL = getScore(TFR_Color , float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " - Color FPS_" + Active, KPI_DESCRIPTION + NOSLAM + NOCML + NOMMU , Maturity , UNIT_Color , FT_Color, TFR_Color , FT_SYMBOL , float(s.split()[-1])])
  Col.closed
  
 if(os.path.isfile(folderDepth)):
  with open(folderDepth, 'rb') as Dep:
   reader1 = csv.reader(Dep)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Average FPS:') :
            FT_SYMBOL = getScore(TFR_Depth , float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " - Depth FPS_" + Active, KPI_DESCRIPTION  + NOCML +NOMMU  , Maturity , UNIT_Depth , FT_Depth, TFR_Depth , FT_SYMBOL , float(s.split()[-1])])
  Dep.closed
  
  
 if(os.path.isfile(folderFisheye)):
  with open(folderFisheye, 'rb') as Fish:
   reader1 = csv.reader(Fish)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Average FPS:') :
            FT_SYMBOL = getScore(TFR_Fisheye , float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " - Fisheye FPS_" + Active, KPI_DESCRIPTION  + NOCML + NOOR +NOPT , Maturity , UNIT_Fisheye , FT_Fisheye, TFR_Fisheye , FT_SYMBOL , float(s.split()[-1])])
  Fish.closed
  
  
 if(os.path.isfile(folderGyro)):
  with open(folderGyro, 'rb') as Gyr:
   reader1 = csv.reader(Gyr)
   for row in reader1:
    if row:
        s = row[0]
        if s.startswith('Average FPS:') :
            FT_SYMBOL = getScore(TFR_Gyroscope , float(s.split()[-1]))
            writerPNPResults.writerow([ KPI_Name+ " - Gyroscope FPS_" +Active, KPI_DESCRIPTION + NOSLAM + NOCML + NOOR +NOPT , Maturity , UNIT_Gyroscope , FT_Gyroscope, TFR_Gyroscope , FT_SYMBOL , float(s.split()[-1])])

  Gyr.closed
  
 PnPResult.closed


 #for hosam only
names_new=['AVG. Core Temp_ Active', 'Core_0_Active', 'Core_1_Active', 'Core_2_Active', 'Core_3_Active', 'CC0', 'ALL CPU Utilization_Active', 'CPU Utilization_CORE0_Active', 'CPU Utilization_CORE1_Active', 'CPU Utilization_CORE2_Active', 'CPU Utilization_CORE3_Active', 'RC0', 'Contact Switch_Active', 'Interrupts_Active', 'Core Frequency_Active', 'Avg FPS_Active']
d={}
f = open('PnP_Results_' + KPI_Name +str(now.year) + str(now.month) + str(now.day) + '.csv' , "rb")
for line in f:
	bits = line.split(',')
	x = bits[0].split('-')
	y = bits[len(bits)-1]
	if len(x)>1:
		x = x[1].strip()
		y = y.strip()
		if "CPU Utilization" in x:
			y = 100 - float(y)
			y = "%.2f" %y
		d[x]=y
f.close()

print "\n",KPI_Name,":"
for name in names_new:
	if name in d.keys():
		print name, d[name]
	else:
		print name, "  No Data!!"
		
fo = open(str(now.year) + str(now.month) + str(now.day) + '.csv' , "a")
fo.write(',')
for name in names_new:
	fo.write('{0},'.format(name))
fo.write('\n')
fo.write(KPI_Name)
fo.write(',')
for name in names_new:
	if name in d.keys():
		number = d[name]
		fo.write('{0},'.format(number))
	else:
		fo.write(',')
fo.write('\n')
fo.write('\n')
fo.close()
