sudo apt update
sudo apt install -y build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc
rm -rf /tmp/tmux
git clone https://github.com/tmux/tmux.git /tmp/tmux
cd /tmp/tmux
git checkout 3.2a
sh autogen.sh
./configure && make
sudo make install
