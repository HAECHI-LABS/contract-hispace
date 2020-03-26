const fs = require("fs");
const Activity = artifacts.require("HispaceActivity");

module.exports = (deployer) => {
  deployer.then( async ()=>{
    await deployer.deploy(Activity);
  });
};
