const fs = require("fs");
const RewardPool = artifacts.require("RewardPool");

const contract = require('../pure_caver_call/_common').contract;

module.exports = (deployer) => {
  deployer.then( async ()=>{
    await deployer.deploy(RewardPool, contract.token);
  });
};
