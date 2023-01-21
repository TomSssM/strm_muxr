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

'C:/Program Files/MKVToolNix/mkvextract.exe' tracks "${source}" 0:video_raw 1:audio_raw

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while extracting raw video stream 1 and raw audio stream 2 from ${source}"
  exit 1
fi

'C:/Program Files/MKVToolNix/mkvmerge.exe' --output "${out}" --language 0:und video_raw --language 0:en audio_raw --track-order 0:0,1:0

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while remuxing raw streams video_raw and audio_raw from ${source}"
  exit 1
fi

rm video_raw audio_raw

if [ $? -ne 0 ]
then
  echo -e "${RED}error:${RESET} something went wrong while deleting raw video and audio streams"
  exit 1
else
  echo -e "${GREEN}success${RESET} ${source}"
fi
