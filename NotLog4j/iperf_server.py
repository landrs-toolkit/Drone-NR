#!/usr/bin/env python3

import iperf3
import time
import datetime

server = iperf3.Server()
server.interval = 1
print('Running server: {0}:{1}'.format(server.bind_address, server.port))
f = open("downlink_iperf_server.txt", "a")
f.write("---------------------------------------------------------------------\n")

while True:
    dt = datetime.datetime.now()  

    result = server.run()

    if result.error:
        print(result.error)
    else:
        print('')
        print('Test results from {0}:{1}'.format(result.remote_host,result.remote_port))
        print('  MegaBytes per second (MB/s)  {0}'.format(result.received_MB_s) + str(dt))
        f.write(('  MegaBytes per second (MB/s)  {0}'.format(result.received_MB_s) + " | " + str(dt)) + "\n")
        print('')