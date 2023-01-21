# Take1
'C:\Program Files\ffmpeg\bin\ffmpeg.exe' -i source.mp4 -c:v copy -c:a copy source-tmp.mkv
echo
'C:/Program Files/MKVToolNix/mkvmerge.exe' --output out.mkv --no-subtitles --no-track-tags --no-global-tags --no-attachments --language 0:und --language 1:en source-tmp.mkv --title "" --track-order 0:0,0:1
# or with external subtitles
# 'C:/Program Files/MKVToolNix/mkvmerge.exe' --output out.mkv --no-subtitles --no-track-tags --no-global-tags --no-attachments --language 0:und --language 1:en source-tmp.mkv --title "" --language 0:en --default-track-flag 0:no sub.srt --track-order 0:0,0:1,1:0
rm source-tmp.mkv



# Take 2
'C:\Users\User\AppData\Roaming\Yamb\MP4Box.exe' -raw 1 source.mp4
'C:\Users\User\AppData\Roaming\Yamb\MP4Box.exe' -raw 3 source.mp4
# mv source_track1.* video
# mv source_track3.* audio
'C:/Program Files/MKVToolNix/mkvmerge.exe' --output out.mkv --language 0:und source_track1.h264 --language 0:en source_track3.ac3 --track-order 0:0,1:0 # or source_track3.aac
# or with subtitles
# 'C:/Program Files/MKVToolNix/mkvmerge.exe' --output out.mkv --language 0:und source_track1.h264 --language 0:en source_track3.ac3 --language 0:en --default-track-flag 0:no sub.srt --track-order 0:0,1:0,2:0
# or
# 'C:/Program Files/MKVToolNix/mkvmerge.exe' --output out.mkv --language 0:und video --language 0:en audio --track-order 0:0,1:0
rm source_track1.h264 source_track3.ac3 # or source_track3.aac
# or
# rm video audio



# Take 3
'C:\Program Files\ffmpeg\bin\ffmpeg.exe' -i source.mp4 -c:v copy -c:a copy source-tmp.mkv
'C:/Program Files/MKVToolNix/mkvextract.exe' tracks source-tmp.mkv 0:video 1:audio
'C:/Program Files/MKVToolNix/mkvmerge.exe' --output out.mkv --language 0:und video --language 0:en audio --track-order 0:0,1:0
rm source-tmp.mkv
