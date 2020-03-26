const Caver = require('caver-js');
const caver = new Caver('https://api.baobab.klaytn.net:8651/');

const Token = require('./hiblocks.json').abi;

// const priv = "0x879c00447f38af4d72b2ac870b16fe62b54566d210e1dfa52449f2f90f0e0dc6"; // taek
const priv = "0x6f993629f0d3836153141053f314286d555b4ac21f14057004c7e900413aa1a3"; // jh

const taek = '0x5399850AB7BFE194FA1594F8051329CcC8aCfd56';
const jh = '0x02c3d28f9d2618f03f8a499774ac28332471ae6a';
const rob = '0x8668103a0091c00b29310cc98112415e5e42c1e8';
const t = '0x50ff7385cd5e834cfdce9ea5fd8fba567538193e';

const address = {
  token : "0xB1CA09Fa5A1f6C7f425421c3c2cc8F8F1F13f4b9",
};

caver.klay.accounts.wallet.add(priv);
const token = new caver.klay.Contract(Token, address.token);

async function approve() {
  const receipt = await token.methods.approve(t, 100).send({
    from: taek,
    gas: 8000000
  });
}

async function allowance() {
  const data = await token.methods.allowance(rob, "0x25dA4faFB42c9a8D853D50A8Dde5353fA8bFC45D").call();
  console.log(data);
}

async function transferFrom() {
  const receipt = await token.methods.transferFrom(
    taek,
    t,
    10
  ).send({
    from: jh,
    gas: 8000000
  });
  console.log(receipt);
}

async function transfer() {
  await token.methods.transfer();
}

async function balanceOf() {
  const data = await token.methods.balanceOf(t).call();
  console.log(data);
}

// allowance();
balanceOf();
// approve();
// transferFrom();
