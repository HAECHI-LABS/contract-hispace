pragma solidity 0.5.6;

import "./interface/ISaveBox.sol";
import "./token/HiblocksIERC20.sol";

contract SaveBox is ISaveBox {

    struct Box {
        address creator;
        uint256 createdAt;
        uint256 balance;
        bool destroyed;
    }

    HiblocksIERC20 internal _token;

    mapping(address => uint256) _nonce;

    mapping(bytes32 => Box) _box;
    mapping(bytes32 => mapping(address=>uint256)) _stake;

    constructor(address _tokenAddr) public {
        require(_tokenAddr != address(0), "SaveBox/token address cannot be zero");
        _token = HiblocksIERC20(_tokenAddr);
    }

    function createBox() external returns (bytes32 _boxId) {
        _boxId = keccak256(abi.encodePacked(msg.sender, _nonce[msg.sender]));
        Box storage box = _box[_boxId];
        box.creator = msg.sender;
        box.createdAt = now;
        _nonce[msg.sender]++;
        emit BoxCreated(_boxId, msg.sender);
    }

    function stakeTo(bytes32 _boxId, uint256 _amount) external returns (bool) {
        Box memory box = _box[_boxId];
        require(box.creator != address(0), "StakeTo/Box does not exist");
        require(!box.destroyed, "StakeTo/Box is destroyed");
        return _stakeTo(_boxId, _amount);
    }

    function unstakeFrom(bytes32 _boxId, uint256 _amount) external returns (bool) {
        Box memory box = _box[_boxId];
        require(box.creator != address(0), "UnstakeFrom/Box does not exist");
        require(!box.destroyed, "UnstakeFrom/Box is destroyed");
        return _unstake(_boxId, _amount);
    }

    function destroyBox(bytes32 _boxId) external returns (bool) {
        Box storage box = _box[_boxId];
        require(box.creator == msg.sender, "Destroy/Only creator can destroy box");
        require(box.balance == 0, "Destroy/Cannot destroy when box has balance");
        box.destroyed = true;
        emit BoxDestroyed(_boxId);
        return true;
    }

    function stake(uint256 _amount) external returns (bool) {
        return _stakeTo(bytes32(0), _amount);
    }

    function unstake(uint256 _amount) external returns (bool) {
        return _unstake(bytes32(0), _amount);
    }

    function boxId(address _creator, uint256 _salt) external view returns (bytes32) {
        return keccak256(abi.encodePacked(_creator, _salt));
    }

    function stakeAmount(bytes32 _boxId, address _staker) external view returns (uint256) {
        return _stake[_boxId][_staker];
    }

    function boxInfo(bytes32 _boxId) external view returns (address creator, uint256 createdAt, uint256 balance, bool destroyed) {
        Box memory box = _box[_boxId];
        creator = box.creator;
        createdAt = box.createdAt;
        balance = box.balance;
        destroyed = box.destroyed;
    }

    function _stakeTo(bytes32 _boxId, uint256 _amount) internal returns (bool) {
        Box storage box = _box[_boxId];
        box.balance = box.balance + _amount;
        _stake[_boxId][msg.sender] = _stake[_boxId][msg.sender] + _amount;
        _token.transferFrom(msg.sender, address(this), _amount);
        emit Stake(_boxId, msg.sender, _amount);
        return true;
    }

    function _unstake(bytes32 _boxId, uint256 _amount) internal returns (bool) {
        require(_amount <= _stake[_boxId][msg.sender], "Unstake/Can't unstake more than stake amount");
        Box storage box = _box[_boxId];
        box.balance = box.balance - _amount;
        _stake[_boxId][msg.sender] = _stake[_boxId][msg.sender] - _amount;
        _token.transfer(msg.sender, _amount);
        emit Unstake(_boxId, msg.sender, _amount);
    }
}
