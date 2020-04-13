pragma solidity ^0.5.6;

import "../token/HiblocksIERC20.sol";

contract HiblocksMock is HiblocksIERC20 {
  uint256 internal _totalSupply;
  uint8 internal _decimals;
  mapping (address => uint256 ) internal _balances;
  mapping (address => mapping(address=>uint256)) internal _allowance;
  constructor() public {
    _totalSupply = 1000e18;
    _decimals = 18;
    _balances[msg.sender] = _totalSupply;
  }

  function totalSupply() external view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address _account) external view returns(uint256) {
    return _balances[_account];
  }

  function allowance(address _account, address _spender) external view returns(uint256) {
    return _allowance[_account][_spender];
  }

  function transfer(address _to, uint256 _amount) external returns(bool) {
    require(_balances[msg.sender] >= _amount);
    _balances[msg.sender] = _balances[msg.sender] - _amount;
    _balances[_to] = _balances[_to] + _amount;
    return true;
  }

  function approve(address _spender, uint256 _amount) external returns(bool) {
    _allowance[msg.sender][_spender] = _amount;
    return true;
  }

  function transferFrom(address _account, address _to, uint256 _amount) external returns (bool) {
    require(_allowance[_account][msg.sender] >= _amount);
    require(_balances[_account] >= _amount);
    _allowance[_account][msg.sender] = _allowance[_account][msg.sender] - _amount;
    _balances[_account] = _balances[_account] - _amount;
    _balances[_to] = _balances[_to] + _amount;
    return true;
  }

  function totalBalanceOf(address _addr) external view returns (uint256 amount, uint256 token, uint256 locked, uint256 staked) {
    amount = 1;
    token = 2;
    locked = 3;
    staked = 4;
  }

  function isWhitelistAdmin(address _sender) external view returns(bool) {
      return true;
  }
}
