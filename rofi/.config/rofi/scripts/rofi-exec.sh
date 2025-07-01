#! /usr/bin/env bash
base_dir="$HOME/.config/rofi/"

# constants
l_dir='launchers'

type_prefix='type-'
type_min=1
type_max=7

style_prefix='style-'
style_min=1
style_max=7

# default values
default_mode='drun'

usage() {
	echo "Usage: $0 [-t type_number] [-s style_number] [-m mode]"
	echo ""
	echo "  -t type_number   Specify the launcher type number (integer)"
	echo "  -s style_number  Specify the style number (integer)"
	echo "  -m mode          Specify the mode (string, e.g., drun, run, window)"
	exit 1
}

get_theme_path() {
	local base_dir="$1"
	local l_dir="$2"
	local type_prefix="$3"
	local style_prefix="$4"
	local type_number="$5"
	local style_number="$6"
	echo "${base_dir}${l_dir}/${type_prefix}${type_number}/${style_prefix}${style_number}.rasi"
}

validate_number_in_range() {
	local num="$1"
	local min="$2"
	local max="$3"

	if ! echo "$num" | grep -Eq '^[0-9]+$'; then
		echo "Error: number ($num) must be an integer."
		exit 1
	fi

	if [ "$num" -lt "$min" ] || [ "$num" -gt "$max" ]; then
		echo "Error: number ($num) must be between $min and $max."
		exit 1
	fi
}

validate_mode() {
	local mode="$1"
	case "$mode" in
		drun|run|filemanager|filebrowser|window) ;;
		*) echo "Error: mode (-m) must be one of: drun, run, filemanager, filebrowser, window."; exit 1 ;;
	esac
}

while getopts "t:s:m:" opt; do
	case $opt in
		t) t_num="$OPTARG" ;;
		s) s_num="$OPTARG" ;;
		m) mode="$OPTARG" ;;
		*) usage ;;
	esac
done

validate_number_in_range $t_num $type_min $type_max
validate_number_in_range $s_num $style_min $style_max
validate_mode $mode

theme=$(get_theme_path "$base_dir" "$l_dir" "$type_prefix" "$style_prefix" "$t_num" "$s_num")

## Run
rofi \
	-show $mode \
	-theme $theme
