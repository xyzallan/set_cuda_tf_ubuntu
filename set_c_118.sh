#!/bin/bash

# Värskendame pakettide nimekirja ja paigaldame olulised uuendused
sudo apt-get update -y
sudo apt-get upgrade -y

# Paigaldame vajalikud sõltuvused
sudo apt-get install -y build-essential dkms

# Lisame NVIDIA PPA
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt-get update -y

# Installime NVIDIA draiverid (siin paigaldame versiooni 510, seda saab muuta vastavalt vajadusele)
sudo apt-get install -y nvidia-driver-510

# Installime CUDA 11.8
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2204-11-8-local_11.8.0-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-11-8-local_11.8.0-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update -y
sudo apt-get install -y cuda

# Lisame CUDA keskkonnamuutujad
echo 'export PATH=/usr/local/cuda-11.8/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

# Installime cuDNN 8.x
CUDNN_VERSION=8.7.0.84
wget https://developer.download.nvidia.com/compute/cudnn/v8.7.0/local_installers/11.8/cudnn-local-repo-ubuntu2204-8.7.0.84_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu2204-8.7.0.84_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2204-8.7.0.84/cudnn-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update -y
sudo apt-get install -y libcudnn8 libcudnn8-dev

# Paigaldame Python'i ja vajalikud paketid
sudo apt-get install -y python3-dev python3-pip
pip3 install --upgrade pip

# Installime TensorFlow GPU versiooni
pip3 install tensorflow==2.12.0

# Kontrollime, kas TensorFlow tuvastab GPU
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

echo "Seadistamine on lõppenud. Palun taaskäivitage arvuti."
