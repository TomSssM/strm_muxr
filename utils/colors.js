const ESCAPE = '\x1b';
const RED = `${ESCAPE}[31m`;
const GREEN = `${ESCAPE}[32m`;
const BLUE = `${ESCAPE}[34m`;
const YELLOW = `${ESCAPE}[33m`;
const RESET = `${ESCAPE}[0m`;

const [red, green, blue, yellow] = [RED, GREEN, BLUE, YELLOW]
  .map((colorString) => (value) => [colorString, value, RESET].join(''));

const [bgRed, bgGreen, bgBlue, bgYellow] = [41, 42, 44, 43]
  .map((colorIndex) => `${ESCAPE}[${String(colorIndex)}m`)
  .map((color) => (value) => [color, value, RESET].join(''));

module.exports = {
  ESCAPE,
  RED,
  GREEN,
  BLUE,
  YELLOW,
  RESET,
  red,
  green,
  blue,
  yellow,
  bgRed,
  bgGreen,
  bgBlue,
  bgYellow,
};
