pragma solidity 0.5.6;

import "./interface/IHiQuest.sol";
import "./token/HiblocksIERC20.sol";

contract HiQuest is IHiQuest {
  struct Quest{
    address manager;
    uint256 open;
    uint256 close;
    uint256 deposit;
    uint256 balance;
    bool closed;
  }

  HiblocksIERC20 internal _token;

  mapping (bytes32 => Quest) internal _quests;
  mapping (address => bytes32[]) internal _managing;
  mapping (bytes32 => uint256) internal _managingIndex;
  mapping (bytes32 => mapping(address => bool)) internal _joined;
  mapping (bytes32 => mapping(address => bytes)) internal _joinDesc;
  mapping (bytes32 => address[]) internal _users;
  
  modifier onlyManager(bytes32 _questId) {
    require(msg.sender == _quests[_questId].manager, "Auth/Only Manager can call this function");
    _;
  }

  constructor(address _hiblocks) public {
    require(_hiblocks != address(0), "HiQuest/token address cannot be zero");
    _token = HiblocksIERC20(_hiblocks);
  }

  function create(bytes32 _questId, uint256 _open, uint256 _close, uint256 _deposit) external returns(bool) {
    Quest storage quest = _quests[_questId];
    require(quest.manager != address(0),"Create/Duplicated questId");
    require(_token.transferFrom(msg.sender, address(this), _deposit), "Create/Deposit Error");
    require(_close > now, "Create/Close time should be future");

    quest.manager = msg.sender;
    quest.open = _open;
    quest.close = _close;
    quest.deposit = _deposit;
    quest.balance = _deposit;
    quest.closed = false;
    _managing[msg.sender].push(_questId);
    _managingIndex[_questId] = _managing[msg.sender].length - 1;
    emit HiquestCreated(_questId, msg.sender, _open, _close, _deposit);
    return true;
  }

  function join(bytes32 _questId, bytes calldata desc) external returns(bool) {
    require(!_joined[_questId][msg.sender], "Join/Already Joined");
    Quest memory quest = _quests[_questId];
    require(quest.open < now,"Join/Quest is not opened yet");
    require(quest.close > now || !quest.closed, "Join/Quest is already closed");
    _joined[_questId][msg.sender] = true;
    _joinDesc[_questId][msg.sender] = desc;
    _users[_questId].push(msg.sender);
    emit UserJoined(_questId, msg.sender, desc);
    return true;
  }

  function extend(bytes32 _questId, uint256 _duration) external onlyManager(_questId) returns(bool) {
    require(_duration != 0, "Extend/Duration should be larger than 0");
    Quest storage quest = _quests[_questId];
    require(!quest.closed, "Extend/Quest already closed");
    require(quest.close + _duration > now ,"Extend/Extended close time should be future");
    quest.close = quest.close + _duration;
    require(quest.close > _duration, "Extend/Overflow on close time check duration");
    emit HiquestExtended(_questId, quest.close);
    return true;
  }

  function changeManager(bytes32 _questId, address _manager) external onlyManager(_questId) returns(bool) {
    require(_manager != address(0), "ChangeManager/Manager cannot be zero address");
    _quests[_questId].manager = _manager;
    _deleteFromManaging(_managing[msg.sender], _questId);
    _managing[_manager].push(_questId);
    _managingIndex[_questId] = _managing[_manager].length - 1;
    emit HiquestManagerChanged(_questId, _manager);
    return true;
  }
  
  function reward(bytes32 _questId, address _to, uint256 _amount) external onlyManager(_questId) returns(bool) {
    require(_joined[_questId][_to], "Reward/Cannot reward not joined user");
    Quest storage quest = _quests[_questId];
    require(quest.open < now, "Reward/Quest not opened yet");
    require(quest.balance > quest.balance - _amount, "Reward/Invalid amount of reward");
    _token.transfer(_to, _amount);
    quest.balance = quest.balance - _amount;
    emit Rewarded(_questId, _to, _amount);
    return true;
  }

  function close(bytes32 _questId) external onlyManager(_questId) returns(bool) {
    Quest storage quest = _quests[_questId];
    require(quest.open > now || quest.close < now, "Close/Quest cannot be closed during announced period");
    require(!quest.closed, "Close/Quest already closed");
    quest.closed = true;
    _deleteFromManaging(_managing[msg.sender], _questId);
    emit HiquestClosed(_questId);
    return true;
  }

  function withdrawDeposit(bytes32 _questId) external onlyManager(_questId) returns(bool) {
    Quest memory quest = _quests[_questId];
    require(quest.closed, "Withdraw/Cannot withdraw from not closed quest");
    _token.transfer(msg.sender, quest.balance);
    emit WithDrawn(_questId, quest.balance);
    return true;
  }

  function questInfo(bytes32 _questId) external view returns(address manager, uint256 open, uint256 end, uint256 deposit, uint256 balance) {
    Quest memory quest = _quests[_questId];
    manager = quest.manager;
    open = quest.open;
    end = quest.close;
    deposit = quest.deposit;
    balance = quest.balance;
  }

  function managingQuests(address _manager) external view returns(bytes32[] memory quests) {
    return _managing[_manager];
  }

  function joinedUsers(bytes32 _questId) external view returns(address[] memory users) {
    return _users[_questId];
  }

  function _deleteFromManaging(bytes32[] storage _managed, bytes32 _questId) internal returns (bool) {
    bytes32 lastId = _managed[_managed.length - 1];
    _managed[_managingIndex[_questId]] = lastId;
    _managed.pop();
    _managingIndex[lastId] = _managingIndex[_questId];
    delete _managingIndex[_questId];
    return true;
  }
}
