const fs = require("fs");
const HiQuest = artifacts.require("HiQuest");

module.exports = (deployer, network, accounts) => {
  deployer.deploy(HiQuest, accounts[0]);
};
