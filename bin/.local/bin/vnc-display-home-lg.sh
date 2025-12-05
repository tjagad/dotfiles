#! /bin/bash

#xrandr -s 5120x2000
#xrandr -s 3840x1500
xrandr -s 2540x1010
xrandr --dpi 96

pushd >/dev/null $HOME/.config/alacritty/
ln -fs fhd-home-lg.yml size.yml
ln -fs fhd-home-lg.toml size.toml
touch alacritty.toml
popd >/dev/null
