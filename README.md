# Say

This is a tiny ruby tool that uses `say` and `ffmpeg` to create audio files from text input.
It is optimized to read markdown files and will therefore ignore lines starting with "#" (headings) and four spaces (code).

## Requirements
Requires `ffmpeg` to be installed with theora.

### Installation ffmpeg (Mac OS)

`brew install ffmpeg --with-theora`

## Usage
From the command line run

`ruby say.rb -i name_of_text_file`

This will create a voice output of the text file as audio.en.mp3 and audio.en.ogg.
To specify a different output use `-o name_of_output_file`

`ruby say.rb -i name_of_text_file -o my_audio.mp3`

This will create a voice output to my_audio.mp3 and my_audio.ogg.

## Using bash
Alternatively, if you do not want the headings or code to be omitted, you can use the bash script with `./say.sh`.
It will take the input as is and pipe it into the say command and output a `audio.mp3` and `audio.ogg` file.
You can run it with:

`./say.sh name_of_input_file`
