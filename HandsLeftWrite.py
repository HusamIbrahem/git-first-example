import time
import serial

waitingtime=10
print "connecting to arduino"
arduino1 = serial.Serial('COM4',9600,timeout=1)
time.sleep(8)
arduino1.flush()
print "Startttt Moving"
arduino1.write("HandsLeftRight")
time.sleep(waitingtime)
print "exit"
time.sleep(3)
arduino1.write("Relax")
