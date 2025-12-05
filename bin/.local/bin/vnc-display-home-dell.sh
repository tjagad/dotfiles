#! /bin/bash

xrandr -s 1912x1010
xrandr --dpi 96

pushd >/dev/null $HOME/.config/alacritty/
ln -fs fhd-home-dell.yml size.yml
ln -fs fhd-home-dell.toml size.toml
touch alacritty.toml
popd >/dev/null
