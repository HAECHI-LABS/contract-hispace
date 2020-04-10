pragma solidity ^0.5.6;

import "./token/HiblocksIERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract RewardSupplier {
    using SafeMath for uint256;
    /**
    * @dev ERC20 Token under lockable functionality
    */
    HiblocksIERC20 private _token;

    /**
    * @dev constant of reward
    */
    struct RewardConst {
        uint256 totalClaimed; // all claimed reward
        uint256 totalReward; // total reward for hiblocks platform
        uint256 releaseTime; // timestamp when token release is enabled
        address beneficiary; // beneficiary of tokens after they are unlocked
        uint256 factor; // factor value for calculate reward
    }

    /**
    * @dev claimed token structure
    */
    struct ClaimedToken {
        uint256 amount;
        uint256 week;
        uint256 released;
    }

    RewardConst private _const;
    uint256 private _secondsOfWeek;
    uint256 private _secondsOfTenYears;
    uint256 private _decimalLength;

    /**
    * @dev record the reward tokens sent
    */
    ClaimedToken[] private _claimedTokens;

    event RewardLocked(address beneficiary, uint256 releaseTime);
    event TokenWithdraw(address tokenAddr, address indexed sendTo, uint256 amount);

    /**
     * @dev Check for administrator privileges.
     */
    modifier onlyWhitelistAdmin() {
        require(_token.isWhitelistAdmin(msg.sender), "WhitelistAdminRole: caller does not have the WhitelistAdmin role");
        _;
    }

    /**
    * @dev constructor to lockable initial tokens
    * @param tokenAddr address of hiblocks tokens
    * @param beneficiary address of beneficiary
    * @param releaseTime start time of release
    */
    constructor(address tokenAddr, address beneficiary, uint256 totalReward, uint256 releaseTime) public {
        _token = HiblocksIERC20(tokenAddr);
        _secondsOfWeek = 60 * 60 * 24 * 7;
        _secondsOfTenYears = 60 * 60 * 24 * 365 * 10;
        _decimalLength = 10 ** 18;

        _const = RewardConst(uint256(0), totalReward, releaseTime, beneficiary, _factor());

        emit RewardLocked(beneficiary, releaseTime);
    }

    /**
    * @return factor value for calculate increased reward
    */
    function _factor() internal pure returns (uint256 factor) {
        // uint256 x1 = 1; // first week
        // uint256 y1 = 3000000; // reward tokens for first week
        // uint256 x2 = 52 * 2; // last week of 2 years
        // uint256 y2 = 16800000; // reward tokens for last week

        // factor = (y2.sub(y1)).div((x2.sub(x1)).mul((x2.sub(x1))));
        factor = 1300;
    }

    /**
    * @return the token being held.
    */
    function token() external view returns (HiblocksIERC20) {
        return _token;
    }

    /**
    * @return the releaseTime of the tokens.
    */
    function releaseTime() external view returns (uint256) {
        return _const.releaseTime;
    }

    /**
    * @return the beneficiary of the tokens.
    */
    function beneficiary() external view returns (address) {
        return _const.beneficiary;
    }

    /**
    * @return total reward for hiblocks platform
    */
    function totalReward() external view returns (uint256) {
        return (_const.totalReward.mul(10**18));
    }

    /**
    * @return remain reward for hiblocks platform
    */
    function remainReward() public view returns (uint256) {
        return _token.balanceOf(address(this));
    }

    /**
    * @return the time when all reward tokens are released.
    */
    function endTime() public view returns (uint256) {
        return _const.releaseTime.add(_secondsOfTenYears);  // end time of reward distribution;
    }

    /**
    * @dev Returns unlockable tokens for a specified address for a specified reason
    * @param week query the unlockable token count of week
    */
    function tokensUnlockableUntil(uint256 week)
        public view
        returns (uint256)
    {
        uint256 i = _claimedTokens.length == 0 ? 0 : _claimedTokens[_claimedTokens.length-1].week + 1;
        uint256 total = 0;
        for ( i ; i <= week; i++) {
            total = total.add(tokensUnlockableAt(i));
        }
        return total;
    }

    /**
    * @dev Unlockable tokens at given week
    * @param week query the unlockable token count of week
    */
    function tokensUnlockableAt(uint256 week)
        public view
        returns (uint256)
    {
        if(week < 104) {
            return (_const.factor.mul((week) ** 2).add(3000000)).mul(_decimalLength);
        } else if(week < 520) {
            uint256 reward = remainReward().div(_decimalLength);
            return reward.div(521 - week).mul(_decimalLength);
        }
        return remainReward();
    }

    /**
    * @dev current week of the 10 years
    */
    function thisWeek() public view returns (uint256){
        require(_const.releaseTime < now, "not a release period."); //solium-disable-line
        return now.sub(_const.releaseTime).div(_secondsOfWeek); //solium-disable-line
    }

    function unlockReward() external returns (bool) {
        require(_const.releaseTime < now, "not a release period."); //solium-disable-line
        require(remainReward() > 0, "Insufficient balance");

        uint256 week = thisWeek();
        require(_claimedTokens.length == 0 || _claimedTokens[_claimedTokens.length-1].week < week, "token already claimed.");

        uint256 reward = tokensUnlockableUntil(week);
        if(reward > 0){
            _token.transfer(_const.beneficiary, reward);
            _const.totalClaimed.add(reward);
            _claimedTokens.push(ClaimedToken(reward, week, now)); //solium-disable-line

            emit TokenWithdraw(address(_token), _const.beneficiary, reward);
        }
        return true;

    }

    /**
    * @dev Change new beneficiary
    * @param newBeneficiary address of new beneficiary
    */
    function setBeneficiary(address newBeneficiary) external onlyWhitelistAdmin returns (bool) {
        _const.beneficiary = newBeneficiary;
        emit RewardLocked(newBeneficiary, _const.releaseTime);
        return true;
    }

    /**
    * @dev extend release time.
    * @param extendTime seconds to add
    */
    function extendReleaseTime(uint256 extendTime) external onlyWhitelistAdmin returns (bool) {
        require(_const.releaseTime > now, "release time is in past"); //solium-disable-line

        _const.releaseTime = _const.releaseTime.add(extendTime);
        emit RewardLocked(_const.beneficiary, _const.releaseTime);
        return true;
    }

    /**
    * @dev withdrawal the remain balance after the compensation period ends.
    */
    function withdrawalRemain() external onlyWhitelistAdmin returns (bool) {
        require(endTime() < now, "Reward period is left."); //solium-disable-line
        require(remainReward() > 0, "Insufficient balance");

        _token.transfer(_const.beneficiary, remainReward());
        emit TokenWithdraw(address(_token), _const.beneficiary, remainReward());
        return true;
    }
}
