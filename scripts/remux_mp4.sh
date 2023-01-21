#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

videoFileName=$1
source="./content/${videoFileName}.mp4"
out="./out/${videoFileName}.mkv"
videoRaw="./content/${videoFileName}_track1.h264"
audioRaw="./content/${videoFileName}_track3.ac3"

if [ ! -f "${source}" ]; then
  echo -e "${RED}error:${RESET} source file ${source} doesn't exist"
  exit 1
fi

'C:\Users\User\AppData\Roaming\Yamb\MP4Box.exe' -raw 1 "${source}"

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while extracting raw video stream 1 from ${source}"
  exit 1
fi

'C:\Users\User\AppData\Roaming\Yamb\MP4Box.exe' -raw 3 "${source}"

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while extracting raw audio stream 3 from ${source}"
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
