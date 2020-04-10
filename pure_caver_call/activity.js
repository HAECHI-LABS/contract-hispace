const Caver = require('caver-js');
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const Activity = require('../build/contracts/HispaceActivity.json').abi;

// const priv = "0x879c00447f38af4d72b2ac870b16fe62b54566d210e1dfa52449f2f90f0e0dc6"; // taek
const priv = "0x6f993629f0d3836153141053f314286d555b4ac21f14057004c7e900413aa1a3"; // jh

const taek = '0x5399850AB7BFE194FA1594F8051329CcC8aCfd56';
const jh = '0x02c3d28f9d2618f03f8a499774ac28332471ae6a';
const rob = '0x8668103a0091c00b29310cc98112415e5e42c1e8';

const address = {
  activity: "0x30f91383681db56a6151aF4FE1BFCD0A4f58A522",
};

caver.klay.accounts.wallet.add(priv);
const token = new caver.klay.Contract(Activity);

async function find() {
  const receipt = await token.methods.approve(jh, 100).send({
    from: taek,
    gas: 8000000
  });
}


async function balanceOf() {
  const data = await token.methods.balanceOf(jh).call();
  console.log(data);
}

balanceOf();
// approve();
// transferFrom();
