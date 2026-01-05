#! /bin/bash

#xrandr -s 2880x1800
#xfconf-query -c xsettings -p /Xft/DPI -s 144
#xrandr --dpi 144
xrandr -s 1920x1100

pushd >/dev/null $HOME/.config/alacritty/
ln -fs hdpi-home-asus.yml size.yml
ln -fs hdpi-home-asus.toml size.toml
touch alacritty.toml
popd >/dev/null

pushd >/dev/null $HOME/.config/wezterm
echo "return 13" > font-size.lua
popd >/dev/null
