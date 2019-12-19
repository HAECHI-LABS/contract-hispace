const _ = require('lodash');

/**
 * testInfos : Object ( key, val )
 */
function LogTestInfo(testInfos, title) {
  console.log('=== Test info ==============');
  console.log(title || '');
  _.forEach(testInfos, (val, key) => {
    console.log(`${key} : ${val}`);
  });
}

module.exports = {
  LogTestInfo,
};
