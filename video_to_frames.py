import numpy as np
import cv2
import math

########Functions########
def ResizingWindow(x,y):
  cv2.namedWindow("output", cv2.WINDOW_NORMAL)
  cv2.resizeWindow("output", x, y)

def Automation():
  #PathVideo = raw_input("Please enter the video path: ")
  PathVideo = "C:\Users\hibrahex\Desktop\LatencyTest\C0031.MP4"
  
  vc = cv2.VideoCapture(PathVideo)
  ResizingWindow(600,400) #resizing showing windows
  font = cv2.FONT_HERSHEY_SIMPLEX
  
  c=1
  if vc.isOpened():
    rval , frame = vc.read() #read first frame
    maxList=[0]
    
  else:
    rval = False
  while rval:
  
    #Testing
    LeftBackCorner = [400,0]
    LeftHostCorner = [570,750]
    
    cropBack = frame[LeftBackCorner[1]:LeftBackCorner[1]+650,LeftBackCorner[0]:LeftBackCorner[0]+1050]
    cropLeft = frame[LeftHostCorner[1]:LeftHostCorner[1]+280,LeftHostCorner[0]:LeftHostCorner[0]+280] 
    cropRight = frame[LeftHostCorner[1]:LeftHostCorner[1]+280,LeftHostCorner[0]+330:LeftHostCorner[0]+610]
    
    #cv2.putText(cropBack, str(c), (20,80), font, 2,(0,0,255), 2, cv2.LINE_AA) 
    cv2.putText(cropLeft, str(c), (10,40), font, 0.8,(0,0,255), 1, cv2.LINE_AA)
    cv2.putText(cropRight, str(c), (10,40), font, 0.8,(0,0,255), 1, cv2.LINE_AA)

    hsvLeft = cv2.cvtColor(cropLeft, cv2.COLOR_BGR2HSV)
    hsvRight = cv2.cvtColor(cropRight, cv2.COLOR_BGR2HSV)

    lower_range = np.array([40, 50, 150], dtype=np.uint8) 
    upper_range = np.array([100, 160, 250], dtype=np.uint8)

    maskLeft = cv2.inRange(hsvLeft, lower_range, upper_range)
    maskRight = cv2.inRange(hsvRight, lower_range, upper_range)


    hsvblack=cv2.cvtColor(cropBack, cv2.COLOR_BGR2HSV)
    lowerblack=np.array([0, 40, 40],np.uint8)
    upperblack=np.array([50, 120, 120],np.uint8)
    separatedblack=cv2.inRange(hsvblack,lowerblack,upperblack)
    cv2.imshow('output',separatedblack)

    
    #drawing lines
    #cv2.line(cropBack,(21,528),(1017,528),(255,255,0),2)
    #i=0
    #for x in range(30):
    #  i = i + 6
    #  xx = int(519+499*math.cos(i*3.14159265359/-180))
    #  yy = int(528+499*math.sin(i*3.14159265359/-180))
    #  cv2.line(cropBack,(519,528),(xx,yy),(255,255,0),1)
      
    #cv2.line(cropLeft,(15,150),(285,146),(255,255,0),1)
    #i=0
    #for x in range(30):
    #  i = i + 6
    #  xx = int(150.5+135.5*math.cos(i*3.14159265359/-180))
    #  yy = int(148+135.5*math.sin(i*3.14159265359/-180))
    #  cv2.line(cropLeft,(150,148),(xx,yy),(255,255,0),1)

    #cv2.line(cropRight,(15,146),(285,141),(255,255,0),1)
    #i=0
    #for x in range(30):
    #  i = i + 6
    #  xx = int(150.5+135.5*math.cos(i*3.14159265359/-180))
    #  yy = int(143.5+135.5*math.sin(i*3.14159265359/-180))
    #  cv2.line(cropRight,(150,143),(xx,yy),(255,255,0),1)


    
    #cv2.imshow("output",cropBack)
    #cv2.imshow("output",cropLeft)
    #cv2.imshow("output",cropRight)
    #cv2.imshow('maskLeft',maskLeft)          
    #cv2.imshow('maskRight',maskRight)

    #check green
    countLeft = 0
    for i in maskLeft:
      for i2 in i:
        if i2>0:
          countLeft = countLeft + 1
 
    countRight = 0
    for i in maskRight:
      for i2 in i:
        if i2>0:
          countRight = countRight + 1
   
    #find lines in left clock
    if (countLeft==0):
      maxLeft=0
    elif (countLeft>maxLeft):
      maxLeft=countLeft
    else:
      if c!=(maxList[-1]+1) and c!=(maxList[-1]+2) and c!=(maxList[-1]+3) and maxLeft!=0:
        maxList.append(c)
        #print maxList
        #print countLeft
        #cv2.imshow("output",maskLeft)
        #cv2.imwrite("C:\Users\hibrahex\Desktop\LatencyTest\hosi\\" + str(c) + '.jpg',cropLeft)

        
    #find lines in right clock
    if (countRight==0):
      maxRight=0
    elif (countRight>maxRight):
      maxRight=countRight
    else:
      if c!=(maxList[-1]+1) and c!=(maxList[-1]+2) and c!=(maxList[-1]+3) and maxRight!=0:
        maxList.append(c)
        #print maxList
        #print countRight
        #cv2.imshow("output",cropRight)
        #cv2.imwrite("C:\Users\hibrahex\Desktop\LatencyTest\hosi\\" + str(c) + '.jpg',cropRight)


        
    print "c :", c, "\tLeft: ", countLeft, "\tRight: ", countRight
    
    #saving
    #cv2.imwrite("C:\Users\hibrahex\Desktop\LatencyTest\Back\\" + str(c) + '.jpg',cropBack)
    #if (countRight>countLeft):
    #  cv2.imwrite("C:\Users\hibrahex\Desktop\LatencyTest\Host\\" + str(c) + '.jpg',cropRight)
    #else:
    #  cv2.imwrite("C:\Users\hibrahex\Desktop\LatencyTest\Host\\" + str(c) + '.jpg',cropLeft)

    #Read new Frame
    rval, frame = vc.read()
    c = c + 1
    cv2.waitKey(1)
      
  vc.release()

Automation()

