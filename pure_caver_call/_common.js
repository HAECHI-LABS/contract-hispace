const fs = require('fs');
const moment = require('moment');
const contract = require('../migrationResults.json');
const priv = require('../truffle-config').privateKeys;


function addPrivateKeys(wallet) {
  priv.forEach(async (x)=>{
    await wallet.add(x);
  });
  return wallet;
}

module.exports.contract = contract;
module.exports.addPrivateKeys = addPrivateKeys;

module.exports.logging = function(json, cmd) {
  fs.appendFileSync('./history.log', moment().format("YYYY-MM-DDTHH:mm:ss") + ' - ' + cmd +'\n' + JSON.stringify(json, null, 2) + '\n')
}
