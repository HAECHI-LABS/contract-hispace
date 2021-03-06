const eoa = require('../_common').eoa;
const contract = require('../_common').contract;
const priv = require('../_common').priv;
const logging = require('../_common').logging;
const Caver = require('caver-js');
const caver = new Caver('https://api.baobab.klaytn.net:8651/');
const utils = require('web3').utils;
const Token = require('../../build/contracts/HiblocksToken').abi;

caver.klay.accounts.wallet.add(priv.taek);
caver.klay.accounts.wallet.add(priv.jh);
caver.klay.accounts.wallet.add(priv.jh2);
const token = new caver.klay.Contract(Token, contract.token);

// Decimal
const decimals = utils.toBN(18);

// Amount of token
const tokenAmount = utils.toBN(10000);

// Amount as Hex - contract.methods.transfer(toAddress, tokenAmountHex).encodeABI();
const tokenAmountHex = '0x' + tokenAmount.mul(utils.toBN(10).pow(decimals)).toString('hex');

if (process.argv.length < 3) {
  throw new Error('command must be given');
}

async function approve(from, who) {
  const receipt = await token.methods.approve(who, tokenAmountHex).send({
    from: from,
    gas: 8000000
  });
  console.log(receipt);
  // logging(receipt, 'approve');
}

async function transferFrom(to) {
  const receipt = await token.methods.transferFrom(
    eoa.taek,
    to,
    10
  ).send({
    from: eoa.jh,
    gas: 8000000
  });
  console.log(receipt);
  logging(receipt, 'transferFrom');
}

async function transfer(to) {
  const receipt = await token.methods.transfer(to, tokenAmountHex).send({
    from: eoa.jh,
    gas: 8000000
  });
  console.log(receipt);
  // logging(receipt, 'transfer');
}

async function balanceOf(who) {
  const data = await token.methods.balanceOf(who).call();
  console.log(data);
  logging(data, 'balanceOf ' + who);
}

async function balanceOfKlay(who) {
  const data = await caver.klay.getBalance(who);
  console.log(data);
  logging(data, 'balanceOf ' + who);
}

async function allowance(from, to) {
  const data = await token.methods.allowance(from, to).call();
  console.log(data);
  logging(data, 'allowance from: ' + from + ', to: ' + to);
}

const cmd = process.argv[2];
console.log(process.argv);
console.log('executing ' + cmd + '...');
switch (cmd) {
  case 'approve':
    if (!process.argv[3]) {
      throw new Error('approve from must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('approve target must be specified');
    }
    return approve(process.argv[3], process.argv[4]);

  case 'transferFrom':
    if (!process.argv[3]) {
      throw new Error('transferFrom to must be specified');
    }
    return transferFrom(process.argv[3]);

  case 'transfer':
    if (!process.argv[3]) {
      throw new Error('transfer to must be specified');
    }
    return transfer(process.argv[3]);

  case 'balanceOf':
    if (!process.argv[3]) {
      throw new Error('approve target must be specified');
    }
    return balanceOf(process.argv[3]);

  case 'balanceOfKlay':
    if (!process.argv[3]) {
      throw new Error('approve target must be specified');
    }
    return balanceOfKlay(process.argv[3]);

  case 'allowance':
    if (!process.argv[3]) {
      throw new Error('allowance from must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('allowance from must be specified');
    }
    return allowance(process.argv[3], process.argv[4]);
  default:
    throw new Error('invalid command: ' + cmd);
}
