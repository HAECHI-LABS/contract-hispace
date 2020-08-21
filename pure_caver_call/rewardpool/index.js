const Caver = require('caver-js');
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const eoa = require('../_common').eoa;
const priv = require('../_common').priv;
const contract = require('../_common').contract;
const logging = require('../_common').logging;

const RewardPool = require('../../build/contracts/RewardPool').abi;

caver.klay.accounts.wallet.add(priv.taek);

const rewardPool = new caver.klay.Contract(RewardPool, contract.rewardpool);

async function rewardBalance() {
  const result = await rewardPool.methods.rewardBalance().call();
  console.log(result);
  logging(result, 'rewardBalance');
}

if (process.argv.length < 3) {
  throw new Error('command must be given');
}

const cmd = process.argv[2];
console.log(process.argv);
console.log('executing ' + cmd + '...');

switch (cmd) {
  case 'rewardBalance':
    return rewardBalance();

  default:
    throw new Error('invalid command: ' + cmd);
}
