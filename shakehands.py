import time
import serial

def movehands(shakehands_comment,shakehands_time):
	arduinoserial.write(shakehands_comment)
	time.sleep(shakehands_time)

def arduinoserialconnect():
	print "connecting to arduino"
	arduinoserial = serial.Serial('COM4',9600,timeout=1)
	time.sleep(8)
	arduinoserial.flush()

arduinoserialconnect()
movehands("shakehands",8)
print("finish1")
time.sleep(1)
movehands("sleep",4)
time.sleep(1)
movehands("shakehands",8)
time.sleep(1)
print("finish2")
movehands("sleep",4)
time.sleep(1)
arduinoserial.close()
print("exit")
time.sleep(10)

