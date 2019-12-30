pragma solidity ^0.5.6;

import "./token/HiblocksIERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/upgrades/contracts/Initializable.sol";

contract Hunter is Initializable {
    using SafeMath for uint256;

    /**
    * @dev ERC20 Token under lockable functionality
    */
    HiblocksIERC20 private _token;

    /**
     * @dev Check for administrator privileges.
     */
    modifier onlyWhitelistAdmin() {
        require(_token.isWhitelistAdmin(msg.sender), "WhitelistAdminRole: caller does not have the WhitelistAdmin role");
        _;
    }

    /**
    * @dev initialize instead of constructor
    * @param tokenAddr address of hiblocks tokens
    */
    function initialize(address tokenAddr) initializer public {
        _token = HiblocksIERC20(tokenAddr);
    }

    /**
    헌터 등록
    헌터 삭제
    신고
    
     */

}