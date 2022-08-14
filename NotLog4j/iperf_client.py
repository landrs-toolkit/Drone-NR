#!/usr/bin/env python3

import iperf3
import time
import datetime

#might need to run pip3 install iperf3.

f = open("downlink_iperf_client.txt", "a")
f.write("--------------------------------------------------------\n")

while True:
    dt = datetime.datetime.now()

    client = iperf3.Client()
    client.duration = 1 # Measurement time [sec]
    client.server_hostname = '10.42.0.48' # Server's IP address
    # client.reverse                #unomment to perform reverse iperf test
    result = client.run()

    if result.error:
        print(result.error)
    else:
        print('')
        print('Test completed:')
        print('  started at         {0}'.format(result.time))

        print('  MegaBytes per second (MB/s)   {0}'.format(result.sent_MB_s))
        f.write('  MegaBytes per second (MB/s)  {0}'.format(result.sent_MB_s) + " | " + str(dt) + "\n")
    client = 0 #remove client instance
    time.sleep(1)