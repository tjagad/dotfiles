#! /bin/bash

usage() {
	echo "Usage: $0 [-h] -i <input-list> [-o <output-dir>]"
        echo "    i: File containing list of vidoes to be converted"
	echo "    o: Output directory to store compressed videos"
	echo "       (default: ./small)"
        echo "    h: Displays help"
        exit $1
}

_hbcli_preset_f="/etc/chronos/handbrake-fast-1080p30-weboptimized.json"
_hbcli_preset_n="Fast 1080p30 WebOptimized"
_hbcli_common="HandBrakeCLI --preset-import-file ${_hbcli_preset_f} "
_hbcli_common+='--preset "${_hbcli_preset_n}"'
_hbcli_input="-i "
_hbcli_output="-o "

output_f_ext=".mp4"

_base_output_d="small"

list_f=""
base_output_d=""

while getopts "hi:o:" arg; do
        case "${arg}" in
		i)
			list_f=${OPTARG}
			;;
		o)
			base_output_d=${OPTARG}
			;;
		h)
			usage 0
			;;
		*)
			usage 1
			;;
	esac
done

if [ -z "${list_f}" ]; then
        echo "[ERROR] Please provide existing video file via -i"
        usage 2
fi

if [ ! -f "${list_f}" ]; then
        echo "[ERROR] ${list_f} file doesn't exist"
        usage 2
fi

if [ -z "${base_output_d}" ]; then
	base_output_d=`pwd`/${_base_output_d}
	mkdir -p ${base_output_d}
        echo "[INFO] Saving to default directory small" | tee -a ${log_f}
elif [ ! -d "${base_output_d}" ]; then
        echo "[ERROR] ${base_output_d} directory doesn't exist" | tee -a ${log_f}
        usage 2
fi

total_input_f=0
total_output_f=0
log_f=${base_output_d}/log.txt
while read -r input_p
do
	((total_input_f+=1))
	if [ -f ${input_p} ]; then
		echo "=====" | tee -a ${log_f}
		echo "[INFO] input: ${input_p}" | tee -a ${log_f}
		echo "=====" | tee -a ${log_f}

		input_d=$(dirname -- ${input_p})
		input_f=$(basename -- ${input_p})

		input_f_name="${input_f%.*}"
		input_f_ext="${input_f##*.}"

		is_input_p_relative=1
		if [[ ${input_p} == /* ]]; then
			is_input_p_relative=0
		fi

		if [ ${is_input_p_relative} -eq 1 ]; then
			echo "[INFO] File path is relative" | tee -a ${log_f}
		else
			echo "[INFO] File path is absolute" | tee -a ${log_f}
		fi

		output_d=${base_output_d}/${input_d}
		output_p=${output_d}/${input_f_name}${output_f_ext}

		mkdir -p ${output_d}

		hbcli_input="${_hbcli_input} ${input_p}"
		hbcli_output="${_hbcli_output} ${output_p}"

		cmd="${_hbcli_common} ${hbcli_input} ${hbcli_output} < /dev/null"
		eval $cmd

		input_p_size=$(stat --format=%s ${input_p})
		output_p_size=$(stat --format=%s ${output_p})

		if [ ${input_p_size} -lt ${output_p_size} ]; then
			echo "[WARN] Input size smaller than output: ${output_p}.big" | tee -a ${log_f}
			mv ${output_p} ${output_p}.big
		fi

		echo "[SUCCESS] ${input_p} => ${output_p}" | tee -a ${log_f}
		((total_output_f+=1))
	else
		echo "[ERROR] File does not exist. Skipping...: ${input_p}" | tee -a ${log_f}
	fi
done < "${list_f}"

echo "Processed ${total_output_f} out of ${total_input_f}" | tee -a ${log_f}

retval=1
if [ ${total_input_f} -eq ${total_output_f} ]; then
	retval=0
fi

exit $retval
