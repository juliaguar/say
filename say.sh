#! /bin/bash

say < $1 -o "audio.aiff"
ffmpeg -i audio.aiff audio.mp3
ffmpeg -i audio.aiff audio.ogg
rm auio.aiff
