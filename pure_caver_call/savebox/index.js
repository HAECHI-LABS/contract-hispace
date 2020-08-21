const eoa = require('../_common').eoa;
const contract = require('../_common').contract;
const priv = require('../_common').priv;
const logging = require('../_common').logging;
const Caver = require('caver-js');
const Web3 = require('web3');
const utils = require('web3').utils;
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const Savebox = require('../../build/contracts/SaveBox').abi;

caver.klay.accounts.wallet.add(priv.taek);
caver.klay.accounts.wallet.add(priv.jh);
caver.klay.accounts.wallet.add(priv.jh2);
const savebox = new caver.klay.Contract(Savebox, contract.savebox);

function convertAmount(amount) {
    // Decimal
  const decimals = utils.toBN(18);

  // Amount of token
  const tokenAmount = utils.toBN(amount);

  // Amount as Hex - contract.methods.transfer(toAddress, tokenAmountHex).encodeABI();
  const tokenAmountHex = '0x' + tokenAmount.mul(utils.toBN(10).pow(decimals)).toString('hex');
  return tokenAmountHex;
}

function convertBoxId(boxId) {
  return Web3.utils.asciiToHex(boxId).padEnd(66, '0');
}

async function createBox(creator, boxId) {
  console.log('creator', creator);
  console.log('boxId', boxId);
  console.log('converted', convertBoxId(boxId));
  const receipt = await savebox.methods.createBox(convertBoxId(boxId)).send({
    from: creator,
    gas: 8000000
  });
  console.log(receipt);
  logging(receipt, 'createBox');
}

async function stake(who, amount) {
  try {
    const receipt = await savebox.methods.stake(convertAmount(amount))
      .send({
        from: who,
        gas: 8000000
      });
    console.log(receipt);
    logging(receipt, 'stake');
  } catch (e) {
    console.log(e);
  }
}

async function stakeTo(who, amount, boxId) {
  console.log('who', who);
  console.log('amount', amount);
  console.log('boxId', boxId);
  const receipt = await savebox.methods.stakeTo(
    convertBoxId(boxId), 
    convertAmount(amount)
  )
    .send({
      from: who,
      gas: 8000000
    });
  console.log(receipt);
  logging(receipt, 'stakeTo');
}

async function stakeAmount(staker, boxId) {
  const result = await savebox.methods.stakeAmount(convertBoxId(boxId), staker).call();
  console.log(result);
  logging(result, 'stakeAmount');
}

async function boxInfo(boxId) {
  const result = await savebox.methods.boxInfo(convertBoxId(boxId)).call();
  console.log(result);
  logging(result, 'boxInfo');
}

async function sandbox() {
  // SP00000000000002
  const bytes32 = '0x5350303030303030303030303030303200000000000000000000000000000000';
  const result = Web3.utils.toAscii(bytes32);
  console.log(result);
  const result3 = Web3.utils.fromAscii('SP00000000000002');
  console.log('>>', result3);
}

if (process.argv.length < 3) {
  throw new Error('command must be given');
}

const cmd = process.argv[2];
console.log(process.argv);
console.log('executing ' + cmd + '...');
switch (cmd) {
  case 'createBox':
    if (!process.argv[3]) {
      throw new Error('createBox creator must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('createBox boxId must be specified');
    }
    return createBox(process.argv[3], process.argv[4]);

  case 'stake':
    if (!process.argv[3]) {
      throw new Error('stake who must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('stake amount must be specified');
    }
    return stake(process.argv[3], parseInt(process.argv[4]));

  case 'stakeTo':
    if (!process.argv[3]) {
      throw new Error('stakeTo who must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('stakeTo amount must be specified');
    }
    if (!process.argv[5]) {
      throw new Error('stakeTo boxId  must be specified');
    }
    return stakeTo(process.argv[3], parseInt(process.argv[4]), process.argv[5]);

  case 'stakeAmount':
    if (!process.argv[3]) {
      throw new Error('stakeAmount staker must be specified');
    }
    let boxId = process.argv[4];
    if (!process.argv[4]) {
      console.log('boxId not specified, set to zero');
      boxId = '';
    }
    return stakeAmount(process.argv[3], boxId);

  case 'boxInfo':
    if (!process.argv[3]) {
      throw new Error('boxInfo boxId must be specified');
    }
    return boxInfo(process.argv[3]);
  case 'sandbox':
    return sandbox();
  default:
    throw new Error('invalid command: ' + cmd);
}

