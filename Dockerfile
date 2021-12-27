FROM ubuntu:18.04
MAINTAINER Todd Tilby

# OS updates and installation
RUN apt update
RUN apt install git sudo python -y

# Create test user
RUN useradd -m tester
RUN usermod -aG sudo tester
RUN echo "tester    ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles
ADD . /home/tester/.dotfiles
RUN chown -R tester:tester /home/tester

USER tester
ENV HOME /home/tester

WORKDIR /home/tester/.dotfiles

RUN ./install

CMD ["/bin/bash"]
