#! /bin/bash


usage() {
	echo "Usage: $0 [-h] -v <video-file> -s <srt-file> [-r | -o <output-file>]"
        echo "    v: Video file"
        echo "    s: Subtitle file"
        echo "    r: Replace input video file after embedding"
        echo "    c: Clean up by removing sub-title file"
	echo "    o: Output file"
        echo "    h: Displays help"
        exit $1
}

do_replace=0
do_clean=0

while getopts "hv:s:ro:c" arg; do
        case "${arg}" in
		v)
			f_vid_in=${OPTARG}
			;;
		s)
			f_srt_in=${OPTARG}
			;;
		r)
			do_replace=1
			;;
		o)
			f_vid_out=${OPTARG}
			;;
		c)
			do_clean=1
			;;
		h)
			usage 0
			;;
		*)
			usage 1
			;;
	esac
done


if [ -z "${f_vid_in}" ]; then
        echo "Please provide existing video file via -v"
        usage 2
fi

if [ ! -f "${f_vid_in}" ]; then
        echo "${f_vid_in} file doesn't exist"
        usage 2
fi

f_vid_in_nopath=$(basename -- "${f_vid_in}")
f_vid_in_ext="${f_vid_in_nopath##*.}"

if [ -z "${f_srt_in}" ]; then
        echo "Please provide existing sub-title file via -s"
        usage 2
fi

if [ ! -f "${f_srt_in}" ]; then
        echo "${f_srt_in} file doesn't exist"
        usage 2
fi

if [ ${do_replace} -eq 1 ]; then
	f_vid_out=$(mktemp -p /tmp embed-srt-XXXX.${f_vid_in_ext})
fi

if [ ${f_vid_in_ext} == "mkv" ]; then
	ffmpeg -i ${f_vid_in} -c copy -c:s ${f_srt_in} ${f_vid_out}
else
	ffmpeg -i ${f_vid_in} -i ${f_srt_in} -c copy -c:s mov_text ${f_vid_out}
fi

if [ ${do_replace} -eq 1 ]; then
	mv ${f_vid_out} ${f_vid_in}
fi

if [ ${do_clean} -eq 1 ]; then
	rm -rf ${f_srt_in}
fi
