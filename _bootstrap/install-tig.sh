#!/bin/bash

# TODO If already installed, consider going to the git directory and updating

TIG_VERSION="${TIG_VERSION:-2.5.8}"

set +x
if type tig 2>/dev/null;
then
    echo "tig already installed"
else
    echo "Installing tig"
    pushd ~/Downloads
    wget "https://github.com/jonas/tig/releases/download/tig-${TIG_VERSION}/tig-${TIG_VERSION}.tar.gz"
    tar xzf tig-${TIG_VERSION}.tar.gz
    cd tig-${TIG_VERSION}
    make && make install
    cd ..
    rm tig-${TIG_VERSION}.tar.gz
    rm -r tig-${TIG_VERSION}/
    popd
fi
