INSERT IGNORE INTO space
(`id`,
 `amount`,
 `space_id`,
 `space_name`,
 `token_price`)
VALUES
(1,
 6,
 '0x09884e57ffa8b5c27cb7a956feee1a43ce4fe325b7d14f73613c30c016212cc7',
 'firstSpace',
 0.8);

INSERT INTO member_space
(`id`,
    `member_id`,
    `space_id`)
VALUES
(1,
 'MB20200402000002',
 '0x09884e57ffa8b5c27cb7a956feee1a43ce4fe325b7d14f73613c30c016212cc7');
