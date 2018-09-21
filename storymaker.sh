#!/bin/bash

OUT_AUDIO_FILENAME="out_audio.mp3"

# Reading params from call, getting video or image path.
audio_path="https://stream-relay-geo.ntslive.net/stream?t=1535983749542"
live_recording_length_s=15
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
        -v)
            shift
            video_path=$1
            shift
            ;;
        -t)
            shift
            live_recording_length_s=$1
            shift
            ;;
        *)
            echo "$1 is not a recognized flag!"
            return 1;
            ;;
    esac
done

echo "audio source =" $audio_path
if [ $video_path ]; then
  echo "video source =" $video_path
fi
if [ $image_path ]; then
  echo "image source =" $image_path
fi

if [ -z $video_path -a -z $image_path]; then
  echo "\nError: Please add a video (-v PATH) or image (-i PATH)."
  exit 1
fi

#
#

# Records live stream
ffmpeg -y -i $audio_path -t 00:00:$live_recording_length_s output_audio.mp3 &&

#
#

# Replaces audio on given video path with live stream recording.
if [ $video_path ]; then
  echo "video source =" $video_path

  ffmpeg -i $video_path -i output_audio.mp3 -c:v copy -tune animation -c:a aac -b:a 320k -pix_fmt yuv420p -map 0:v:0 -map 1:a:0 -shortest output.mp4
fi

# Replaces audio on given video path with live stream recording.
if [ $image_path ]; then
  ffmpeg -y -loop 1 -i $image_path -i output_audio.mp3 -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest output.mp4
  # ffmpeg -y -loop 1 -i $image_path -i $audio_path -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -aframes 5 -shortest output.mp4
fi
