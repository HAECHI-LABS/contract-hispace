#!/usr/bin/env bash

rm -rf ./build/
mkdir ./build

truffle compile

web3j truffle generate ./build/contracts/HenesisMasterWallet.json -o ../wallet/src/main/java -p io.haechi.henesis.wallet
web3j truffle generate ./build/contracts/HenesisUserWallet.json -o ../wallet/src/main/java -p io.haechi.henesis.wallet
web3j truffle generate ./build/contracts/HenesisWalletFactory.json -o ../wallet/src/main/java -p io.haechi.henesis.wallet
web3j truffle generate ./build/contracts/MultiSig.json -o ../wallet/src/main/java -p io.haechi.henesis.wallet
