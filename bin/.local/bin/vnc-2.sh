#! /bin/bash

#vncserver -localhost no -depth 24 -geometry 1920x2560 :3
vncserver -localhost no -depth 24 -geometry 1912x1010 :2

pushd >/dev/null $HOME/.config/alacritty/
ln -fs fhd-home-dell.yml size.yml
ln -fs fhd-home-dell.toml size.toml
touch alacritty.toml
popd >/dev/null

pushd >/dev/null $HOME/.config/wezterm
echo "return 12" > font-size.lua
popd >/dev/null

exit 0
