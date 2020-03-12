const fs = require('fs-extra');
const path = require('path');
const Caver = require('caver-js');

const walletFactoryInfo = fs.readJsonSync(path.join(__dirname, '../build/contracts/WalletFactory.json'));
const masterWalletInfo = fs.readJsonSync(path.join(__dirname, '../build/contracts/HenesisMasterWallet.json'));
const userWalletInfo = fs.readJsonSync(path.join(__dirname, '../build/contracts/HenesisUserWallet.json'));
const registryInfo = fs.readJsonSync(path.join(__dirname, '../build/contracts/WalletRegistry.json'));

const chainEndpoint = 'https://api.baobab.klaytn.net:8651';
console.log(chainEndpoint);
const caver = new Caver(chainEndpoint);

const HAECHI_KEY =
  '0x52516c2b22a19f8cfaa918b9d33e5c7682d212c831e22b1f2c2336f7186dcf9e'; // 0x80ea9a01043e6575f259e87eefe15db33f69b713
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
  let receipt = await sendTransaction(haechiAccount, {
    data: masterWalletInfo.bytecode,
  });
  const masterWalletTemplate = receipt.contractAddress;
  console.log('Master Wallet Template Address: ' + masterWalletTemplate);
  receipt = await sendTransaction(haechiAccount, {
    data: userWalletInfo.bytecode,
  });
  const userWalletTemplate = receipt.contractAddress;
  console.log('User Wallet Template Address: ' + userWalletTemplate);
  receipt = await sendTransaction(haechiAccount, {
    data: registryInfo.bytecode,
  });
  const registryTemplate = receipt.contractAddress;
  console.log('Registry Template Address: ' + registryTemplate);

  const deployData = (new caver.klay.Contract(walletFactoryInfo.abi)).deploy({
    data: walletFactoryInfo.bytecode,
    arguments: [registryTemplate, masterWalletTemplate, userWalletTemplate]
  }).encodeABI();
  receipt = await sendTransaction(haechiAccount, {
    data: deployData,
  });
  console.log('Factory Address: ' + receipt.contractAddress);
}
