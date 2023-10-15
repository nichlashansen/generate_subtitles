# How i Automatically Generate subtitles

To use the bash script, it's important you already installed:
- [Git](https://git-scm.com/)
- [ffmpeg](https://formulae.brew.sh/formula/ffmpeg)

You'll need to clone the whisper.cpp git repository from [here](https://github.com/ggerganov/whisper.cpp)

## Setup
To run the script you'll need to update it with the location for whisper.cpp, there it says /path/to/whisper.cpp

the script requires the path to the .wav file you are using for the subtitles.

What i normally do is export the wav file from Final cut pro and place it in the same folder as the script.

then in your terminal go to the folder where the script is:
you'll need to supply the full path to the wav file, to do this run 

```
pwd

```
 and copy the path.

To run the script in the folder of the script type the following in your terminal:

```
./process_audio.sh /path/to/audiofile/new.wav
```
This will generate a .srt file when finished with timestamps and text based on your audio, ready to upload to youtube.

