#!/bin/bash

# IMAGE_PATH=$1
# LIVE_AUDIO_STREAM="https://stream-relay-geo.ntslive.net/stream?t=1535983749542"
OUT_AUDIO_FILENAME="out_audio.mp3"

audio_path="https://stream-relay-geo.ntslive.net/stream?t=1535983749542"

while test $# -gt 0; do
    case "$1" in
        -a)
            shift
            audio_path=$1
            shift
            ;;
        -i)
            shift
            image_path=$1
            shift
            ;;
        *)
            echo "$1 is not a recognized flag!"
            return 1;
            ;;
    esac
done

echo $image_path
echo $audio_path
# ffmpeg -loop 1 -i $IMAGE_PATH -i $AUDIO_PATH -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest output.mp4
# ffmpeg -i $LIVE_AUDIO_STREAM -c copy -flags +global_header -f segment -segment_time 5 -segment_format_options movflags=+faststart -reset_timestamps 1 test%d.mp4

# Records live stream:
ffmpeg -y -i $audio_path -t 00:00:15 output_audio.mp3 &&

# Merges input video and replaces it's audio with output_audio.mp3
ffmpeg -i video/ld_sample.mp4 -i output_audio.mp3 -c:v copy -tune stillimage -c:a aac -b:a 320k -pix_fmt yuv420p -map 0:v:0 -map 1:a:0 output.mp4

# Merges image and audio file together
# ffmpeg -y -loop 1 -i $image_path -i output_audio.mp3 -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest output.mp4
# ffmpeg -y -loop 1 -i $image_path -i $audio_path -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -aframes 5 -shortest output.mp4
