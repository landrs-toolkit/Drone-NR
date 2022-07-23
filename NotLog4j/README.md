# NotLog4j
Named after the infamous Log4j, NotLog4j is a Celluar network logging and monitoring software.
Designed to run on all models of the Raspberry Pi equipped with the cellualar network PiHat.

In this case this [3G/4G/5G Pi Hat](https://www.waveshare.com/sim8200ea-m2-5g-hat.htm) equipped
 with SIM8200EA-M2 simcard module.

## What it does

This python script utilizes AT commands via the serial port to communicate to and from the Pi Hat and can be modified
to suit the users needs, depending on what needs to be monitored and logged.

Log files are written to logs#.txt in the same folder and as this script. # representing the experiment number.

Documentation for the list of AT commands can be found [here](https://www.waveshare.com/w/upload/1/17/SIM8200_Series_AT_Command_Manual_V1.00.01_0515.pdf)

## How to run

Simply:
```
$ python3 run.py
```

Currently the script is monitoring Cellular Network KPIs namely:
1. RSSI (Recieved Signal Strength Index)
2. BER (Bit Error Ratio)
3. ...

