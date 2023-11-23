#!/bin/bash

# install flutter-pi
sudo apt install cmake libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev ttf-mscorefonts-installer fontconfig libsystemd-dev libinput-dev libudev-dev  libxkbcommon-dev jq
sudo fc-cache

git clone https://github.com/ardera/flutter-pi
cd flutter-pi

mkdir build && cd build
cmake ..
make -j`nproc`

sudo make install

cd /home/pi
git clone https://github.com/misfit-studio/enter_tw_avatar_kiosk.git
sudo cp enter_tw_avatar_kiosk/bin/libspine_flutter.so /usr/lib