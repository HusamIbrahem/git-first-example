#include <ax12.h>
#include "poses.h"
#include <BioloidController.h>
BioloidController bioloid = BioloidController(1000000);
const int buttonPin = 0;
int buttonState = 0;
void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(0, INPUT);
  start_position();
}

void loop()
{
  // put your main code here, to run repeatedly:
  buttonState = digitalRead(buttonPin);
  if (buttonState == HIGH)
  {
    Serial.print("hi");
    MoveToPosition(P_0_2048, MovingSpeed);
    // SetPosition(2, 2048);
  }
  if (buttonState == LOW)
  {
    Serial.print("bi");
    MoveToPosition(P_0_3072, MovingSpeed);
    // SetPosition(2, 3072);
  }
}

void start_position()
{
  SetPosition(1, 0); // set the position of servo # 1 to '0'
  delay(50); // wait for servo to move
  SetPosition(2, 2048); // set the position of servo # 2 to '0'
}
