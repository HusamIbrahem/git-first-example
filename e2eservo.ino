//import ax12 library to send DYNAMIXEL commands
#include <ax12.h>

const int DELAY1 = 5;
const int DELAY2 = 1;
const int NO_DELAY = 0;
const int zeroPos = 1024;

void setup() {
    // initialize serial:
    Serial.begin(9600);  
    resetPos();
}

void loop() {
    int incomingByte;
    // if there's any serial available, read it:
    if (Serial.available() > 0) {
        incomingByte = Serial.read();
        switch (incomingByte) {
            case 'a': rightLeftScene(); break;
            case 'b': upDownScene(); break;
            case 'c': shakeUpDown(); break;
            case 'd': shakeRightLeft(); break;
            case 'e': square(); break;
            case 'f': rotate(); break;
            case 'g': shakeBothWays(); break;
            case 'h': diagonal(zeroPos ,DELAY2); break;
        }
        resetPos();
    }  
}

void resetPos() {
    SetPosition(1,zeroPos); //set the position of servo #1
    SetPosition(2,zeroPos); //set the position of servo #2
    SetPosition(3,zeroPos); //set the position of servo #3
}

void moveRight(int from, int to, int sleep) {
    for(int i=from;i>to;i--) {
        SetPosition(1,i); //set the position of servo #1 to the current value of 'i'
        delay(sleep);//wait for servo to move
    }
} 

void moveLeft(int from, int to, int sleep) {
    for(int i=from;i<to;i++) {
        SetPosition(1,i); //set the position of servo #1 to the current value of 'i'
        delay(sleep);//wait for servo to move
    }
} 

void moveUp(int from, int to, int sleep) {
     for(int i=from;i<to;i++) {
        SetPosition(3,i); //set the position of servo #1 to the current value of 'i'
        delay(sleep);//wait for servo to move
     }
}

void moveDown(int from, int to, int sleep) {
     for(int i=from;i>to;i--) {
        SetPosition(3,i); //set the position of servo #1 to the current value of 'i'
        delay(sleep);//wait for servo to move
     }
}

void rightLeftScene() {
    moveLeft(zeroPos, 2048, DELAY1);
    moveRight(2048, zeroPos, DELAY1);
    moveRight(zeroPos, 0, DELAY1);
    moveLeft(0, zeroPos, DELAY1);
}

void upDownScene() {
    moveUp(zeroPos, 2048, DELAY1);
    moveDown(2048, zeroPos, DELAY1);
    moveDown(zeroPos, 0, DELAY1);
    moveUp(0, zeroPos, DELAY1);
}

void shakeUpDown() {
    moveUp(zeroPos, zeroPos + 100, DELAY2);  
    moveDown(zeroPos + 100, zeroPos, DELAY2);  
} 

void shakeRightLeft() {
    moveLeft(zeroPos, zeroPos + 100, DELAY2);  
    moveRight(zeroPos + 100, zeroPos, DELAY2);
} 

void square() {
    moveLeft(zeroPos, 2048, DELAY1);  
    moveUp(zeroPos, 1536, DELAY1);
    moveRight(2048, 0, DELAY1);  
    moveDown(1536, zeroPos, DELAY1);
    moveLeft(0, zeroPos, DELAY1); 
} 

void rotate() {
    moveUp(zeroPos, 2148, NO_DELAY);
    moveLeft(zeroPos, 4096, DELAY1); 
    moveRight(4096, zeroPos, DELAY1); 
} 

void shakeBothWays() {
    shakeUpDown();
    shakeRightLeft();
} 

void diagonal(int length, int sleep) {
    for(int i=length;i<length + 100;i++) {
        SetPosition(1,i); 
        SetPosition(2,i); 
        delay(sleep);//wait for servo to move
     }
     for(int i=length + 100;i>length;i--) {
        SetPosition(1,i); 
        SetPosition(2,i); 
        delay(sleep);//wait for servo to move
     }
     for(int i=length;i>length - 100;i--) {
        SetPosition(1,i); 
        SetPosition(2,i); 
        delay(sleep);//wait for servo to move
     }
     for(int i=length - 100;i<length;i++) {
        SetPosition(1,i);
        SetPosition(2,i); 
        delay(sleep);//wait for servo to move
     }
}
