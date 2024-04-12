#!/bin/bash



cat /etc/apt/sources.list
apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list
sed -i -e 's+\(^deb http://security.*\)+# \1+g' /etc/apt/sources.list
apt-get clean && apt-get update 


apt-get install -y \
    tmux \
    curl \
    wget \
    vim \
    git \
    sudo \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    mesa-utils \
    unzip \
    ntp \
    whois \
    sudo \
    net-tools \
    locales \
    ssh


locale-gen en_US.UTF-8
sudo apt-get install ros-melodic-rqt* -y 
sudo apt-get install python3 python3-pip python-rosinstall python-rosdep python-rosinstall-generator -y


rosdep init
rosdep update 
rosdep fix-permissions 

echo HOME=${HOME}
apt-get autoclean


# 3
mkdir -p $HOME/catkin_ws/src && cd $HOME/catkin_ws/src && catkin_init_workspace

# 소스코드 다운로드

cd $HOME/catkin_ws && catkin_make

echo "source /opt/ros/melodic/setup.bash" >> $HOME/.bashrc
echo "source /$HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
echo "alias cw='cd ~/catkin_ws'" >> $HOME/.bashrc
echo "alias cs='cd ~/catkin_ws/src'" >> $HOME/.bashrc
echo "alias cm='cd ~/catkin_ws && catkin_make'" >> $HOME/.bashrc
echo "alias up='sudo apt-get update'" >> $HOME/.bashrc
echo "alias upup='sudo apt-get update && sudo apt-get -y upgrade'" >> $HOME/.bashrc
echo "alias install='sudo apt-get -y install'" >> $HOME/.bashrc

echo "alias eb='gedit ~/.bashrc'" >> $HOME/.bashrc
echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc


source /opt/ros/$ROS_DISTRO/setup.bash
source /$HOME/catkin_ws/devel/setup.bash

IPADDR=$(hostname -I | cut -d' ' -f1)
echo "USER=$USER"
echo "HOME=$HOME"
echo "IPADDR=$IPADDR"
echo "ROS_ROOT=$ROS_ROOT"
echo "ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH"
echo "ROS_HOSTNAME=$ROS_HOSTNAME"
echo "ROS_MASTER_URI=$ROS_MASTER_URI"