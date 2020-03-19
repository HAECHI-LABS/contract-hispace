pragma solidity 0.5.6;


///@title SaveBox Contract for staking
///@author taek lee <taeklee@haechi.io>
///@notice Staking by individual and by Box is available on this Contract
///@dev bytes32(0) is boxId of individual stake
interface ISaveBox {
    /// @notice emited when Box is created
    /// @dev boxId is Calculated in createBox() function
    /// @param boxId keccak256(creator, nonce[creator])
    /// @param creator address of creator
    event BoxCreated(bytes32 boxId, address creator);

    /// @notice emited when Box is destroyed
    /// @param boxId id of destroyed Box
    event BoxDestroyed(bytes32 boxId);

    /// @notice emited when someone staked
    /// @dev if boxId == bytes32(0), it is individual stake
    /// @param boxId id of staked box
    /// @param staker address of staker
    /// @param amount stake amount
    event Stake(bytes32 boxId, address staker, uint256 amount);

    /// @notice emited when someone unstaked
    /// @dev if boxId == bytes32(0), it is individual stake
    /// @param boxId id of staked box
    /// @param staker address of unstaker
    /// @param amount amount of unstaked token
    event Unstake(bytes32 boxId, address staker, uint256 amount);

    /// @notice creates box
    /// @dev anyone can call this function
    /// @return boxId : keccak256(msg.sender, nonce[creator])
    function createBox() external returns (bytes32 boxId);

    /// @notice stake `_amount` of token to `_boxId`
    /// @dev _boxId cannot be bytes32(0) it is assigned to individual staking
    /// @param _boxId id of staking box
    /// @param _amount amount to stake
    /// @return success true if succeeded
    function stakeTo(bytes32 _boxId, uint256 _amount) external returns (bool);

    /// @notice unstake from `_boxId` box
    /// @dev _boxId cannot be bytes32(0) it is assigned to individual staking
    /// @param _boxId id of unstaking box
    /// @return success true if succeeded
    function unstakeFrom(bytes32 _boxId) external returns (bool);

    /// @notice destroy `_boxId` box
    /// @dev cannot destroy if there is stake left
    /// @param _boxId id of box to destroy
    /// @return succeess true if succeeded
    function destroyBox(bytes32 _boxId) external returns (bool);

    /// @notice stake `_amount` token for individual staking
    /// @param _amount amount to stake
    /// @return success true if succeeded
    function stake(uint256 _amount) external returns (bool);

    /// @notice unstake all token staked as individual staking
    /// @return success true if succeeded
    function unstake() external returns (bool);

    /// @notice returns stake amount of `_staker` at `_boxId`
    /// @dev _boxId is bytes32(0), for individual staking
    /// @return amount of stake
    function stakeAmount(bytes32 _boxId, address _staker) external view returns (uint256);

    /// @notice returns save box info of `_boxId` box
    /// @param _boxId id of box to query
    /// @return creator : address of box creator
    /// @return createdAt : second of created time as unix timestamp
    /// @return balance : total amount of stake
    /// @return destroyed : true if destroyed
    function boxInfo(bytes32 _boxId) external view returns (address creator, uint256 createdAt, uint256 balance, bool destroyed);
}
