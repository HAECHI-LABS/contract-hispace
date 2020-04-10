const eoa = require('../_common').eoa;
const contract = require('../_common').contract;
const priv = require('../_common').priv;
const logging = require('../_common').logging;
const Caver = require('caver-js');
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const Savebox = require('../../build/contracts/SaveBox.json').abi;

caver.klay.accounts.wallet.add(priv.taek);
caver.klay.accounts.wallet.add(priv.jh);
caver.klay.accounts.wallet.add(priv.jh2);
const savebox = new caver.klay.Contract(Savebox, contract.savebox);

async function createBox() {
  const receipt = await savebox.methods.createBox()
    .send({
      from: eoa.taek,
      gas: 8000000
    });
  console.log(receipt);
  logging(receipt, 'createBox');
}

async function stake(who, amount) {
  try {
    const receipt = await savebox.methods.stake(amount)
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
  const receipt = await savebox.methods.stakeTo(boxId, amount)
    .send({
      from: who,
      gas: 8000000
    });
  console.log(receipt);
  logging(receipt, 'stakeTo');
}

async function stakeAmount(boxId, staker) {
  const result = await savebox.methods.stakeAmount(boxId, staker).call();
  console.log(result);
  logging(result, 'stakeAmount');
}

if (process.argv.length < 3) {
  throw new Error('command must be given');
}

const cmd = process.argv[2];
console.log(process.argv);
console.log('executing ' + cmd + '...');
switch (cmd) {
  case 'createBox':
    return createBox();

  case 'stake':
    if (!process.argv[3]) {
      throw new Error('stake who must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('stake amount must be specified');
    }
    return stake(process.argv[3], process.argv[4]);

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
    return stakeTo(process.argv[3], process.argv[4], process.argv[5]);

  case 'stakeAmount':
    if (!process.argv[3]) {
      throw new Error('stakeAmount boxId must be specified');
    }
    if (!process.argv[4]) {
      throw new Error('stakeAmount staker must be specified');
    }
    return stakeAmount(process.argv[3], process.argv[4]);
  default:
    throw new Error('invalid command: ' + cmd);
}

