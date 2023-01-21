const path = require('path');
const fs = require('fs');

function exists(fileOrDirectoryPath) {
  return fs.existsSync(fileOrDirectoryPath);
}

function mkdir(directoryPath) {
  return fs.mkdirSync(directoryPath);
}

function readdir(directoryPath) {
  return fs.readdirSync(directoryPath);
}

function isDirectory(fileOrDirectoryPath) {
  return fs.lstatSync(fileOrDirectoryPath).isDirectory();
}

function getFilePaths(directoryPath) {
  return readdir(directoryPath)
    .map((fileName) => path.join(directoryPath, fileName))
    .filter((filePath) => !isDirectory(filePath));
}

function writeTextFile(filePath, lines = []) {
  const data = lines.join('\n');
  fs.writeFileSync(filePath, data, {
    encoding: 'utf8',
  });
}

module.exports = {
  exists,
  mkdir,
  readdir,
  isDirectory,
  getFilePaths,
  writeTextFile,
};
