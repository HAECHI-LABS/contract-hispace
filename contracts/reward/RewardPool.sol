pragma solidity ^0.5.6;

import "../token/HiBlocksTokenFlattened.sol";

contract RewardPool {
    using SafeMath for uint256;
    /**
    * @dev ERC20 Token under lockable functionality
    */
    HiblocksToken private _token;

    // rewardToken[address][week] = rewardToken
    mapping(address => mapping(uint8 => uint256)) public rewardToken;

    /**
     * @dev Check for administrator privileges.
     */
    modifier onlyWhitelistAdmin() {
        require(_token.isWhitelistAdmin(msg.sender), "WhitelistAdminRole: caller does not have the WhitelistAdmin role");
        _;
    }

    /**
    * @dev constructor of network reward pool
    * @param tokenAddr address of hiblocks tokens
    */
    constructor(address tokenAddr) public {
        _token = HiblocksToken(tokenAddr);
    }

    /**
    * @return the token being held.
    */
    function token() external view returns (HiblocksToken) {
        return _token;
    }

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function rewardBalance() public view returns (uint256) {
        return _token.balanceOf(address(this));
    }

    /**
     * @dev rewarded token for a specified address and reward week of 10 years
     * @param recipient The address of reward to.
     * @param week reward week of 10 years.
     */
    function rewardOf(address recipient, uint8 week) external view returns (uint256) {
        return rewardToken[recipient][week];
    }

    /**
     * @dev Moves `amount` tokens from this contract's account to `recipient` with memo.
     * @param recipient The address to transfer to.
     * @param amount The amount to be transferred.
     * @param week reward week of 10 years.
     * @param memo The memo to be saved.
     */
    function payReward(address recipient, uint256 amount, uint8 week, bytes calldata memo) external onlyWhitelistAdmin returns (bool) {
        require(rewardBalance() >= amount, "transfer amount exceeds balance");
        require(_token.transfer(recipient, amount), "Failed tranfer.");
        rewardToken[recipient][week] = rewardToken[recipient][week].add(amount);
        return true;
    }
}
