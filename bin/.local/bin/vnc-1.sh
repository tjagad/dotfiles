#! /bin/bash

vncserver -localhost no -depth 24 -geometry 1912x1010 :1
#vncserver -localhost no -depth 24 -geometry 1920x1140 :1
#vncserver -localhost no -depth 24 -geometry 1920x1200 :1

pushd >/dev/null $HOME/.config/alacritty/
ln -fs fhd-home-dell.yml size.yml
ln -fs fhd-home-dell.toml size.toml
touch alacritty.toml
popd >/dev/null

exit 0
