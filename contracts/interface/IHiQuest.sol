pragma solidity 0.5.6;

interface HiQuest {
  /// @notice emited when Hiqeust is created
  /// @param questId id of created Hiquest
  /// @param manager address of quest manager
  /// @param open quest start time as unix timestamp
  /// @param close quest close time as unix timestamp
  /// @param deposit HiBlocks ERC20 deposit amount
  event HiquestCreated(bytes32 questId, address manager, uint256 open, uint256 close, uint256 deposit);

  /// @notice emited when Hiquest close time is extended
  /// @param questId id of quest
  /// @param close new close time
  event HiquestExtended(bytes32 questId, uint256 close);

  /// @notice emited when manager of quest changed
  /// @param questid id of quest
  /// @param mananger new manager
  event HiqeustManagerChanged(bytes32 questId, address manager);

  /// @notice emited when someone joined quest
  /// @param questId id of quest
  /// @param user address of user
  /// @param desc description of joining quest
  event UserJoined(bytes32 questId, address user, bytes desc);

  /// @notice emited when rewarded
  /// @param questId id of quest
  /// @param to beneficiary of reward
  /// @param amount amount of reward
  event Rewarded(bytes32 questId, address to, uint256 amount);

  /// @notice emited when quest is closed
  /// @param questId id of quest
  event HiquestClosed(bytes32 questId);

  /// @notice emited when manager withdrawed left over deposit
  /// @param questId id of quest
  /// @param amount leftover amount
  event WithDrawn(bytes32 questId, uint256 amount);

  /// @notice create `_questId` quest from `_open` to `_close` and deposits `_deposit`amount of HiBlocks ERC20 token
  /// @dev should have approved this contract to use `_deposit` amount of HiBlocks token
  /// @param _questId quest id to create
  /// @param _open time when quest will start (unix timestamp)
  /// @param _close time whent quest will end (unix timestamp)
  /// @param _deposit amount to deposit for quest
  /// @return success : return true if succeeded
  function create(bytes32 _questId, uint256 _open, uint256 _close, uint256 _deposit) external returns (bool success);

  /// @notice joins `_questId` with given `_desc` message
  /// @param _questId quest id to join
  /// @param _desc description of joining
  /// @return success : return true if succeeded
  function join(bytes32 _questId, bytes calldata _desc) external returns (bool success);

  /// @notice extends `_questId` quest close date for `_time` seconds
  /// @param _questId quest id to extend
  /// @param _time amount of seconds to extend
  /// @return success : return true if succeeded
  function extendCloseTime(bytes32 _questId, uint256 _time) external returns (bool success);

  /// @notice change manager of `_questId` to `_manager`
  /// @dev onlyManager
  /// @param _questId quest id to change manager
  /// @param _manager address of new manager
  /// @return success : return true if succeeded
  function changeManager(bytes32 _questId, uint256 _manager) external returns (bool success);

  /// @notice rewards `_amount` of HiBlocks token to `_to` for joining `_questId` quest 
  /// @dev onlyManager
  /// @param _questId quest id to give reward
  /// @param _to beneficiary of reward
  /// @param _amount amount of reward
  /// @return success : return true if succeeded
  function reward(bytes32 _questId, address _to, uint256 _amount) external returns (bool success);

  /// @notice close `_questId` quest 
  /// @dev onlyManager
  /// @param _questId quest id to close
  /// @return success : return true if succeeded
  function close(bytes32 _questId) external returns (bool success);

  /// @notice withdraws leftover HiBlocks token from `_questId` quest and sends to manager
  /// @dev onlyManager
  /// @param _questId quest id to withdraw from
  /// @return success : return true if succeeded
  function withdrawDeposit(bytes32  _questId) external returns (bool success);

  /// @notice view function to get data of quest
  /// @param _questId id of quest to query
  function questInfo(bytes32 _questId) external view returns(address manager, uint256 open, uint256 close, uint256 deposit, uint256 balance);

  /// @notice view function to get managing questIds
  /// @param _manager address of manager to query
  function managingQuests(address _manager) external view returns(bytes[] quests);

  /// @notice view function to get joined users
  /// @param _questId id of quest to query
  function joinedUsers(bytes32 _questId) external view returns(address[] users);
}
