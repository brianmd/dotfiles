// Export modules to global scope as necessary (only for testing)
'use strict'

const co = require('co');

const my = require('../index');
const glob = my.glob;

glob.my = my;

glob.chai = require("chai");
glob.co = co;

if (typeof process !== 'undefined' && process.title.endsWith('node')) {
  // We are in node. Require modules.
  console.error('you are running in node');
  glob.isBrowser = false;
  global.glob = glob;
  glob.expect = chai.expect;
  // glob.sinon = require('sinon');
  // glob.cotest = function(fn){ co(fn).catch(function(err){ done(err) })}
  // num = require('..');
} else {
  // We are in the browser. Set up variables like above using served js files.
  console.error('you are running in a browser');
  glob.isBrowser = true;
  window.glob = glob;
  glob.expect = chai.expect;
  // num and sinon already exported globally in the browser.
}

module.exports = glob;

