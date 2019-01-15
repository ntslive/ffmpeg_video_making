#!/bin/sh

OUTPUT_FOLDER_NAME="output"
STREAM_ONE_URL="https://stream-relay-geo.ntslive.net/stream"
STREAM_TWO_URL="https://stream-relay-geo.ntslive.net/stream2"

# Reading params from call, getting video or image path.
audio_path=$STREAM_ONE_URL
live_recording_length_s=15
while test $# -gt 0; do
    case "$1" in
        --stream2)
            shift
            audio_path=$STREAM_TWO_URL
            ;;
        --help)
            shift
            echo -e "Usage:"
            echo -e "-v [file_path]\t\t Sets which video's audio to overwrite."
            echo -e "-i [file_path]\t\t Image from which to create video from. Maximum image width or height should be 1200px."
            echo -e "-t [seconds]\t\t Sets length (in seconds) of audio recording. Defaults to 15s."
            echo -e "-a [file_path | url]\t Forces audio source to given file or URL. Defaults to NTS Stream 1 URL."
            echo -e "--stream2\t\t Sets audio recording to be taken from NTS Stream 2."
            echo -e "--help\t\t\t Print script usage."
            echo ""
            echo "Created videos are placed in the output/ folder."
            echo ""
            echo "Examples:"
            echo -e "- Create a 15s video, recording NTS stream 1 on top of image.\n\t./storymaker -i images/sample.jpg "
            echo -e "- Create a 15s video, recording NTS stream 1 on top of video.\n\t./storymaker -v video/ld_sample.mp4"
            echo -e "- Create a 10s video, putting audio from a file on top of a video.\n\t./storymaker -v video/ld_sample.mp4 -a audio/sample.mp3 -t 10"
            echo ""

            exit 1;
            ;;
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
            echo "Use flag '--help' for usage."
            exit 1;
            ;;
    esac
done

if [ -z $video_path -a -z $image_path]; then
  echo "ERROR: An image or video is required."
  echo "Use flag '--help' for usage."
  exit 1
fi

echo "audio source =" $audio_path
if [ $video_path ]; then
  echo "video source =" $video_path
fi
if [ $image_path ]; then
  echo "image source =" $image_path
fi

#
#

# Records live stream
ffmpeg -y -i $audio_path -t 00:00:$live_recording_length_s output_audio.mp3

#
#

# Get size of output folder, and create file name including a unique numeric.
out_folder_size=`echo $(find $OUTPUT_FOLDER_NAME -type f | wc -l)`
next_item_size=`expr $out_folder_size + 1`
out_file_name="${OUTPUT_FOLDER_NAME}/story_${next_item_size}.mp4";

# Replaces audio on given video path with live stream recording.
if [ $video_path ]; then
  ffmpeg -i $video_path -i output_audio.mp3 -c:v copy -tune animation -c:a aac -b:a 320k -pix_fmt yuv420p -map 0:v:0 -map 1:a:0 -shortest $out_file_name
fi

# Replaces audio on given video path with live stream recording.
if [ $image_path ]; then
  ffmpeg -loop 1 -i $image_path -i output_audio.mp3 -t 00:00:$live_recording_length_s -c:v libx264 -tune stillimage -c:a aac -ar 44100 -r 30 -pix_fmt yuv420p $out_file_name
  # ffmpeg -loop 1 -y -i $image_path -i output_audio.mp3 -acodec copy -vcodec libx264output.mp4
fi
