USE reward_batch;
INSERT IGNORE INTO wallet
(
    `address`,
    `member_id`,
    `name`,
    `transaction_id`,
    `wallet_id`)
VALUES
(
    '0x5399850AB7BFE194FA1594F8051329CcC8aCfd56',
    'MB20200402000002',
    'user1',
    'bdc1239418b7743b33e5c9eeccab284f',
    'user-wallet-1'),
(
    '0x02c3d28f9d2618f03f8a499774ac28332471ae6a',
    'MB20200402000003',
    'user2',
    'bdc1239418b7743b33e5c9eeccab284f',
    'user-wallet-2'),
(
    '0x5ba199b049453802cd3ddaaf45781c8ab31df5e2',
    'MB20200402000004',
    'user3',
    'bdc1239418b7743b33e5c9eeccab284f',
    'user-wallet-3');
