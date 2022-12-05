#!/bin/bash

# Copyright Peter Burke 12/4/2018

# define functions first


function installstuff {
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Installing a whole bunch of packages..."

    start_time_installstuff="$(date -u +%s)"

    time sudo apt-get -y update # 1 min   #Update the list of packages in the software center                                   
    time sudo apt-get -y upgrade # 3.5 min
    # time sudo apt-get -y install screen # 0.5 min
    time sudo apt-get -y install tcptrack # 0 min
    time sudo apt-get -y install python  # 6 sec
    time sudo apt-get -y install python-wxgtk2.8 # 4 min 
    time sudo apt-get -y install python-matplotlib # 
    time sudo apt-get -y install python-opencv # 2 min
    time sudo apt-get -y install python-pip # 3 min
    time sudo apt-get -y install python-numpy  # 0 min
    time sudo apt-get -y install python-dev # 0 min
    time sudo apt-get -y install libxml2-dev # 1 min
    time sudo apt-get -y install libxslt-dev # 0.5 min
    time sudo apt-get -y install python-lxml # 0.75 min
    time sudo apt-get -y install python-setuptools # 0 min

    # Python 3 now                                                                                                                              
    time sudo apt-get -y install python3  # 6 sec                                                                                               
    time sudo apt-get -y install python3-matplotlib #                                                                                           
    time sudo apt-get -y install python3-opencv # 2 min                                                                                         
    time sudo apt-get -y install python3-pip # 3 min                                                                                            
    time sudo apt-get -y install python3-numpy  # 0 min                                                                                         
    time sudo apt-get -y install python3-dev # 0 min                                                                                            
    time sudo apt-get -y install python3-lxml # 0.75 min                                                                                        
    time sudo apt-get -y install python3-setuptools # 0 min                                                                                     
    time sudo apt-get -y install python3-genshi # 0 min                                                                                     
    time sudo apt-get -y install python3-lxml-dbg # 0 min                                                                                     
    time sudo apt-get -y install python-lxml-doc # 0 min                                                                                     
    # Done Python 3    

    time sudo apt-get -y install git # 1 min
    time sudo apt-get -y install dh-autoreconf # 1 min
    time sudo apt-get -y install systemd # 0 min
    time sudo apt-get -y install wget # 0 min
    time sudo apt-get -y install emacs # 4.5 min  (seems you have to run this twice)                                             
    time sudo apt-get -y install emacs # 0 min (seems you have to run this twice)                                             
    time sudo apt-get -y install nload # 0.5 min (network monitor, launch with nload -m)                                         
    time sudo apt-get -y install build-essential # 0 min
    time sudo apt-get -y install autossh # 0.5 min

    echo "Done installing a whole bunch of packages..."

    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "pip installing future, pymavlink, mavproxy..."
    time sudo pip install future # 1 min
    time sudo pip install pymavlink # 5.5 min
    time sudo pip install mavproxy # 4 min
    echo "Done pip installing future, pymavlink, mavproxy..."

    


    echo "pip3 installing future, pymavlink, mavproxy..."
    time sudo python3 -m pip install future # 1 min                                                                                                       
    time sudo python3 -m pip install pymavlink # 5.5 min                                                                                                  
    time sudo python3 -m pip install mavproxy # 4 min                                                                                                    
    echo "Done pip3 installing future, pymavlink, mavproxy..."



    end_time_installstuff="$(date -u +%s)"
    elapsed_installstuff="$(($end_time_installstuff-$start_time_installstuff))"
    echo "Total of $elapsed_installstuff seconds elapsed for installing packages"
    # 38 mins
    
    
}

function downloadandbuildmavlinkrouter {

    start_time_downloadandbuildmavlinkrouter="$(date -u +%s)"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Downloading git clone of mavlink-router..."
    #Download the git clone:                                                                                        

    git clone https://github.com/intel/mavlink-router.git
    cd mavlink-router
    sudo git submodule update --init --recursive

    echo "Done downloading git clone of mavlink-router..."

    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Start making / compiling / building mavlink-router..."

    sudo ./autogen.sh && sudo ./configure CFLAGS='-g -O2' --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib64 --prefix=/usr #--disable-systemd # needed for AWS linux                                                       

    #Make it                                                                                                        

    sudo make

    echo "Done making / compiling / building mavlink-router..."

    end_time_downloadandbuildmavlinkrouter="$(date -u +%s)"
    elapsed_downloadandbuildmavlinkrouter="$(($end_time_downloadandbuildmavlinkrouter-$start_time_downloadandbuildmavlinkrouter))"
    echo "Total of $elapsed_downloadandbuildmavlinkrouter seconds elapsed for downloading and building mavlink router"
    # 13 min

}


function downloadandbuildmavlinkrouterv2 {

    start_time_downloadandbuildmavlinkrouterv2="$(date -u +%s)"
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Downloading git clone of mavlink-router..."
    #Download the git clone:                                                                                        

    git clone https://github.com/intel/mavlink-router.git
    cd mavlink-router
    sudo git submodule update --init --recursive

    echo "Done downloading git clone of mavlink-router..."

    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Start making / compiling / building mavlink-router..."

   #  sudo ./autogen.sh && sudo ./configure CFLAGS='-g -O2' --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib64 --prefix=/usr --disable-systemd # needed for AWS linux                                                       

    sudo apt-get -y install git  ninja-build pkg-config gcc g++ systemd 

    sudo apt-get -y install python3-pip 
    time sudo python3 -m pip install meson 


    #Make it                                                                                                        
    sudo meson setup build .
    #sudo make mavlink router v1.0 used make, v 2.0 uses meson
    sudo ninja -C build
    sudo ninja -C build install

    echo "Done making / compiling / building mavlink-router..."

    end_time_downloadandbuildmavlinkrouterv2="$(date -u +%s)"
    elapsed_downloadandbuildmavlinkrouterv2="$(($end_time_downloadandbuildmavlinkrouter-$start_time_downloadandbuildmavlinkrouter))"
    echo "Total of $elapsed_downloadandbuildmavlinkrouter seconds elapsed for downloading and building mavlink router"
    # 13 min

}



# Check for any errors, quit if any
check_errors() {
  if ! [ $? = 0 ]
  then
    echo "An error occured! Aborting...."
    exit 1
  fi
}

function fxyz {
    echo "doing function fxyz"
}

function disablebluetoothforUART {

    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    echo "Disabling bluetooth using config.txt so UART works"
    echo "Appending to /boot/config.txt..."

    # If there is already a line delete it.
    sudo sed -i '/dtoverlay=pi3-disable-bt/d'  /boot/config.txt

    a="
    dtoverlay=pi3-disable-bt
    "
    sudo sh -c "echo '$a'>>/boot/config.txt"

    # Now clean up extra spaced lines:
    tmpfile=$(mktemp)
    sudo awk '!NF {if (++n <= 1) print; next}; {n=0;print}' /boot/config.txt > "$tmpfile" && sudo mv "$tmpfile" /boot/config.txt

    check_errors
    echo "Appended to /boot/config.txt"
    
}

function configuremavlinkrouter {
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Start configuring mavlink-router..."
    echo "It will connect to flight controller on /dev/AMA0"
    echo "It will serve up a mavlink stream on localhost port 5678 TCP"


    #Configure it                                                                                                   

    if [ ! -d "/etc/mavlink-router" ] 
    then
        echo "Directory /etc/mavlink-router does not exist yet. Making it." 
        sudo mkdir /etc/mavlink-router
        echo "Made /etc/mavlink-router" 
    fi

    cd /etc/mavlink-router
    # wget main.conf #  for mavlink-router configuration
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/main.conf -O /etc/mavlink-router/main.conf
    sudo chmod 777 main.conf
    echo "Done configuring mavlink-router..."

}

function downloadautostartscriptsformavlinkrouter {
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Now download the autostart scripts for mavlink-router"
    if [ ! -d "/home/pi/startupscripts" ] 
    then
        echo "Directory /home/pi/startupscripts does not exist yet. Making it." 
        sudo -u pi mkdir /home/pi/startupscripts
        echo "Made /home/pi/startupscripts" 
    fi
    cd /home/pi/startupscripts
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/autostart_mavlinkrouter.sh -O /home/pi/startupscripts/autostart_mavlinkrouter.sh
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/start_mavlinkrouter.sh  -O /home/pi/startupscripts/start_mavlinkrouter.sh
    echo "Did download the autostart scripts for mavlink-router"
    
}

function downloadautostartscriptsforAWSssh {
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Now download the autostart scripts for ssh to AWS"
    if [ ! -d "/home/pi/startupscripts" ] 
    then
        echo "Directory /home/pi/startupscripts does not exist yet. Making it." 
        sudo -u pi mkdir /home/pi/startupscripts
        echo "Made /home/pi/startupscripts" 
    fi
    cd /home/pi/startupscripts
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/autostart_sshtoAWS.sh -O /home/pi/startupscripts/autostart_sshtoAWS.sh 
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/start_sshtoAWS.sh -O /home/pi/startupscripts/start_sshtoAWS.sh 


    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/autostart_sshtoAWS_forterminal.sh -O /home/pi/startupscripts/autostart_sshtoAWS_forterminal.sh 
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/start_sshtoAWS_forterminal.sh -O /home/pi/startupscripts/start_sshtoAWS_forterminal.sh 

    echo "Did download the autostart scripts for sshtoAWS"

    sudo chmod 777 *.sh
    
}

function downloadServiceFilesforAWSssh {
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Now download the service files for ssh to AWS"
 
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/sshtoAWS.service -O /etc/systemd/system/sshtoAWS.service
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/sshtoAWSforterminal.service -O /etc/systemd/system/sshtoAWSforterminal.service
    # /etc/systemd/system is directory to put files into

    echo "Did download the service files for ssh to AWS"

    
}


function inputAWSIPaddress {
    read -p "To begin with the installation type in the EXACT IP address of the AWS instance for the ssh tunnel: " awsip

    echo "You entered:"
    echo $awsip

    read -p "If this is correct, enter "yes": " out

    if ! [ "$out" = "yes" ]
    then
        echo "You did not type in 'yes'. Exiting....AWS IP address not in yet. Please check documentation."
        exit 1
    fi
    
    
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    echo "Editing sshtoAWS.sh to put IP address in that you entered above."

    # awsip was entered above
    sed -i "s/AWSIPADDRESS/$awsip/g" /home/pi/startupscripts/start_sshtoAWS.sh
    sed -i "s/AWSIPADDRESS/$awsip/g" /home/pi/startupscripts/start_sshtoAWS_forterminal.sh

    
}


function inputAWSIPaddressAndInputIntoServiceFile {
    read -p "To begin with the installation type in the EXACT IP address of the AWS instance for the ssh tunnel: " awsip

    echo "You entered:"
    echo $awsip

    read -p "If this is correct, enter "yes": " out

    if ! [ "$out" = "yes" ]
    then
        echo "You did not type in 'yes'. Exiting....AWS IP address not in yet. Please check documentation."
        exit 1
    fi
    
    
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

    echo "Editing service files to put IP address in that you entered above."

    # awsip was entered above
    # sed -i "s/AWSIPADDRESS/$awsip/g" servicefile
    sed -i "s/AWSIPADDRESS/$awsip/g" /etc/systemd/system/sshtoAWS.service
    sed -i "s/AWSIPADDRESS/$awsip/g" /etc/systemd/system/sshtoAWSforterminal.service

    # new we also have to add it to known hosts 
    # ssh-keyscan /$awsip >> ~/.ssh/known_hosts # this doesn't work if known_hosts doesn't exist. To do: Fix this.
    # For now, manually ssh in to AWS from pi after install to make it work.

    
}




function editrclocal {

    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "Now downloading rc.local file from gitlab repo"
    wget https://gitlab.com/pjbca/4guav/raw/master/MavlinkRouterBuild/rc.local -O /etc/rc.local
    echo "Did download rc.local from gitlab repo"
    sudo chown root:root /etc/rc.local
    sudo chmod 777 /etc/rc.local
    echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

}




#***********************END OF FUNCTION DEFINITIONS******************************

set -x

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "This will install mavlink router and set it up for you."
echo "See README in 4guav gitlab repo for documentation."


echo "Starting..."

date


start_time="$(date -u +%s)"


disablebluetoothforUART

installstuff

#downloadandbuildmavlinkrouter
downloadandbuildmavlinkrouterv2
                                                            
configuremavlinkrouter

#enable the mavlink router service and start it
sudo systemctl enable mavlink-router
sudo systemctl start mavlink-router


#downloadautostartscriptsformavlinkrouter

#downloadautostartscriptsforAWSssh

#editrclocal

#inputAWSIPaddress
downloadServiceFilesforAWSssh
inputAWSIPaddressAndInputIntoServiceFile

#enable the ssh to AWS service and start it
sudo systemctl enable sshtoAWS
sudo systemctl start sshtoAWS
sudo systemctl enable sshtoAWSforterminal
sudo systemctl start sshtoAWSforterminal


date

end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for the entire process"


echo "Installation is complete. You will want to restart your Pi to make this work."
echo "No further action should be required. Closing..."


