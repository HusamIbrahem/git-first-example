#include <ax12.h>
#include "poses.h"
#include <BioloidController.h>
BioloidController bioloid = BioloidController(1000000);

int DelayTime=10;
String DataFromPython;
int MovingSpeed=2000;

void setup() {
    Serial.begin(9600);
    MoveToPosition(P_0_2048,MovingSpeed);
}

void loop() {
  if (Serial.available()>=1){ DataFromPython = GetValuesFromPython(); }
  else{  
        if ( DataFromPython == "shakehands"){ MoveToPosition(P_0_1792,MovingSpeed);
                                              delay(DelayTime);
                                              MoveToPosition(P_0_2304,MovingSpeed);
                                              delay(DelayTime); } 
        if ( DataFromPython == "reset"){MoveToPosition(P_0_2048,MovingSpeed);}                                              
        if ( DataFromPython == "stop"){}                                       
      }
}

void MoveToPosition(const unsigned int *NextPose,int MovingTime)
{
  bioloid.loadPose(NextPose);   // load the pose from FLASH, into the nextPose buffer
  bioloid.readPose();
  bioloid.interpolateSetup(MovingTime); // setup for interpolation from current->next over 1/2 a second
  while(bioloid.interpolating > 0) // do this while we have not reached our new pose
  {  
      bioloid.interpolateStep();     // move servos, if necessary. 
      delay(3);
  }
}

String GetValuesFromPython()
{
  String data=Serial.readStringUntil('\n');
  return data;
}

