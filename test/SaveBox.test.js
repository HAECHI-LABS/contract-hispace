const { constants,expectEvent, expectRevert, time, BN } = require('@openzeppelin/test-helpers');
const { ZERO_ADDRESS } = constants;
const { expect } = require('chai');
const _ = require('lodash');

const SaveBox = artifacts.require('SaveBox');
const ERC20 = artifacts.require('HiblocksMock');
const utils = require('./utils');
let saveBox;
let token;

function randomHex() {
  return web3.utils.randomHex(32);
}

contract('SaveBox', (account) =>  {
  const [deployer, creator, staker, ...others] = account;
  beforeEach(async ()=>{
    token = await ERC20.new();
    saveBox = await SaveBox.new(token.address);
  });

  describe('#constructor()', ()=>{
    it('should revert if token address is zero address', async ()=>{
      await expectRevert(SaveBox.new(constants.ZERO_ADDRESS), "SaveBox/token address cannot be zero");
    });
  });

  describe('#createBox()', ()=>{
    let receipt;
    let boxId;
    beforeEach(async ()=>{
      receipt = await saveBox.createBox(randomHex(), {from:creator});
      boxId = utils.getEventArgs(receipt, 'BoxCreated').boxId;
    });

    it('should fail if _boxId is zero', async ()=>{
      await expectRevert(saveBox.createBox(web3.utils.toHex(0), {from:creator}), "Create/Cannot create 0 boxId");
    });

    it('should fail if _boxId is zero', async ()=>{
      await expectRevert(saveBox.createBox(boxId, {from:creator}), "Create/Box Id already exist");
    });

    it('should set creator as msg.sender', async ()=>{
      const box = await saveBox.boxInfo(boxId);
      expect(box.creator).to.be.equal(creator);
    });

    it('should emit BoxCreated event', async ()=>{
      expectEvent(receipt, 'BoxCreated', {
        boxId: boxId,
        creator: creator
      });
    });
  });

  describe('#destroyBox()', ()=>{
    let boxId;
    const amount = new BN('100');
    beforeEach(async ()=>{
      const receipt = await saveBox.createBox(randomHex(), {from:creator});
      boxId = utils.getEventArgs(receipt, 'BoxCreated').boxId;
      await token.transfer(staker, amount, {from:deployer});
      await token.approve(saveBox.address, amount, {from:staker});
      await saveBox.stakeTo(boxId, amount, {from:staker});
    });

    it('should fail if msg.sender is not creator', async ()=>{
      await saveBox.unstakeFrom(boxId, amount, {from:staker});
      await expectRevert(saveBox.destroyBox(boxId, {from:staker}), "Destroy/Only creator can destroy box");
    });

    it('should fail if box has balance', async ()=>{
      await expectRevert(saveBox.destroyBox(boxId, {from:creator}), "Destroy/Cannot destroy when box has balance");
    });

    describe('when destroy succeeded', ()=>{
      let receipt;
      beforeEach(async()=>{
        await saveBox.unstakeFrom(boxId, amount, {from:staker});
        receipt = await saveBox.destroyBox(boxId, {from:creator});
      });

      it('should mark box as destoryed', async ()=>{
        expect((await saveBox.boxInfo(boxId)).destroyed).to.be.equal(true);
      });

      it('should emit BoxDestroyed event', async ()=>{
        expectEvent(receipt, 'BoxDestroyed', {
          boxId: boxId
        });
      });
    });
  });

  describe('#stakeTo()', ()=>{
    let boxId;
    const amount = new BN('100');
    beforeEach(async ()=>{
      const receipt = await saveBox.createBox(randomHex(), {from:creator});
      boxId = utils.getEventArgs(receipt, 'BoxCreated').boxId;
      await token.transfer(staker, amount.mul(new BN(2)), {from:deployer});
      await token.approve(saveBox.address, amount, {from:staker});
    });

    it('should fail if box is not created yet', async ()=>{
      await expectRevert(saveBox.stakeTo(web3.utils.randomHex(32), amount, {from:staker}),"StakeTo/Box does not exist");
    });

    it('should fail if token transfer failed', async ()=>{
      await expectRevert.unspecified(saveBox.stakeTo(boxId, amount.add(new BN(1)), {from:staker}));
    });

    it('should fail if box is already destroyed', async ()=>{
      await saveBox.destroyBox(boxId, {from:creator});
      await expectRevert(saveBox.stakeTo(boxId, amount, {from:staker}), "StakeTo/Box is destroyed");
    });

    describe('when stake succeeded', ()=>{
      let receipt;
      let box;
      beforeEach(async ()=>{
        receipt = await saveBox.stakeTo(boxId, amount, {from:staker});
        box = await saveBox.boxInfo(boxId);
      });

      it('should increase box balance', async ()=>{
        expect(box.balance).to.be.bignumber.equal(amount);
      });

      it('should increase individual stake amount', async ()=>{
        expect(await saveBox.stakeAmount(boxId, staker)).to.be.bignumber.equal(amount);
      });
      it('should emit Stake event', async ()=>{
        expectEvent(receipt, 'Stake', {
          boxId: boxId,
          staker: staker,
          amount: amount
        });
      });
    });
  });

  describe('#unstakeFrom()', ()=>{
    let boxId;
    const amount = new BN('100');
    const unstakeAmount = new BN('20');
    beforeEach(async ()=>{
      const receipt = await saveBox.createBox(randomHex(), {from:creator});
      boxId = utils.getEventArgs(receipt, 'BoxCreated').boxId;
      await token.transfer(staker, amount.mul(new BN(2)), {from:deployer});
      await token.approve(saveBox.address, amount, {from:staker});
      await saveBox.stakeTo(boxId, amount, {from:staker});
    });

    it('should fail if box is not created yet', async ()=>{
      await expectRevert(saveBox.unstakeFrom(web3.utils.randomHex(32), unstakeAmount, {from:staker}),"UnstakeFrom/Box does not exist");
    });

    it('should fail if unstakeAmount is larger than stake amount', async ()=>{
      await expectRevert(saveBox.unstakeFrom(boxId, amount.addn(1), {from:staker}), "Unstake/Can't unstake more than stake amount");
    });

    it('should fail if box is already destroyed', async ()=>{
      await saveBox.unstakeFrom(boxId, amount, {from:staker});
      await saveBox.destroyBox(boxId, {from:creator});
      await expectRevert(saveBox.unstakeFrom(boxId, unstakeAmount, {from:staker}), "UnstakeFrom/Box is destroyed");
    });

    describe('when unstake succeeded', ()=>{
      let receipt;
      let box;
      beforeEach(async ()=>{
        receipt = await saveBox.unstakeFrom(boxId, unstakeAmount, {from:staker});
        box = await saveBox.boxInfo(boxId);
      });

      it('should decrease box balance', async ()=>{
        expect(box.balance).to.be.bignumber.equal(amount.sub(unstakeAmount));
      });

      it('should set stake amount to zero', async ()=>{
        expect(await saveBox.stakeAmount(boxId, staker)).to.be.bignumber.equal(amount.sub(unstakeAmount));
      });

      it('should emit Unstake event', async ()=>{
        expectEvent(receipt, 'Unstake', {
          boxId: boxId,
          staker: staker,
          amount: unstakeAmount
        });
      });
    });
  });

  describe('#stake()', ()=>{
    const amount = new BN('100');
    let boxId = web3.utils.padLeft(0x00, 64);
    beforeEach(async ()=>{
      await token.transfer(staker, amount.mul(new BN(2)), {from:deployer});
      await token.approve(saveBox.address, amount, {from:staker});
    });

    it('should fail if token transfer failed', async ()=>{
      await expectRevert.unspecified(saveBox.stake(amount.add(new BN(1)), {from:staker}));
    });

    describe('when stake succeeded', ()=>{
      let receipt;
      let box;
      beforeEach(async ()=>{
        receipt = await saveBox.stake(amount, {from:staker});
        box = await saveBox.boxInfo(boxId);
      });

      it('should increase box balance', async ()=>{
        expect(box.balance).to.be.bignumber.equal(amount);
      });

      it('should increase individual stake amount', async ()=>{
        expect(await saveBox.stakeAmount(boxId, staker)).to.be.bignumber.equal(amount);
      });
      it('should emit Stake event', async ()=>{
        expectEvent(receipt, 'Stake', {
          boxId: boxId,
          staker: staker,
          amount: amount
        });
      });
    });
  });

  describe('#unstake()', ()=>{
    let boxId = web3.utils.padLeft(0x00, 64);
    const amount = new BN('100');
    beforeEach(async ()=>{
      const receipt = await saveBox.createBox(randomHex(), {from:creator});
      await token.transfer(staker, amount.mul(new BN(2)), {from:deployer});
      await token.approve(saveBox.address, amount, {from:staker});
      await saveBox.stake( amount, {from:staker});
    });

    it('should fail if unstakeAmount is larger than stake amount', async ()=>{
      await expectRevert(saveBox.unstake(amount.addn(1), {from:staker}), "Unstake/Can't unstake more than stake amount");
    });

    describe('when unstake succeeded', ()=>{
      let receipt;
      let box;
      const unstakeAmount = new BN('20');
      beforeEach(async ()=>{
        receipt = await saveBox.unstake( unstakeAmount, {from:staker});
        box = await saveBox.boxInfo(boxId);
      });

      it('should decrease box balance', async ()=>{
        expect(box.balance).to.be.bignumber.equal(amount.sub(unstakeAmount));
      });

      it('should set stake amount to zero', async ()=>{
        expect(await saveBox.stakeAmount(boxId, staker)).to.be.bignumber.equal(amount.sub(unstakeAmount));
      });

      it('should emit Unstake event', async ()=>{
        expectEvent(receipt, 'Unstake', {
          boxId: boxId,
          staker: staker,
          amount: unstakeAmount
        });
      });
    });
  });
});
