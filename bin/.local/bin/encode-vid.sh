#! /bin/bash

usage() {
	echo "Usage: $0 [-h] -i <input-dir> -o <output-dir> -r <resolution>"
        echo "    i: Base input directory"
        echo "    o: Base output directory"
	echo "    r: Resolution(720*, 1080p)"
	echo "    n: Dry run"
        echo "    h: Displays help"
        exit $1
}

dry_run=0

while getopts "hi:o:r:n" arg; do
        case "${arg}" in
		i)
			i_dir=${OPTARG}
			;;
		o)
			o_dir=${OPTARG}
			;;
		r)
			res=${OPTARG}
			;;
		n)
			dry_run=1
			;;
		h)
			usage 0
			;;
		*)
			usage 1
			;;
	esac
done

if [ ! -d "${i_dir}" ]; then
	echo "${i_dir} does not exist"
	exit 1
fi

# remove trailing space from i_dir
i_dir=`echo ${i_dir} | sed "s%/$%%g"`

if [ ! -d "${o_dir}" ]; then
	echo "${o_dir} does not exist"
	exit 1
fi

if [ ${res} != 720 ] && [ ${res} != 108 ]; then
	echo "${res} is not supported"
	echo "Supported values are 720 and 1080"
	exit 1
fi

i_course_dir="${i_dir}"
i_course_name=`basename "${i_course_dir}"`
o_course_name="${i_course_name}-${res}p"
o_course_dir="${o_dir}/${o_course_name}"

echo "i_course_dir: ${i_course_dir}"
echo "o_course_dir: ${o_course_dir}"

if [ ${dry_run} -eq 0 ]; then
	if [ -d "${o_course_dir}" ]; then
		echo "Output directory(${o_course_dir}) already exists"
		exit 1
	fi
fi

for i_d in `find ${i_course_dir} -type d`; do
	o_d=`echo ${i_d} | sed "s%^${i_course_dir}%${o_course_dir}%g"`
	if [ ${dry_run} -eq 0 ]; then
		mkdir -p ${o_d}
	fi
	for i_f in `find ${i_d} -maxdepth 1 -type f -iname \*.mp4`; do
		o_f=`echo ${i_f} | sed "s%^${i_course_dir}%${o_course_dir}%g"`
		if [ "${res}" == "720" ]; then
			if [ ${dry_run} -eq 1 ]; then
				echo "HandBrakeCLI --preset-import-gui -Z \"Fast 720p30 WebOptimized\" -i \"${i_f}\" -o \"${o_f}\""
			else
				HandBrakeCLI --preset-import-gui -Z "Fast 720p30 WebOptimized" -i ${i_f} -o ${o_f}
			fi
		elif [ "${res}" == "1080" ]; then
			if [ ${dry_run} -eq 1 ]; then
				echo "HandBrakeCLI --preset-import-gui -Z \"Fast 1080p30 WebOptimized\" -i \"${i_f}\" -o \"${o_f}\""
			else
				HandBrakeCLI --preset-import-gui -Z "Fast 1080p30 WebOptimized" -i ${i_f} -o ${o_f}
			fi
		fi
	done
done
