const path = require('path');

const VideoFile = {
  Mp4: 'mp4',
  Mkv: 'mkv'
}

function getFileExtension(filePath) {
  return path.extname(filePath);
}

function getFileName(filePath, withExtension = false) {
  const extension = getFileExtension(filePath);
  return path.basename(filePath, withExtension ? undefined : extension);
}

function isKnownVideoFile(filePath) {
  return Object.values(VideoFile).includes(getFileExtension(filePath));
}

function isMp4File(filePath) {
  return getFileExtension(filePath) === VideoFile.Mp4;
}

function isMkvFile(filePath) {
  return getFileExtension(filePath) === VideoFile.Mkv;
}

module.exports = {
  VideoFile,
  getFileExtension,
  getFileName,
  isKnownVideoFile,
  isMp4File,
  isMkvFile,
};
