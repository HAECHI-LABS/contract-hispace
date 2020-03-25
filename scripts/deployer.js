const fs = require('fs-extra');
const path = require('path');
const Caver = require('caver-js');

const TokenContractInfo = fs.readJsonSync(path.join(__dirname, '../build/contracts/HiblocksMock.json'));
const QuestInfo = fs.readJsonSync(path.join('../build/contracts/HiQuest.json'));

const chainEndpoint = 'https://api.baobab.klaytn.net:8651';

const caver = new Caver(chainEndpoint);

const HAECHI_KEY =
  '0x75f233d254dd6d2f73dce771f57522c2549a89e5c06321c570b4a521f75c7448'; // 0x80ea9a01043e6575f259e87eefe15db33f69b713
const haechiAccount = {
  address: caver.klay.accounts.privateKeyToAccount(HAECHI_KEY).address,
  secretKey: HAECHI_KEY,
};

async function sendTransaction(account, txOption) {
  const txObject = {
    gasPrice: '25000000000',
    gasLimit: '0x171000',
    from: account.address,
    ...txOption,
  };
  txObject.nonce = await caver.klay.getTransactionCount(account.address);

  const { rawTransaction } = await caver.klay.accounts.signTransaction(
    txObject,
    account.secretKey,
  );
  return caver.klay.sendSignedTransaction(rawTransaction);
}

main();

async function main() {
  const TOKEN_ADDR = "0x08a9D7eF3447335210B392d80A8E12A7ec8F8d8E";
  const QUEST_ADDR = "0x870FCeB0418E5E7f9a096546c76bb62F8c91B5bB";
  const SAVEBOX_ADDR = "0xc6cda41844D38297b4d94d2b88352863c59b7ae6";

  const USER1_ADDR = "0x1119D7eF3447335210B392d80A8E12A7ec8F8111";

  const quest = new caver.klay.Contract(QuestInfo.abi, QUEST_ADDR);
  const data = await quest.methods.questInfo('0xaaa').call();
  console.log(data);
  // let receipt = await sendTransaction(haechiAccount, {
  //   data: masterWalletInfo.bytecode,
  // });
  // const masterWalletTemplate = receipt.contractAddress;

  // const data = await token.methods.balanceOf(haechiAccount.address).call();
  // console.log(data);
  // const result = await sendTransaction(haechiAccount, {
  //   data,
  // });
  // console.log(result);
}
