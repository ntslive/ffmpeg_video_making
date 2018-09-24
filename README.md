# NTS Story Maker

Simple script utilising ffmpeg functions to create mp4 videos.

Features:
* Create a video from an image and audio file.
* Create a video from an image and a live mp3 stream recording.
* Create a video from a video, and overwrite it's audio with new audio.

## Usage

Flag | Description
------------- | -------------
-v [file_path]  | Sets which video's audio to overwrite.
-i [file_path]  | Image from which to create video from. Maximum image width or height should be 1200px.
-t [seconds]  | Sets length (in seconds) of audio recording. Defaults to 15s.
-a [file_path OR url]  | Forces audio source to given file or URL. Defaults to NTS Stream 1 URL.
--stream2  | Sets audio recording to be taken from NTS Stream 2.
--help  | Print script usage.
