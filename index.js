const path = require('path');
const { exists, mkdir, getFilePaths, writeTextFile } = require('./utils/fs');
const { VideoFile, getFileName, isKnownVideoFile, isMp4File, isMkvFile } = require('./utils/path');
const { run, printWarnings, getSuccessMessage, exitSuccess } = require('./utils/process');

const ROOT_DIR = process.cwd();
const CONTENT_DIR = path.join(ROOT_DIR, 'content');
const SUBTITLES_DIR = path.join(CONTENT_DIR, 'sub');
const DIST_DIR = path.join(ROOT_DIR, 'out');

const WARNINGS_PATH = path.join(ROOT_DIR, 'warnings.log.txt');
const SCRIPT_PATH = path.join(ROOT_DIR, 'run.sh');

run(() => {
  if (!exists(CONTENT_DIR)) {
    throw new Error('"content" directory doesn\'t exist');
  }

  if (!exists(DIST_DIR)) {
    mkdir(DIST_DIR);
  }

  const script = [];
  const warnings = [];
  const videoFiles = getFilePaths(CONTENT_DIR);
  const hasSubtitlesDir = exists(SUBTITLES_DIR);
  const subtitleFiles = hasSubtitlesDir ? getFilePaths(SUBTITLES_DIR) : [];
  const orphanedSubtitles = new Set(subtitleFiles);

  videoFiles.forEach((videoFilePath) => {
    const videoFileName = getFileName(videoFilePath);
    const outputFilePath = path.join(DIST_DIR, `${videoFileName}.${VideoFile.Mkv}`);
    const subtitleFilePath = subtitleFiles.find((filePath) => {
      return getFileName(filePath).startsWith(videoFileName);
    });
    const hasSubtitles = Boolean(subtitleFilePath);

    if (hasSubtitlesDir && !hasSubtitles) {
      warnings.push(`subtitles not found for ${videoFilePath}`);
    }

    if (!isKnownVideoFile(videoFilePath)) {
      warnings.push(`unknown video container ${videoFilePath}`);
      return;
    }

    if (hasSubtitles) {
      orphanedSubtitles.delete(subtitleFilePath);
    }

    if (isMp4File(videoFilePath) && hasSubtitles) {
      script.push([
        './scripts/remux_mp4_sub.sh',
        `"${videoFilePath}"`,
        `"${subtitleFilePath}"`,
        `"${outputFilePath}"`,
        '&& \\'
      ].join(' '));
    } else if (isMp4File(videoFilePath)) {
      script.push([
        './scripts/remux_mp4.sh',
        `"${videoFilePath}"`,
        `"${outputFilePath}"`,
        '&& \\'
      ].join(' '));
    }

    if (isMkvFile(videoFilePath) && hasSubtitles) {
      script.push([
        './scripts/remux_mkv_sub.sh',
        `"${videoFilePath}"`,
        `"${subtitleFilePath}"`,
        `"${outputFilePath}"`,
        '&& \\'
      ].join(' '));
    } else if (isMkvFile(videoFilePath)) {
      script.push([
        './scripts/remux_mkv.sh',
        `"${videoFilePath}"`,
        `"${outputFilePath}"`,
        '&& \\'
      ].join(' '));
    }
  });

  script.push(getSuccessMessage(true));

  warnings.push([...orphanedSubtitles.values()].map(
    (subtitleFilePath) => `orphaned subtitle file ${subtitleFilePath}`
  ));

  writeTextFile(SCRIPT_PATH, script);
  writeTextFile(WARNINGS_PATH, warnings);
  printWarnings(warnings);
  exitSuccess();
});
