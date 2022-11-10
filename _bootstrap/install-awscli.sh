#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
set +x

if type aws 2>/dev/null;
then
    echo "aws already installed"
else
    pushd ~/Downloads
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    popd
fi
