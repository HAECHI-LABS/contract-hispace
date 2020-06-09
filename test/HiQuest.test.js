const { constants,expectEvent, expectRevert, time, BN } = require('@openzeppelin/test-helpers');
const { ZERO_ADDRESS } = constants;
const { expect } = require('chai');
const _ = require('lodash');

const HiQuest = artifacts.require('HiQuest');
const ERC20 = artifacts.require('HiblocksMock');
let hiquest;
let token;
contract('HiQuest', (account) =>  {
  const [deployer, manager, newManager, winner, user, ...others] = account;
  beforeEach(async ()=>{
    token = await ERC20.new();
    hiquest = await HiQuest.new(token.address);
  });

  describe('#constructor()', ()=>{
    it('should revert if token address is zero address', async ()=>{
      await expectRevert(HiQuest.new(constants.ZERO_ADDRESS), "HiQuest/token address cannot be zero");
    });
  });

  describe('#create()',()=>{
    it('should fail if token transferFrom failed', async ()=>{
      const due = (await time.latest()).add(new BN('100'));
      await expectRevert.unspecified(hiquest.create(web3.utils.randomHex(32), 0, due, new BN('100'), {from:deployer}));
    });

    it('should fail if close time is past', async ()=>{
      const due = (await time.latest()).sub(new BN('100'));
      await token.approve(hiquest.address, new BN('100'), {from:deployer});
      await expectRevert(hiquest.create(web3.utils.randomHex(32), 0, due, new BN('100'), {from:deployer}), "Create/Close time should be future");
    });

    it('should fail if questId is duplicated', async ()=>{
      const due = (await time.latest()).add(new BN('100'));
      const questId = web3.utils.randomHex(32);
      await token.approve(hiquest.address, new BN('100'), {from:deployer});
      await hiquest.create(questId, 0, due, new BN('100'), {from:deployer});
      await expectRevert(hiquest.create(questId, 0, due, new BN('100'), {from:deployer}), "Create/Duplicated questId");
    });

    describe('when create succeeded', ()=>{
      let receipt;
      let questId;
      let due;
      beforeEach(async ()=>{
        due = (await time.latest()).add(new BN('100'));
        questId = web3.utils.randomHex(32);
        await token.approve(hiquest.address, new BN('100'), {from:deployer});
        receipt = await hiquest.create(questId, 0, due, new BN('100'), {from:deployer});
      });

      it('should set assign appropriate values', async ()=>{
        const data = await hiquest.questInfo(questId);
        expect(data.manager).to.be.equal(deployer);
        expect(data.open).to.be.bignumber.equal(new BN('0'));
        expect(data.end).to.be.bignumber.equal(due);
        expect(data.deposit).to.be.bignumber.equal(new BN('100'));
        expect(data.balance).to.be.bignumber.equal(new BN('100'));
      });

      it('should emit HiquestCreated event', async ()=>{
        expectEvent(receipt, 'HiquestCreated', {
          questId: questId,
          manager: deployer,
          open: new BN('0'),
          close: due,
          deposit: new BN('100')
        });
      });

      it('should increase managing quests of manager', async ()=>{
        const managing = await hiquest.managingQuests(deployer);
        expect(managing.length).to.be.equal(1);
        expect(managing[0]).to.be.equal(questId);
      });
    });
  });

  describe('#join()',()=>{
    let receipt;
    let due;
    let questId;
    beforeEach(async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.approve(hiquest.address, new BN('100'), {from:deployer});
      receipt = await hiquest.create(questId, 0, due, new BN('100'), {from:deployer});
    });

    it('should revert if quest does not exists', async ()=>{
      await expectRevert(hiquest.join(web3.utils.randomHex(32), web3.utils.randomHex(32), {from:user}),"Join/Quest does not exist");
    });

    it('should revert if already joined', async ()=>{
      await hiquest.join(questId, web3.utils.randomHex(32), {from:user});
      await expectRevert(hiquest.join(questId, web3.utils.randomHex(32), {from:user}),"Join/Already Joined");
    });

    it('should revert if quest is not opened yet', async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.approve(hiquest.address, new BN('100'), {from:deployer});
      await hiquest.create(questId, due, due.add(new BN('1')), new BN('100'), {from:deployer});
      await expectRevert(hiquest.join(questId, web3.utils.randomHex(32), {from:user}),"Join/Quest is not opened yet");
    });

    it('should revert if quest is already closed', async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.approve(hiquest.address, new BN('100'), {from:deployer});
      await hiquest.create(questId, 0, due, new BN('100'), {from:deployer});
      await time.increase(new BN('1000'));
      await expectRevert(hiquest.join(questId, web3.utils.randomHex(32), {from:user}),"Join/Quest is already closed");
    });

    describe('when join succeeded', async ()=>{
      let receipt;
      let desc;
      beforeEach(async ()=>{
        desc = web3.utils.randomHex(32);
        receipt = await hiquest.join(questId, desc, {from:user});
      });

      it('should add to joined user list', async ()=>{
        const users = await hiquest.joinedUsers(questId);
        expect((users.filter(x => x == user)).length).to.be.equal(1);
      });

      it('should emit UserJoined event', async ()=>{
        expectEvent(receipt, 'UserJoined', {
          questId: questId,
          user: user,
          desc: desc
        });
      });
    });
  });

  describe('#changeManager()', ()=>{
    let due;
    let questId;
    beforeEach(async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.transfer(manager, new BN('100'), {from:deployer});
      await token.approve(hiquest.address, new BN('100'), {from:manager});
      await hiquest.create(questId, 0, due, new BN('100'), {from:manager});
    });

    it('should revert if msg.sender is not manager', async ()=>{
      await expectRevert(hiquest.changeManager(questId, newManager, {from:others[0]}), "Auth/Only Manager can call this function");
    });

    it('should fail if _manager is zero address', async ()=>{
      await expectRevert(hiquest.changeManager(questId, constants.ZERO_ADDRESS, {from:manager}), "ChangeManager/Manager cannot be zero address");
    });

    describe('when changeManager succeeded', ()=>{
      let quests;
      beforeEach(async ()=>{
        for(let i=0; i<10; i++){
          due = (await time.latest()).add(new BN('100'));
          questId = web3.utils.randomHex(32);
          await token.transfer(manager, new BN('100'), {from:deployer});
          await token.approve(hiquest.address, new BN('100'), {from:manager});
          await hiquest.create(questId, 0, due, new BN('100'), {from:manager});
        }
        quests = await hiquest.managingQuests(manager);
      });

      it('should remove properly from old manager\'s managing list', async ()=>{
        const pops = Math.floor(Math.random() * quests.length);
        let tempQuests = quests;
        for(let i=0; i<pops; i++){
          const index = Math.floor(Math.random() * tempQuests.length);
          var questId = tempQuests[index];
          await hiquest.changeManager(questId, newManager, {from:manager});
          const newlist = await hiquest.managingQuests(manager);
          const last = tempQuests[ tempQuests.length - 1];
          tempQuests[index] = last;
          tempQuests.pop();
          assert.equal(_.intersection(tempQuests, newlist).length, tempQuests.length);
          assert.equal(_.intersection(tempQuests, newlist).length, newlist.length);
        }
      });

      it('should add properly to new manager\'s managing list', async ()=>{
        const pops = Math.floor(Math.random() * quests.length);
        let tempQuests = quests;
        for(let i=0; i<pops; i++){
          var questId = tempQuests[Math.floor(Math.random() * tempQuests.length)];
          await hiquest.changeManager(questId, newManager, {from:manager});
          const newlist = await hiquest.managingQuests(newManager);
          expect((newlist.filter(x => x== questId)).length).to.be.equal(1);
          tempQuests = await hiquest.managingQuests(manager);
        }
      });

      it('should emit HiquestManagerChanged event', async ()=>{
        receipt = await hiquest.changeManager(quests[3], newManager, {from:manager});
        expectEvent(receipt, 'HiquestManagerChanged', {
          questId: quests[3],
          manager: newManager
        });
      });
    });
  });

  describe('#reward()', ()=>{
    let due;
    let questId;
    beforeEach(async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.transfer(manager, new BN('100'), {from:deployer});
      await token.approve(hiquest.address, new BN('100'), {from:manager});
      await hiquest.create(questId, 0, due, new BN('100'), {from:manager});
      await hiquest.join(questId, web3.utils.randomHex(32), {from:winner});
    });

    it('should fail if msg.sender is not manager', async ()=>{
      await expectRevert(hiquest.reward(questId, winner, new BN('100'), {from:others[0]}), "Auth/Only Manager can call this function");
    });

    it('should fail if quest is not opened yet', async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.transfer(manager, new BN('100'), {from:deployer});
      await token.approve(hiquest.address, new BN('100'), {from:manager});
      await hiquest.create(questId, due.sub(new BN('1')), due, new BN('100'), {from:manager});
      await expectRevert(hiquest.reward(questId, winner, new BN('100'), {from:manager}), "Reward/Quest not opened yet");
    });

    it('should fail if beneficiary has not joined', async ()=>{
      await expectRevert(hiquest.reward(questId, others[0], new BN('100'), {from:manager}), "Reward/Cannot reward not joined user");
    });

    it('should fail if amount is larger than quest balance', async ()=>{
      await expectRevert(hiquest.reward(questId, winner, new BN('101'), {from:manager}), "Reward/Invalid amount of reward");
    });

    describe('when reward succeeded', ()=>{
      let receipt;
      beforeEach(async ()=>{
        receipt = await hiquest.reward(questId, winner, new BN('80'), {from:manager});
      });

      it('should decrease quest balance by amount', async ()=>{
        const info = await hiquest.questInfo(questId);
        expect(info.balance).to.be.bignumber.equal(info.deposit.sub(new BN('80')));
      });

      it('should increase recipient\'s token balance', async ()=>{
        const balance = await token.balanceOf(winner);
        expect(balance).to.be.bignumber.equal(new BN('80'));
      });

      it('should emit Rewarded event', async ()=>{
        expectEvent(receipt, 'Rewarded', {
          questId: questId,
          to: winner,
          amount: new BN('80')
        });
      });
    });
  });

  describe('#close()', ()=>{
    let due;
    let questId;
    beforeEach(async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.transfer(manager, new BN('100'), {from:deployer});
      await token.approve(hiquest.address, new BN('100'), {from:manager});
      await hiquest.create(questId, 0, due, new BN('100'), {from:manager});
    });

    it('should fail if msg.sender is not manager', async ()=>{
      await time.increaseTo(due.add(new BN('100')));
      await expectRevert(hiquest.close(questId, {from:others[0]}),"Auth/Only Manager can call this function");
    });

    it('should fail if quest is still on-going', async ()=>{
      await time.increaseTo(due.sub(new BN('80')));
      await expectRevert(hiquest.close(questId, {from:manager}),"Close/Quest cannot be closed during announced period");
    });

    it('should fail if quest is already closed', async ()=>{
      await time.increaseTo(due.add(new BN('110')));
      await hiquest.close(questId, {from:manager});
      await expectRevert(hiquest.close(questId, {from:manager}),"Close/Quest already closed");
    });

    describe('when close succeeded', ()=>{
      let receipt;
      beforeEach(async ()=>{
        await time.increaseTo(due.add(new BN('100')));
        receipt = await hiquest.close(questId, {from:manager});
      });

      it('should set quest\'s closed value to true', async ()=>{
        const info = await hiquest.questInfo(questId);
        expect(info.closed).to.be.equal(true);
      });

      it('should emit HiquestClosed event', async ()=>{
        expectEvent(receipt, 'HiquestClosed', {questId:questId});
      });
    });
  });

  describe('#withdrawDeposit()', ()=>{
    let due;
    let questId;
    let balanceBefore;
    beforeEach(async ()=>{
      due = (await time.latest()).add(new BN('100'));
      questId = web3.utils.randomHex(32);
      await token.transfer(manager, new BN('100'), {from:deployer});
      await token.approve(hiquest.address, new BN('100'), {from:manager});
      await hiquest.create(questId, 0, due, new BN('100'), {from:manager});
      balanceBefore = (await hiquest.questInfo(questId)).balance;
    });

    it('should fail if msg.sender is not manager', async ()=>{
      await time.increaseTo(due.add(new BN('100')));
      await hiquest.close(questId, {from:manager});
      await expectRevert(hiquest.withdrawDeposit(questId, {from:others[0]}), "Auth/Only Manager can call this function");
    });

    it('should fail if quest is not closed', async ()=>{
      await expectRevert(hiquest.withdrawDeposit(questId, {from:manager}), "Withdraw/Cannot withdraw from not closed quest");
    });

    describe('when withdrawal succeeded', ()=>{
      let receipt;
      beforeEach(async ()=>{
        await time.increaseTo(due.add(new BN('100')));
        await hiquest.close(questId, {from:manager});
        receipt = await hiquest.withdrawDeposit(questId, {from:manager});
      });

      it('should set quest\'s balance to zero', async ()=>{
        const info = await hiquest.questInfo(questId);
        expect(info.balance).to.be.bignumber.equal(new BN(0));
      });

      it('should emit WithDrawn event', async ()=>{
        expectEvent(receipt, 'WithDrawn', {
          questId: questId,
          amount: balanceBefore
        });
      });
    });
  });
});
