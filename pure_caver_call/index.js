const Caver = require('caver-js');
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const Token = require('./hiblocks.json').abi;
const HiQuest = require('./hiquest.json').abi;

const priv = "0x879c00447f38af4d72b2ac870b16fe62b54566d210e1dfa52449f2f90f0e0dc6";

const address = {
  token : "0xB1CA09Fa5A1f6C7f425421c3c2cc8F8F1F13f4b9",
  quest : "0x25dA4faFB42c9a8D853D50A8Dde5353fA8bFC45D",
};

const questId = "0x82c6e55bd7276a78ee13af33bb0486842d381e4964b398d82eb577c50ec503d0";

caver.klay.accounts.wallet.add(priv);
console.log(caver.klay.accounts.wallet);
const token = new caver.klay.Contract(Token, address.token);
const quest = new caver.klay.Contract(HiQuest, address.quest);
const questId = caver.utils.randomHex(32);
async function create() {
  const receipt = await quest.methods.create(questId, 0, 10000000000, 100).send({from:"0x5399850AB7BFE194FA1594F8051329CcC8aCfd56", gas: 8000000});
  console.log(receipt);
}

create();
