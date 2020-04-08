const HDWalletProvider = require("truffle-hdwallet-provider-klaytn");

const privateKey = "0x879c00447f38af4d72b2ac870b16fe62b54566d210e1dfa52449f2f90f0e0dc6";
module.exports = {
  plugins: ['solidity-coverage'],
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    testnet: {
      provider: () => new HDWalletProvider(privateKey, "https://api.baobab.klaytn.net:8651"),
        network_id: '1001', //Klaytn baobab testnet's network id
        gas: '8500000',
        gasPrice: null
    },
    mainnet: {
      provider: () => new HDWalletProvider(privateKey, "https://api.cypress.klaytn.net:8651"),
        network_id: '8217', //Klaytn mainnet's network id
        gas: '8500000',
        gasPrice: null
    }
  },

  compilers: {
    solc: {
      version: '0.5.6', // 0.4.26, 0.5.11, 0.6.2
      settings: {
        optimizer: {
          enabled: true,
          runs: 999,
        },
      },
    },
  },
};
