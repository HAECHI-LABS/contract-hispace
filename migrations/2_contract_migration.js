const fs = require("fs");
const HiQuest = artifacts.require("HiQuest");
const Token = artifacts.require("HiblocksMock");
module.exports = (deployer, network, accounts) => {
  let token;
  let quest;
  deployer.then( async ()=>{
    token = await deployer.deploy(Token);
  }).then(async()=>{
    quest = await deployer.deploy(HiQuest, token.address);
    await token.approve(quest.address, -1);
    const receipt = await quest.create(web3.utils.randomHex(32), 0, 10000000000, 100);
    console.log(receipt.logs[0].args);
  });
};
