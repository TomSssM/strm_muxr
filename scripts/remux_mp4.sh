#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

source=$1
out=$2

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

'C:/Program Files/MKVToolNix/mkvmerge.exe' --output "${out}" --language 0:und source_track1.h264 --language 0:en source_track3.ac3 --track-order 0:0,1:0

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while remuxing raw streams source_track1.h264 and source_track3.ac3 from ${source}"
  exit 1
fi

rm source_track1.h264 source_track3.ac3

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while deleting raw video and audio streams"
  exit 1
else
  echo -e "${GREEN}success${RESET} ${source}"
fi
