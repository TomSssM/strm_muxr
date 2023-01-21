#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

videoFileName=$1
source="./content/${videoFileName}.mkv"
out="./out/${videoFileName}.mkv"
videoRaw="./content/${videoFileName}_video_raw"
audioRaw="./content/${videoFileName}_audio_raw"

if [ ! -f "${source}" ]; then
  echo -e "${RED}error:${RESET} source file ${source} doesn't exist"
  exit 1
fi

'C:/Program Files/MKVToolNix/mkvextract.exe' tracks "${source}" 0:"${videoRaw}" 1:"${audioRaw}"

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while extracting raw video stream 1 and raw audio stream 2 from ${source}"
  exit 1
fi

echo

'C:/Program Files/MKVToolNix/mkvmerge.exe' --output "${out}" --language 0:und "${videoRaw}" --language 0:en "${audioRaw}" --track-order 0:0,1:0

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while remuxing raw streams from ${source}"
  exit 1
fi

echo
echo -e "${GREEN}success${RESET} ${source}"
echo && echo && echo
