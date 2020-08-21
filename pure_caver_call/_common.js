const fs = require('fs');

const eoa = {
  taek: '0x5399850AB7BFE194FA1594F8051329CcC8aCfd56',
  jh: '0x02c3d28f9d2618f03f8a499774ac28332471ae6a',
  jh2: '0x5ba199b049453802cd3ddaaf45781c8ab31df5e2',
  rob: '0x8668103a0091c00b29310cc98112415e5e42c1e8',
  rob2: '0xc54dda7182474f2b59a575124024d99c20e346d4',
  walletKey: '0x673d403b89d488bada09f707abcb6b78f5dd3d03',
  bob: '0xf9fca19c207842710e59044f8ef44f9a0e87c55d',
  moon: '0x5c0B92e008dB923a5DB1127FbEf24b67843d54c8',
};

const priv = {
  taek: '0x879c00447f38af4d72b2ac870b16fe62b54566d210e1dfa52449f2f90f0e0dc6',
  jh: '0x6f993629f0d3836153141053f314286d555b4ac21f14057004c7e900413aa1a3',
  jh2: '0x4e14bc6830f930daa8cefef30e60f86971265724dec969fd071a68929d5ae7a8'
};

const contract = {
  token: '0x0e6984E470BcC67c9C008F921DCb44a7B252f298',
  savebox: '0x992C4c77573ca6A95a8834237bF08a74295ED3Ec',
  rewardpool: '0xeBd125d9E387909Fe31487Ca38f309618301c29B',
  rewardsupplier: '0xdA6f940A8CC3e95F7f39df0aF9cdCf4CF05F26D2',
  quest: '0x9783d396F9970DB7f6e79BeB0D55d9FC85282e94',
};

const savebox = {
  '1': '0x89238b7e79c68552488a19ab08fe4d921c7ff83b957d94ee4c61776ddf4c61b3'
};

module.exports.eoa = eoa;

module.exports.contract = contract;

module.exports.priv = priv;

module.exports.logging = function(json, cmd) {
  fs.appendFileSync('./history.log', cmd +'\n' + JSON.stringify(json, null, 2) + '\n')
}
