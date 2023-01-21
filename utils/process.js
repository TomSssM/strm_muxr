const { red, green, yellow } = require('./colors');

function run(program, ...args) {
  Promise.resolve()
    .then(() => program(...args))
    .catch(handleProcessError);
}

function handleProcessError(error) {
  exitWithError(error.message);
}

function exitWithError(message) {
  const errorHeader = 'error';
  console.error(`${isTTY(true) ? red(errorHeader) : errorHeader} ${message}`);
  process.exit(1);
}

function exitSuccess() {
  console.log(getSuccessMessage());
  process.exit(0);
}

function getSuccessMessage(forceColor) {
  const shouldColor = typeof forceColor === 'boolean' ? forceColor : isTTY();
  const successMessage = 'success';

  return shouldColor ? green(successMessage) : successMessage;
}

function printWarnings(warnings, pad = true) {
  if (!warnings.length) return;

  if (pad) console.log();

  warnings.forEach((warning) => {
    if (warning) {
      console.log(`${yellow('WARNING')} ${warning}`);
    }
  });

  if (pad) console.log();
}

function isTTY(checkStderr = false) {
  return Boolean(
    checkStderr ? process.stderr.isTTY : process.stdout.isTTY
  );
}

module.exports = {
  run,
  handleProcessError,
  exitWithError,
  exitSuccess,
  printWarnings,
  getSuccessMessage,
  isTTY,
};
