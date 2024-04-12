# Ubuntu:latest는 20.04를 의미합니다.
FROM osrf/ros:foxy-desktop-focal


# apt로 패키지 받을 때 interative하게 사용하는 기능들을 끕니다. Docker에서 로그를 넘길 때 문제가 생길 수 있으므로 이 옵션은 필수입니다!
ARG DEBIAN_FRONTEND=noninteractive
ARG HOST_USER
ARG UNAME=${HOST_USER}
ARG UID=1000
ARG GID=1000
ARG HOME=/home/${UNAME}


#RUN xhost +local:docker

# clean up first
RUN apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list

# 필수 유틸리티 설치
RUN apt-get update && apt-get install -y \
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
    locales \
    ntp \
    whois \
    net-tools \
    sudo


RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  


RUN rosdep init
RUN apt-get install ~nros-foxy-rqt* -y

RUN mkdir -p /workspace && chmod -R +x /workspace

RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo,audio,video,plugdev -u ${UID} ${UNAME}
RUN mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} 

USER ${UNAME}
WORKDIR $HOME

RUN rosdep update 
RUN rosdep fix-permissions 

COPY init-foxy.sh ./

RUN cd /
