# To Test dotfiles install script:
# $ docker build -t test/dotfiles .
#
# To see the state of the container:
# $ docker run -it <image>

FROM ubuntu:18.04
MAINTAINER Todd Tilby

# OS updates and installation
RUN apt update
RUN apt install git sudo software-properties-common locales locales-all -y
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt update
RUN sudo apt install python3.8 -y

# Create test user
RUN useradd -m tester
RUN usermod -aG sudo tester
RUN echo "tester    ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles
ADD . /home/tester/.dotfiles
RUN chown -R tester:tester /home/tester

USER tester
ENV HOME /home/tester
ENV XDG_CONFIG_HOME $HOME/.config

WORKDIR $HOME

# Set proper locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Needed to allow Docker to properly run AppImage files (e.g. nvim)
ENV APPIMAGE_EXTRACT_AND_RUN=1

# RUN cd $HOME && \
#     git clone https://github.com/ttilby/dotfiles -b dotbot $HOME/.dotfiles --depth 1

RUN cd $HOME/.dotfiles && ./install

# CMD ["/bin/bash"]
CMD ["/usr/bin/zsh"]
