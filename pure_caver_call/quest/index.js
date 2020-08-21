const eoa = require('../_common').eoa;
const contract = require('../_common').contract;
const priv = require('../_common').priv;
const logging = require('../_common').logging;
const Caver = require('caver-js');
const Web3 = require('web3');
const utils = require('web3').utils;
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const Quest = require('../../build/contracts/HiQuest').abi;

caver.klay.accounts.wallet.add(priv.taek);
caver.klay.accounts.wallet.add(priv.jh);
caver.klay.accounts.wallet.add(priv.jh2);
const quest = new caver.klay.Contract(Quest, contract.quest);

function convertAmount(amount) {
    // Decimal
  const decimals = utils.toBN(18);

  // Amount of token
  const tokenAmount = utils.toBN(amount);

  // Amount as Hex - contract.methods.transfer(toAddress, tokenAmountHex).encodeABI();
  const tokenAmountHex = '0x' + tokenAmount.mul(utils.toBN(10).pow(decimals)).toString('hex');
  return tokenAmountHex;
}

function convertQuestId(id) {
  return Web3.utils.asciiToHex(id).padEnd(66, '0');
}

async function questInfo(id) {
  console.log('id', id);
  console.log('converted', convertQuestId(id));
  const result = await quest.methods.questInfo(convertQuestId(id)).call();
  console.log(result);
}

async function create(questId) {
  const receipt = await quest.methods.create(
    convertQuestId(questId),
    Date.now(),
    Date.now() + 3600,
    10000,
  ).send({
    from: eoa.taek,
    gas: 8000000
  });
  console.log(receipt);
}

console.log(Date.now());
if (process.argv.length < 3) {
  throw new Error('command must be given');
}

const cmd = process.argv[2];
console.log(process.argv);
console.log('executing ' + cmd + '...');
switch (cmd) {
  case 'questInfo':
    if (!process.argv[3]) {
      throw new Error('questInfo questId must be specified');
    }
    return questInfo(process.argv[3]);

  case 'create':
    if (!process.argv[3]) {
      throw new Error('create questId must be specified');
    }
    return create(process.argv[3]);

  default:
    throw new Error('invalid command: ' + cmd);
}

