#!/usr/bin/python

# Ngonidzashe Mombeshora
# NotLog4j 
# Script to monitor and Log mobile network status, RSSI, throughput, etc
# write everthing to logs.txt


import serial
import time
ser = serial.Serial("/dev/ttyUSB2",115200)
import datetime
import re


dt = datetime.datetime.now()  

rec_buff = ''

print("----------------------------------------")
print("----------- starting... ----------------")
print("----------------------------------------")

def send_at(command,back,timeout):
        # print(command)
        rec_buff = ''
        ser.write((command+'\r\n').encode())
        time.sleep(timeout)
        if ser.inWaiting():
                time.sleep(0.01 )
                rec_buff = ser.read(ser.inWaiting())
        if back not in rec_buff.decode():  #if not OK then print error : except catches this and closes serial
                print(command + ' ERROR')
                print(command + ' back:\t' + rec_buff.decode())
                return 0
        else:  #if no error print response and log to logs.txt
                response = rec_buff.decode()
                return response
        


#function to write logs to logs.txt
#should be made for ease to convert to csv
#takes in key-value pairs
# function call example
# displayArgument(argument1 ="Geeks", argument2 = 4,argument3 ="Geeks")
def logger(argument0 ,*argument1, **argument2):
        f = open("loggs.txt", "a")
        f.write(str(dt))
        f.write(argument0)

        for arg in argument1:
                print(arg)
     
    # displaying non keyword arguments
        for arg in argument2.items():
                print(arg)
        f.close
        return
                
def get_RSSI():
        # query signal strength
        argz =  send_at('AT+CSQ','OK',1)
        split_argzs = re.split('[:,]',argz) #create list
        # logger(RSSI = argz)
        rssi_stats = split_argzs[0] + ":" + " RSSI:" + split_argzs[1] + " BER:" + split_argzs[2] 
        # print(stats)
        return rssi_stats
     


rssi_stats = get_RSSI()
logger(rssi_stats)

time.sleep(20)

print("...done")

# try:
        # send_at('AT+CSQ','OK',1) # query signal strength
#         # send_at('AT+CPSI?','OK',1)  #enquire UE system information
#         # send_at('AT+CNMP=2','OK',1)  #preferred mode selection 2: auto, 71:NR, 109:dual
#         # time.sleep(1)
#         # send_at('AT+COPS=?','OK',1) #search cells
#         time.sleep(20)
# except :
#         ser.close()


# 