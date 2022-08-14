#!/usr/bin/env/python3

# Ngonidzashe Mombshora
# NotLog4j 
# Script to monitor and Log mobile network status, RSSI, throughput, etc
# write everthing to logs.txt


import serial
import time
import datetime
import re
import iperf3


ser = serial.Serial("/dev/ttyUSB2",115200)
dt = datetime.datetime.now()  
rec_buff = ''
f = open("logged.txt", "a")
f.write("------------------------------------------------------------------------\n")


print("----------------------------------------")
print("----------- starting... ----------------")
print("----------------------------------------")

def send_at(command,back,timeout):
        """
        For sending serial command. Takes form Command, back i.e response and timeout
        """
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
        """
        Write logs to log file. Parameters to be given as Key value pairs.
        """
        print("Logging")
        dt = datetime.datetime.now()  

        f.write(str(dt) + " | ")
        
        f.write(argument0)

        for arg in argument1:
                print("arg1")
                print(arg)
     
    # displaying non keyword arguments
        for arg in argument2.items():
                print(arg)
                print("arg2")

        f.write('\n')
        f.close
        print("Done logging")
        return
                
def get_RSSI():
        """ 
        Query Relative Signal Strength Index i.e Signal quality
        pg 53
        Returns RSSI and Bit error ratio
        """
        print("Getting RSSI...")
        argz =  send_at('AT+CSQ','OK',1)
        split_argzs = re.split('[:,\r,\n]',argz) #create list
        print("split_args")
        print(split_argzs)
        # logger(RSSI = argz)
        rssi_stats = split_argzs[2] + ":" + " RSSI:" + split_argzs[3] + " BER:" + split_argzs[4] + " | "
        print(rssi_stats)
        print("Done getting RSSI")
        return rssi_stats
     


# rssi_stats = get_RSSI()
# print(rssi_stats)
# logger(rssi_stats)

# time.sleep(20)


while True:
        rssi_stats = get_RSSI()
        logger(rssi_stats)
        time.sleep(1)



# --------------------------------------------------------
# iperf3
# ----------------------------------------------------------





        
# print("...done")

# try:
#         send_at('AT+CSQ','OK',1) # query signal strength
#         # send_at('AT+CPSI?','OK',1)  #enquire UE system information
#         # send_at('AT+CNMP=2','OK',1)  #preferred mode selection 2: auto, 71:NR, 109:dual
#         # time.sleep(1)
#         # send_at('AT+COPS=?','OK',1) #search cells
#         time.sleep(20)
# except :
#         ser.close()
