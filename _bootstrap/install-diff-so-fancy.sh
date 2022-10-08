#!/bin/bash

rm -f ${HOME}/bin/diff-so-fancy
rm -rf ${HOME}/apps/diff-so-fancy
pushd ${HOME}/apps
git clone https://github.com/so-fancy/diff-so-fancy
ln -s ${HOME}/apps/diff-so-fancy/diff-so-fancy ${HOME}/bin/diff-so-fancy
popd
