const fs = require("fs");
const HiQuest = artifacts.require("HiQuest");
const Token = artifacts.require("HiblocksToken");
const Activity = artifacts.require("HispaceActivity");
const SaveBox = artifacts.require("SaveBox");
const RewardSupplier = artifacts.require("RewardSupplier");
const RewardPool = artifacts.require("RewardPool");

module.exports = (deployer, network, accounts) => {
  let token;
  let quest;
  let activity;
  let savebox;
  let supplier;
  let pool;
  deployer.then( async ()=>{
    if(network == 'testnet'){
      token = await deployer.deploy(Token,"Hiblocks","HIBS",18, 1000000000000);
    }
    else if(network == 'mainnet'){
      console.log("Using mainnet... Token Contract Address :0xE06b40df899b9717b4E6B50711E1dc72d08184cF");
      token = await Token.at('0xE06b40df899b9717b4E6B50711E1dc72d08184cF');
    }
  }).then(async()=>{
    quest = await deployer.deploy(HiQuest, token.address);
    //test create quest
    //needs token approved to quest
    await token.approve(quest.address, -1);
    const receipt = await quest.create(web3.utils.randomHex(32), 0, 10000000000, 100);
    //represents quest creation
    console.log(receipt.logs[0].args);
  }).then(async () => {
    savebox = await deployer.deploy(SaveBox, token.address);
    //test create savebox
    //needs token approved to quest
    await token.approve(savebox.address, -1);
    const receipt = await savebox.createBox();
    //represents savebox creation
    console.log(receipt.logs[0].args);
  }).then(async ()=>{
    //deploy HispaceActivity
    activity = await deployer.deploy(Activity);
  }).then(async ()=>{
    pool = await deployer.deploy(RewardPool, token.address);
  }).then(async ()=>{
    //deploy RewardSupplier
    supplier = await deployer.deploy(RewardSupplier,token.address,accounts[0],1000, 1586498400);
    await token.transfer(supplier.address, 1000, {from:accounts[0]});
  });
};
