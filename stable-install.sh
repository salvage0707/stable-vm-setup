#!/bin/bash -eu

on_error() {
    echo "[Err] ${BASH_SOURCE[1]}:${BASH_LINENO} - '${BASH_COMMAND}' failed">&2
}
trap on_error ERR

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

echo "CUDAのセットアップします"
sudo apt install -y --no-install-recommends google-perftools

echo "pythonのセットアップします"
apt -y install python3-venv python3-pip >> $log 2>&1
apt-get install -y python3-opencv >> $log 2>&1

echo "stable-baselines3のセットアップします"
cd ~
git clone  https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

echo "complete!"
