#!/bin/bash

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
sudo apt-get install ~nros-foxy-rqt* -y


rosdep init
rosdep update 
rosdep fix-permissions 

echo HOME=${HOME}
apt-get autoclean


# 3
mkdir -p $HOME/ros2_ws/src && cd $HOME/ros2_ws/src 

# 소스코드 다운로드

cd $HOME/ros2_ws && colcon build --symlink-install

echo "source /opt/ros/foxy/setup.bash" >> $HOME/.bashrc
echo "source /$HOME/ros2_ws/install/setup.bash" >> $HOME/.bashrc
echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
echo "alias cw='cd ~/ros2_ws'" >> $HOME/.bashrc
echo "alias cs='cd ~/ros2_ws/src'" >> $HOME/.bashrc
echo "alias cb='cd ~/ros2_ws && colcon build --symlink-install'" >> $HOME/.bashrc
echo "alias cba='colcon build --symlink-install'" >> $HOME/.bashrc
echo "alias cbp='colcon build --symlink-install --packages-select'" >> $HOME/.bashrc
echo "alias cbu='colcon build --symlink-install --packages-up-to'" >> $HOME/.bashrc
echo "alias up='sudo apt-get update'" >> $HOME/.bashrc
echo "alias upup='sudo apt-get update && sudo apt-get -y upgrade'" >> $HOME/.bashrc
echo "alias install='sudo apt-get -y install'" >> $HOME/.bashrc
echo "alias rdp='rosdep install --from-paths src --ignore-src -r -y'" >> $HOME/.bashrc

echo "alias eb='gedit ~/.bashrc'" >> $HOME/.bashrc
echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc


source /opt/ros/$ROS_DISTRO/setup.bash
source /$HOME/ros2_ws/install/setup.bash

IPADDR=$(hostname -I | cut -d' ' -f1)
echo "USER=$USER"
echo "HOME=$HOME"
echo "IPADDR=$IPADDR"
echo "ROS_ROOT=$ROS_ROOT"
echo "ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH"
echo "ROS_HOSTNAME=$ROS_HOSTNAME"
echo "ROS_MASTER_URI=$ROS_MASTER_URI"