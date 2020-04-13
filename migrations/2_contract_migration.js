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
  if(network == 'development'){}
  else{
  deployer.then( async ()=>{
    if(network == 'testnet'){
      console.log("Using testnet... Token Contract Address :0xB1CA09Fa5A1f6C7f425421c3c2cc8F8F1F13f4b9");
      token = await Token.at('0xB1CA09Fa5A1f6C7f425421c3c2cc8F8F1F13f4b9');
    }
    else if(network == 'mainnet'){
      console.log("Using mainnet... Token Contract Address :0xE06b40df899b9717b4E6B50711E1dc72d08184cF");
      token = await Token.at('0xE06b40df899b9717b4E6B50711E1dc72d08184cF');
    } else {
      token = await deployer.deploy(Token, "Hiblocks", "HIB", 18, 1000);
    }
  }).then(async()=>{
    quest = await deployer.deploy(HiQuest, token.address);
    //test create quest
    //needs token approved to quest
    await token.approve(quest.address, -1);
    const receipt = await quest.create(web3.utils.randomHex(32), 0, 10000000000, 100);
    //represents quest creation
    quest.questId = receipt.logs[0].args.questId;
    console.log(quest.questId);
  }).then(async () => {
    savebox = await deployer.deploy(SaveBox, token.address);
    //test create savebox
    //needs token approved to quest
    await token.approve(savebox.address, -1);
    const receipt = await savebox.createBox();
    //represents savebox creation
    savebox.boxId = receipt.logs[0].args.boxId;
    console.log(savebox.boxId);
  }).then(async ()=>{
    //deploy HispaceActivity
    activity = await deployer.deploy(Activity);
  }).then(async ()=>{
    pool = await deployer.deploy(RewardPool, token.address);
  }).then(async ()=>{
    //deploy RewardSupplier
    supplier = await deployer.deploy(RewardSupplier,token.address,accounts[0],1000, 1586498400);
    await token.transfer(supplier.address, 1000, {from:accounts[0]});
  }).then(async ()=>{
    let addresses = {
      token: token.address,
      quest: quest.address,
      savebox: savebox.address,
      activity: activity.address,
      pool: pool.address,
      supplier: supplier.address,
      questId: quest.questId,
      boxId: savebox.boxId,
    };
    fs.writeFileSync(__dirname + '/../migrationResults.json', JSON.stringify(addresses,null,2));
  });
  }
};
