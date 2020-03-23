const fs = require("fs");
const HiQuest = artifacts.require("HiQuest");
const Token = artifacts.require("HiblocksToken");
const Activity = artifacts.require("HispaceActivity");
const SaveBox = artifacts.require("SaveBox");

module.exports = (deployer, network, accounts) => {
  let token;
  let quest;
  let activity;
  let savebox;

  deployer.then( async ()=>{
    token = await deployer.deploy(Token,"Hiblocks","HIBS",18, 1000000000000);
  }).then(async()=>{
    quest = await deployer.deploy(HiQuest, token.address);
    await token.approve(quest.address, -1);
    const receipt = await quest.create(web3.utils.randomHex(32), 0, 10000000000, 100);
    console.log(receipt.logs[0].args);
  });
};
