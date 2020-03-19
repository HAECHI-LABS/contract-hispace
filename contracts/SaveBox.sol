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
    mapping(bytes32 => mapping(address=>uint256) _stake;

    constructor(address _tokenAddr) public {
        _token = HiblocksIERC20(_tokenAddr);
    }

    function createBox() external returns (bytes32 _boxId) {
        _boxId = keccak256(abi.encodePacked(msg.sender, _nonce[msg.sender]));
        Box storage box = _box[_boxId];
        box.creator = msg.sender;
        box.createdAt = now;
        emit BoxCreated(_boxId, msg.sender);
    }

    function stakeTo(bytes32 _boxId, uint256 _amount) external returns (bool) {
        Box storage box = _box[_boxId];
        require(box.creator != address(0), "StakeTo/Box does not exist");
        box.balance = box.balance + _amount;
        _stake[_boxId][msg.sender] = _stake[_boxId][msg.sender] + _amount;
        _token.transferFrom(msg.sender, address(this), _amount);
        emit Stake(_boxId, msg.sender, _amount);
        return true;
    }

    function unstakeFrom(bytes32 _boxId) external returns (bool) {
        Box storage box = _box[_boxId];
        require(box.creator != address(0), "UnstakeFrom/Box does not exist");
        uint256 amount = _stake[_boxId][msg.sender];
        box.balance = box.balance - amount;
        _token.transfer(msg.sender, amount);
        emit Ustake(_boxId, msg.sender, amount);
        return true;
    }
}
