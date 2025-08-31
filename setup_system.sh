cd /home/runner/work/zombie/zombie/

sudo apt-get update

sudo apt-get install -y transmission-cli
sudo apt install qemu
sudo apt-add-repository ppa:flexiondotorg/quickemu
sudo apt install quickemu

mkdir system
cd system

wget https://github.com/s-a-ng/zombie/raw/refs/heads/main/tiny-10-23-h2_archive.torrent
transmission-cli --exit tiny-10-23-h2_archive.torrent

qemu-img create -f qcow2 windows_vm.qcow2 50G
