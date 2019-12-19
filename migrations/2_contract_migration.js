const fs = require("fs");
const HispaceActivity = artifacts.require("HispaceActivity");

/************* Hiblocks Token deployed information ***************/
// Baobab - Klaytn
// @see https://baobab.klaytnscope.com/account/0x5c357Eb7f0E9033da2cCCce87caE03718b9Bfc17
const TOKEN_ADDRESS_BAOBAB = "0x5c357Eb7f0E9033da2cCCce87caE03718b9Bfc17";

// Mainnet - Klaytn
// @see https://baobab.klaytnscope.com/account/
const TOKEN_ADDRESS_CYPRESS = "";

function getTokenAddress(network) {
  switch (network) {
    case "development":
    case "baobab":
      return TOKEN_ADDRESS_BAOBAB;
    case "cypress":
      return TOKEN_ADDRESS_CYPRESS;
    default:
      throw new Error("Unknown network!");
  }
}

const HispaceDeployer = (deployer, network, accounts) => {
  deployer
    .deploy(HispaceActivity)
    .then(() => HispaceActivity.deployed())
    .then(instance => {
      console.log(
        `HIBS HispaceActivity contract has been deployed successfully on ${network}.`
      );
      console.log(`contract deployed at ${instance.address}`);
    });
};

module.exports = (deployer, network, accounts) => {
  HispaceDeployer(deployer, network, accounts);
};
