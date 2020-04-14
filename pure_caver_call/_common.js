const fs = require('fs');
const moment = require('moment');

const priv = {
  taek: '0x879c00447f38af4d72b2ac870b16fe62b54566d210e1dfa52449f2f90f0e0dc6',
  jh: '0x6f993629f0d3836153141053f314286d555b4ac21f14057004c7e900413aa1a3',
  jh2: '0x4e14bc6830f930daa8cefef30e60f86971265724dec969fd071a68929d5ae7a8'
};

const contract = {
  token: '0x0e6984E470BcC67c9C008F921DCb44a7B252f298',
  savebox: '0x6f20847c12d065c7E64778E56B719aC25a7aadc7',
  rewardpool: '0xbF058Aa9d294d7dc5e9D1d43c7018f06F6344A73',
  rewardsupplier: '0x5C5a7D1E6a558DcF3Cbd4Aaf718DE5A39f74BE5E',
};

const savebox = {
  '1': '0x89238b7e79c68552488a19ab08fe4d921c7ff83b957d94ee4c61776ddf4c61b3'
};

module.exports.eoa = eoa;

module.exports.contract = contract;
module.exports.addPrivateKeys = addPrivateKeys;

module.exports.logging = function(json, cmd) {
  fs.appendFileSync('./history.log', moment().format("YYYY-MM-DDTHH:mm:ss") + ' - ' + cmd +'\n' + JSON.stringify(json, null, 2) + '\n')
}
