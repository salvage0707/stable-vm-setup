#!/bin/bash

# ログファイル
log=/var/log/stable-install/$(date '+%Y%m%d-%H%M%S').log

echo "ログファイルを作成します"
mkdir -p /var/log/stable-install
touch $log

echo "aptのセットアップします"
apt update >> $log 2>&1
apt -y install wget git python3 >> $log 2>&1

echo "GPUドライバのセットアップします"
curl https://raw.githubusercontent.com/GoogleCloudPlatform/compute-gpu-installation/main/linux/install_gpu_driver.py --output install_gpu_driver.py >> $log 2>&1
python3 install_gpu_driver.py >> $log 2>&1
ln -nfs /usr/bin/gcc-12 /usr/bin/gcc >> $log 2>&1
python3 install_gpu_driver.py  >> $log 2>&1

echo "pythonのセットアップします"
apt -y install python3-venv python3-pip >> $log 2>&1
apt-get install -y python3-opencv >> $log 2>&1

echo "stable-baselines3のセットアップします"
mkdir -p /var/stable/
cd /var/stable/
git clone  https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd ~

echo "complete!"
