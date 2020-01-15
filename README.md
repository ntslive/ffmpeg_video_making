# NTS Story Maker

Simple bash script utilising ffmpeg functions to create mp4 videos.

Features:
* Create a video from an image and audio file.
* Create a video from an image and a live mp3 stream recording.
* Create a video from a video, and overwrite it's audio with new audio.

## Installation

To run the story maker, you'll need to install `ffmpeg`, which can be done (on Mac OS) with Homebrew. Follow these steps, or look at the full installation tutorial on [ffmpeg's website](https://trac.ffmpeg.org/wiki/CompilationGuide/macOS#ffmpegthroughHomebrew).

Open the 'terminal' application on your mac, where you'll execute these commands. Note, these commands can take quite a few minutes to finish!

Step 1. This installs `Homebrew` to your system.
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Step 2. With `Homebrew` installed, you can then install `ffmpeg` with it. The following wil install `ffmpeg` on your machine.
```
brew install ffmpeg
```

Step 3. You need to download the storymaker script from the NTS git repository. 'Clone' the code with following command, which will create the repo in a folder called 'storymaker':
```
git clone https://github.com/ntslive/ffmpeg_video_making.git storymaker
```

You should now be able to run storymaker.

## Usage
From the terminal, change directory into the storymaker repo if you aren't in it already, e.g. `cd storymaker`. You can check which directory you are in by executing `pwd`. When in the directory, you can execute the script like so:
```
./storymaker.sh --help
```

Above executes the help function, there are examples on usages there.

Flag | Description
------------- | -------------
-v [file_path]  | Sets which video's audio to overwrite.
-i [file_path]  | Image from which to create video from. Maximum image width or height should be 1200px.
-t [seconds]  | Sets length (in seconds) of audio recording. Defaults to 15s.
-a [file_path OR url]  | Forces audio source to given file or URL. Defaults to NTS Stream 1 URL.
--stream2  | Sets audio recording to be taken from NTS Stream 2.
--help  | Print script usage.

### Woh there!

* Images used must not have a width or height larger than 1200px.
* Images must have a width and height which are divisible by 2. e.g. 127px:128px is unacceptable.
