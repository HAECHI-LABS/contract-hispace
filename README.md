# contract-hispace
Smart-contracts for Hiblocks platform

## Deployment - Kalytn
1. First uncomment the deployer function corresponds to the contract you want to deploy and comment out all the others in `migrations/2_contract_migration.js` file.
2. If the project folder includes `build` folder, first delete it
3. Compile the corresponding contract as follows;
`truffle compile`
4. Set privatekey words for deployer in your command line as follows;
`export PRIVATEKEY="<private_key>"`
5. Finally deploy the contract on the network you desire
`truffle migrate --network <network_name>`


## Openzeppelin's Upgradable Contracts Deployment
1. Once you have installed node, you can install the OpenZeppelin SDK CLI:
    - `npm install --global @openzeppelin/cli`
2. Let’s now use the CLI to initialize a OpenZeppelin SDK project:
    - `openzeppelin init` or `oz init`
3. We can now deploy our contract there, running openzeppelin create, and choosing to deploy the Counter contract to the development network.
    - `oz create`
4. We can test it out by interacting with it from the terminal. Let’s try incrementing the counter, by sending a transaction to call the increase function through openzeppelin send-tx.
    - `openzeppelin send-tx`
5. See Openzeppelin SDK Quickstart guide : https://docs.openzeppelin.com/sdk/2.6/first


## Test
* In order to run the whole tests
`truffle test`
* In order to run only specific test file

visit homepage : https://hiblocks.io

try the hiblocks : https://hispace.hiblocks.io
