#include <IRremote.h>  //---IR_mode---//
//#include <SoftwareSerial.h>  //---GSM---//
////---FIRE_SENSOR---//
//SoftwareSerial mySerial(9, 10);  //---GSM---//
//int sensor=A1;
//int Fire_alarm=5;
//float temp_read,Temp_alert_val,Temp_shut_val;
//int sms_count=0,Fire_Set;
//---IR_mode---//
int RECV_PIN = A0;
IRrecv irrecv(RECV_PIN);
decode_results results;
int ir_0;
int ir_1;
int ir_2;
int ir_3;
int ir_4;
int ir_5;
int ir_6;
int ir_7;
int ir_8;
int ir_9;
int ir_yes;
int ir_yesup;
int ir_yesdown;
int ir_yesleft;
int ir_yesright;
//---RGB_led_intity---//
int out_red=2;
int out_green=3;
int out_blow=4;
int state_rgb=0;
int red;
int green;
int blow;
int counter_rgb;
int steps=6;
//---BUTTONS---//
int button_1=22;
int button_2=24;
int button_3=26;
int button_4=28;
int button_5=30;
int button_6=32;
int button_7=34;
int button_8=36;
int buttonstate_1=0;
int buttonstate_2=0;
int buttonstate_3=0;
int buttonstate_4=0;
int buttonstate_5=0;
int buttonstate_6=0;
int buttonstate_7=0;
int buttonstate_8=0;
//---relays---//
int relay_1=23;
int relay_2=25;
int relay_3=27;
int relay_4=29;
int relay_5=31;
int relay_6=33;
int relay_7=35;
int relay_8=37;
int relaystate_1=0; 
int relaystate_2=0;
int relaystate_3=0;
int relaystate_4=0;
int relaystate_5=0;
int relaystate_6=0;
int relaystate_7=0;
int relaystate_8=0;
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
void setup() 
{
//  //---FIRE_SENSOR---//
//  pinMode(Fire_alarm,OUTPUT);
//  digitalWrite(Fire_alarm,LOW);
//  pinMode(sensor,INPUT);
//  mySerial.begin(9600);       
  //---rgb---//
  state_rgb=0;
  counter_rgb=1;
  pinMode(out_red,OUTPUT);
  pinMode(out_green,OUTPUT);
  pinMode(out_blow,OUTPUT);
  digitalWrite(out_red,LOW);
  digitalWrite(out_green,LOW);
  digitalWrite(out_blow,LOW);
  //---ir---//
  irrecv.enableIRIn(); // Start the receiver
  //---BUTTONS---//
  pinMode(button_1,INPUT);
  pinMode(button_2,INPUT);
  pinMode(button_3,INPUT);
  pinMode(button_4,INPUT);
  pinMode(button_5,INPUT);
  pinMode(button_6,INPUT);
  pinMode(button_7,INPUT);
  pinMode(button_8,INPUT);
  //---RELAYS---//
  pinMode(relay_1,OUTPUT);
  pinMode(relay_2,OUTPUT);
  pinMode(relay_3,OUTPUT);
  pinMode(relay_4,OUTPUT);
  pinMode(relay_5,OUTPUT);
  pinMode(relay_6,OUTPUT);
  pinMode(relay_7,OUTPUT);
  pinMode(relay_8,OUTPUT);
  relaystate_1=0;
  relaystate_2=0;
  relaystate_3=0;
  relaystate_4=0;
  relaystate_5=0;
  relaystate_6=0;
  relaystate_7=0;
  relaystate_8=0;
  Serial.begin(9600);  
}
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
////---FIRE_SENSOR---//
//void CheckFire()
//{
//  Temp_alert_val=CheckTemp();
//  if(Temp_alert_val>45)  SetAlert(); //send SMS Alerts
//}
//float CheckTemp() //Check_temperature
//{
//  temp_read=analogRead(sensor); // reads the sensor output (Vout of LM35)
//  temp_read=temp_read*5;    // converts the sensor reading to temperature
//  temp_read=temp_read/10;  // adds the decimal point
//  return temp_read; // returns temperature value in degree celsius
//}
//void SetAlert()  //Fire_Alarm_Enable
//{
//  while(sms_count<3) //Number of SMS Alerts to be sent 
//      SendTextMessage(); // Function to send AT Commands to GSM module
//  Fire_Set=1; 
//}
//void CheckShutDown()  //Fire_Alarm_Disable
//{
//  if(Fire_Set==1)
//  { digitalWrite(Fire_alarm,100);
//    Temp_shut_val=CheckTemp();
//    if(Temp_shut_val<28)
//    { digitalWrite(Fire_alarm,LOW);
//      sms_count=0;
//      Fire_Set=0;  }  }  
//}
//void SendTextMessage()  //Sms_Text_Massage_Send
//{
//  mySerial.println("AT+CMGF=1");    //To send SMS in Text Mode
//  delay(2000);
//  mySerial.println("AT+CMGS=\"+9720522984852\"\r"); // change to the phone number you using 
//  delay(2000);
//  mySerial.println("Fire in NEW ROOM!");//the content of the message
//  delay(200);
//  mySerial.println((char)26);//the stopping character  //ASCII code of CTRL+Z
//  delay(5000);
//  mySerial.println("AT+CMGS=\"+9720522984852\"\r"); // change to the phone number you using 
//  delay(2000);
//  mySerial.println("Fire in NEW ROOM!");//the content of the message
//  delay(200);
//  mySerial.println((char)26);//the message stopping character
//  delay(5000);
//  sms_count++;
//}
//---IR_FUNCTIONS---//
void check_ir_reciever()
{  if (results.value==0x213CCC33) ir_0=1;   
   if (results.value==0x213C0CF3) ir_1=1;       
   if (results.value==0x213C946B) ir_2=1;       
   if (results.value==0x213C9C63) ir_3=1; 
   if (results.value==0x213C14EB) ir_4=1;
   if (results.value==0x213C04FB) ir_5=1;
   if (results.value==0x213C1CE3) ir_6=1;
   if (results.value==0x213C4CB3) ir_7=1;
   if (results.value==0x213C54AB) ir_8=1;
   if (results.value==0x213C44BB) ir_9=1;
   if (results.value==0x213CC43B) ir_yes=1;
   if (results.value==0x213CD42B) ir_yesup=1;
   if (results.value==0x213C24DB) ir_yesdown=1;
   if (results.value==0x213C2CD3) ir_yesleft=1;
   if (results.value==0x213CDC23) ir_yesright=1;  }
void reset_ir_reciever()
{  ir_0=0,ir_1=0,ir_2=0,ir_3=0,ir_4=0,ir_5=0
   ,ir_6=0,ir_7=0,ir_8=0,ir_9=0,ir_yes=0,ir_yesup=0
   ,ir_yesdown=0,ir_yesleft=0,ir_yesright=0;  }
//---RGB_LED_CONTROLL_FUNCTIONS---//
void rgb_controller()
{  if (ir_yes==1)      //turn_on/off_light    
      { if(state_rgb==0){analogWrite(out_red,255);
                         analogWrite(out_green,255);
                         analogWrite(out_blow,255);
                         state_rgb=1; red=255; green=255; blow=255;}
      else{analogWrite(out_red,0);
           analogWrite(out_green,0);
           analogWrite(out_blow,0); 
           state_rgb=0; red=0; green=0; blow=0; counter_rgb=1;  }}
      
   if (ir_yesdown==1 && state_rgb==1)   //Decrease_rgb_bright 
      { if(red != 0){
          if(red-255/steps<0)analogWrite(out_red,red);
          else{red=red-255/steps; analogWrite(out_red,red);}}
        if(green != 0){
          if(green-255/steps<0)analogWrite(out_green,green);
          else{green=green-255/steps; analogWrite(out_green,green);}}
        if(blow != 0){
          if(blow-255/steps<0)analogWrite(out_blow,blow);
        else{blow=blow-255/steps; analogWrite(out_blow,blow);} }}
 
   if (ir_yesup==1 && state_rgb==1)     //Increase_rgb_bright    
      { if(red != 0){
          if((red+255/steps)>255)analogWrite(out_red,red);
          else{red=red+255/steps; analogWrite(out_red,red);}}
        if(green != 0){
          if(green+255/steps>255)analogWrite(out_green,green);
          else{green=green+255/steps; analogWrite(out_green,green);}}
        if(blow != 0){
          if(blow+255/steps>255)analogWrite(out_blow,blow);
          else{blow=blow+255/steps; analogWrite(out_blow,blow);} }}
      
   if (ir_yesright==1 && state_rgb==1)  //Next_color    
      {   if(counter_rgb==7) counter_rgb=0;
          counter_rgb++;
          color_case();  }
    
   if (ir_yesleft==1 && state_rgb==1)   //Pervit_color   
      {   if(counter_rgb==1) counter_rgb=8;
          counter_rgb--;
          color_case();  }         
}
void color_case()
{  switch(counter_rgb){
       case 1: red=255; green=255; blow=255; break;  //white 
       case 2: red=0;   green=0;   blow=255; break;  //blow
       case 3: red=0;   green=255; blow=0;   break;  //green
       case 4: red=0;   green=255; blow=255; break;  //bright_blow
       case 5: red=255; green=0;   blow=0;   break;  //red
       case 6: red=255; green=0;   blow=255; break;  //purble
       case 7: red=255; green=255; blow=0;   break;  //yellow
       } 
   analogWrite(out_red,red);
   analogWrite(out_green,green);
   analogWrite(out_blow,blow);  }
void print_rgb_states()
{   Serial.print('\n');
    Serial.print("red: ");
    Serial.print(red);
    Serial.print('\n');
    Serial.print("green: ");
    Serial.print(green);
    Serial.print('\n');
    Serial.print("blow: ");
    Serial.print(blow);
    Serial.print('\n');
    Serial.print("color: ");
    Serial.print(counter_rgb);
    Serial.print('\n');  }
//---BUTTONS---//
void read_buttons_states()
{  buttonstate_1= digitalRead(button_1);
   buttonstate_2= digitalRead(button_2);
   buttonstate_3= digitalRead(button_3);
   buttonstate_4= digitalRead(button_4);
   buttonstate_5= digitalRead(button_5);
   buttonstate_6= digitalRead(button_6);
   buttonstate_7= digitalRead(button_7);
   buttonstate_8= digitalRead(button_8);  }
//---RELAYS---//
void relays_controller()
{  if (buttonstate_1==HIGH || ir_1==1) // Relay_1_ON_OFF
    { if(relaystate_1==0){digitalWrite(relay_1,HIGH); relaystate_1=1;}
      else{digitalWrite(relay_1,LOW); relaystate_1=0;} }
      
   if (buttonstate_2==HIGH || ir_2==1) // Relay_2_ON_OFF     
    { if(relaystate_2==0){digitalWrite(relay_2,HIGH); relaystate_2=1;}
      else{digitalWrite(relay_2,LOW); relaystate_2=0;} }

   if (buttonstate_3==HIGH || ir_3==1) // Relay_3_ON_OFF   
    { if(relaystate_3==0){digitalWrite(relay_3,HIGH); relaystate_3=1;}
      else{digitalWrite(relay_3,LOW); relaystate_3=0;} }
   
   if (buttonstate_4==HIGH || ir_4==1) // Relay_4_ON_OFF     
    { if(relaystate_4==0){digitalWrite(relay_4,HIGH); relaystate_4=1;}
      else{digitalWrite(relay_4,LOW); relaystate_4=0;} }
   
   if (buttonstate_5==HIGH || ir_5==1) // Relay_5_ON_OFF      
    { if(relaystate_5==0){digitalWrite(relay_5,HIGH); relaystate_5=1;}
      else{digitalWrite(relay_5,LOW); relaystate_5=0;} }
   
   if (buttonstate_6==HIGH || ir_6==1) // Relay_6_ON_OFF     
    { if(relaystate_6==0){digitalWrite(relay_6,HIGH); relaystate_6=1;}
      else{digitalWrite(relay_6,LOW); relaystate_6=0;} }
    
   if (buttonstate_7==HIGH || ir_7==1) // Relay_7_ON_OFF     
    { if(relaystate_7==0){digitalWrite(relay_7,HIGH); relaystate_7=1;}
      else{digitalWrite(relay_7,LOW); relaystate_7=0;} }
    
   if (buttonstate_8==HIGH || ir_8==1) // Relay_8_ON_OFF     
    { if(relaystate_8==0){digitalWrite(relay_8,HIGH); relaystate_8=1;}
      else{digitalWrite(relay_8,LOW); relaystate_8=0;} }  }   
      
void print_realys_states()
{  Serial.print("relay_1:  ");
   Serial.print(relaystate_1);
   Serial.print('\n');
   Serial.print("relay_2:  ");
   Serial.print(relaystate_2);
   Serial.print('\n');
   Serial.print("relay_3:  ");
   Serial.print(relaystate_3);
   Serial.print('\n');
   Serial.print("relay_4:  ");
   Serial.print(relaystate_4);
   Serial.print('\n');
   Serial.print("relay_5:  ");
   Serial.print(relaystate_5);
   Serial.print('\n');
   Serial.print("relay_6:  ");
   Serial.print(relaystate_6);
   Serial.print('\n');
   Serial.print("relay_7:  ");
   Serial.print(relaystate_7);
   Serial.print('\n');
   Serial.print("relay_8:  ");
   Serial.print(relaystate_8);
   Serial.print('\n');  }
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
void loop() 
{ 
//  //---FIRE_SENSOR---//
//  CheckFire();
//  CheckShutDown(); 
  //--CONTROLL_RELAYS---//
  read_buttons_states();
  reset_ir_reciever();
  //---if_there_is_a_button_then_go_to_x---//  
  if (  buttonstate_1==HIGH || buttonstate_2==HIGH ||
        buttonstate_3==HIGH || buttonstate_4==HIGH ||
        buttonstate_5==HIGH || buttonstate_6==HIGH ||
        buttonstate_7==HIGH || buttonstate_8==HIGH  )
        {delay(300); goto x;}
  if (irrecv.decode(&results))
   {       
     Serial.println(results.value, HEX);  
     check_ir_reciever();  
     rgb_controller();
  x: print_rgb_states();
     relays_controller();
     print_realys_states(); 
     irrecv.resume();  // Receive the next value
   } 
  delay(50);
}
