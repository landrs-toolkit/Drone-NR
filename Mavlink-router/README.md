# Mavlink-Router Setup : Cube Pilot PX4 -> RPi -> Ground Control Station : Communication over 5G mobile network. 

The Cube Pilot is connected to the Rpi via the usb and listed in `ls /dev` as `ttyACM0` or `ttySerial0` depending on Rpi version.
The other option for this connection is via the telemetry port on the Cube Pilot labelled `telem` to the Rpi UART. In this case 
the Cube pilot is seen as `ttyAMA0`.

## Installation
Install Mavlink-router as described in [Mavlink-router installation](https://github.com/mavlink-router/mavlink-router)

## How it works
**Raspberry Pi 3B+**

The main.conf file located in `/etc/mavlink-router/` contains the instructions for Mavlink router to transmit data to other end points.
If this file is not there after installing Mavlink-router it should be created. (Check the example in this folder.)

1. In this case a TCPserver is setup on port 5678.



2. Mavlink router is instructed to interface with the Cube pilot via the specified device name as labelled in `ls dev` at a specific Baud rate. This baud rate should be the same one as configured in the ground control station. i.e Mission Planner/ QGroundControl. 

3. The ip address and port of the client (Ground Control station) are to be specified. In this case it is 13.0.0.1 port 6789. 

This becomes useful when using a reverse SSH tunnel.

## How to run

Mavlink-router can be setup to run as run as a service and auto-start at boot. Check documentation here. It will automatically use the setting in main.conf file.

```
systemctl status mavlink-router.service

● mavlink-router.service - MAVLink Router
     Loaded: loaded (/lib/systemd/system/mavlink-router.service; enabled; vendor preset: e>
     Active: active (running) since Mon 2022-07-25 10:41:35 BST; 7s ago
   Main PID: 3620 (mavlink-routerd)
      Tasks: 1 (limit: 1598)
        CPU: 31ms
     CGroup: /system.slice/mavlink-router.service
             └─3620 /usr/bin/mavlink-routerd

Jul 25 10:41:35 raspberrypi systemd[1]: Started MAVLink Router.
Jul 25 10:41:35 raspberrypi mavlink-routerd[3620]: mavlink-router version v2-229-g022333d
Jul 25 10:41:35 raspberrypi mavlink-routerd[3620]: Opened UART [4]bravo: /dev/ttyACM0
Jul 25 10:41:35 raspberrypi mavlink-routerd[3620]: UART [4]bravo: speed = 921600
Jul 25 10:41:35 raspberrypi mavlink-routerd[3620]: UART [4]bravo: flowcontrol = enabled
Jul 25 10:41:35 raspberrypi mavlink-routerd[3620]: Opened TCP Client [6]delta: 13.0.0.1:67>
Jul 25 10:41:35 raspberrypi mavlink-routerd[3620]: Opened TCP Server [7] [::]:5678
Jul 25 10:41:36 raspberrypi mavlink-routerd[3620]: UART [4]bravo: Baudrate 921600 responde>
lines 1-17/17 (END)
```

Or Manually:
```
mavlink-routerd
```


Example output:
```
mavlink-router version v2-229-g022333d
Opened UART [4]bravo: /dev/ttyACM0
UART [4]bravo: speed = 921600
UART [4]bravo: flowcontrol = enabled
```

**N.B** 
When the PiHAT is connected to the RPi. A default IP route is automatically configured. Creating two IP routes, this causes confusion for the Pi when choosing route to use. The first default route is to be deleted, this should no be the default one as it is only the ethernet connection to the Pi. Hence:
```
sudo ip r d default via 10.42.0.1 dev eth0 proto dhcp src 10.42.0.48 metric 202
```

**Ground Control Station**
Mavlink Router is to be installed on the Ground Control Station as well. The TCP server opened when: 
```
mavlink-routerd
```
is run. will listen to the specific port to communicate with mission planner, and forwards this to the TCP server (IP and port specified)

Example output:
```
mavlink-router version v2-229-g022333d
Opened UDP Client [4]local 127.0.0.1:14550
Opened TCP Server [6] [::]6789 
```

**Reverse SSH:**
The PiHAT acts in similar fashion to a modem, hence it is to be considered a NATing device. The PiHAT will provide the Rpi with a local IP address. (Local to itself) meaning the Ground Control Station cannot access the RPi via the mobile network. Reverse SSH is the second option to work around this. (Other than the first one described above: which uses TCP servers) Doing the below rSSH command will ensure a two way communication channel from the Cube Pilot to the Ground control station via the RPi connected to mobile network.

Command:
```
ssh -N -R 5678:localhost:6789 scifly@13.0.0.1
```










