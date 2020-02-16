//import ax12 library to send DYNAMIXEL commands
#include <ax12.h>
int D = 20;
void setup()
{
  Serial.begin(9600);
  start_position();
  delay(D);
}

void loop()
{
  int x_sensor = analogRead(A0);
  int y_sensor = analogRead(A1);
  x_sensor = map(x_sensor,0,1024,3096,1024);
  y_sensor = map(y_sensor,0,1024,0,2096);
  SetPosition(1, y_sensor);
  SetPosition(2, x_sensor);
  delay(D);
}

void start_position()
{
  SetPosition(1, 1024); //set the position of servo # 1 to '0'
  delay(D);//wait for servo to move
  SetPosition(2, 2048); //set the position of servo # 2 to '0'
}

