const { BN } = require('@openzeppelin/test-helpers');

const NAME = 'Hiblocks token';
const SYMBOL = 'HIBS';
const DECIMALS = 18;
const INITIAL_SUPPLY = new BN(40000000000); // Hiblocks tokens
const DEC_LEN = new BN(10).pow(new BN(DECIMALS));
const TOTAL_SUPPLY = new BN(INITIAL_SUPPLY).mul(DEC_LEN);

module.exports = {
  NAME,
  SYMBOL,
  DECIMALS,
  DEC_LEN,
  INITIAL_SUPPLY,
  TOTAL_SUPPLY,
};
