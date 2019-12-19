pragma solidity ^0.5.6;

import "./token/HiblocksIERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/upgrades/contracts/Initializable.sol";

contract HiQuest {
    using SafeMath for uint256;
    bool private initialized;

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

    mapping(address => bytes[]) internal questIds;

    struct Hiquest {
        address manager;
        uint256 openDate;
        uint256 closeDate;
        uint256 deposit;
        uint256 balance;
        bool isClosed;
    }

    mapping(bytes => Hiquest) public hiquest;

    /**
    * @dev initialize instead of constructor
    * @param tokenAddr address of hiblocks tokens
    */
    function initialize(address tokenAddr) public {
        require(!initialized, "initialization has already been executed.");
        initialized = true;
        _token = HiblocksIERC20(tokenAddr);
    }

    /**
     * 하이퀘스트 등록
     */
    function createHiquest(bytes memory questId, uint256 openDate, uint256 closeDate, uint256 deposit) public returns (bool) {
        require(questId.length > 0, 'questId could not be empty');
        require(openDate < closeDate, "invalid date");
        require(deposit > 0, "deposit could not be zero");
        require(_token.transferFrom(msg.sender, address(this), deposit), "Token transfer failed");

        hiquest[questId] = Hiquest(msg.sender, openDate, closeDate, deposit, deposit, false);
        questIds[msg.sender].push(questId);
    }

    /**
     * 퀘스트 예치금 및 잔액 확인
     */
    function balanceOfQuest(bytes memory questId) public view returns (uint256 deposit, uint256 balance) {
        require(questId.length > 0, 'questId could not be empty');
        deposit = hiquest[questId].deposit;
        balance = hiquest[questId].balance;
    }

    /**
     * 퀘스트 정보 확인
     */
    function hiquestInfo(bytes memory questId) public view returns (address manager, uint256 openDate, uint256 closeDate, uint256 deposit, uint256 balance) {
        require(questId.length > 0, 'questId could not be empty');
        manager = hiquest[questId].manager;
        openDate = hiquest[questId].openDate;
        closeDate = hiquest[questId].closeDate;
        deposit = hiquest[questId].deposit;
        balance = hiquest[questId].balance;
    }

    /**
     * 퀘스트 기간 연장
     */
    function extendDate(bytes memory questId, uint256 extSecond) public returns (uint256 closeDate) {
        require(questId.length > 0, 'questId could not be empty');
        require(extSecond > 0, "extSecond could not be zero");

        hiquest[questId].closeDate = hiquest[questId].closeDate.add(extSecond);
        closeDate = hiquest[questId].closeDate;
    }

    /**
     * 잔여 예치금 인출(관리자) => 담당자에게 반환
     */
    function withdrawDeposit(bytes memory questId) public onlyWhitelistAdmin returns (uint256 balance) {
        require(questId.length > 0, 'questId could not be empty');
        require(hiquest[questId].manager != address(0), 'hiquest is not created');

        balance = hiquest[questId].balance;
        require(_token.transfer(hiquest[questId].manager, balance), "transfer failed");

    }

    /**
     * 하이퀘스트 완료처리 (보상완료)
     */
    function closedHiquest(bytes memory questId) public returns (bool) {
        require(questId.length > 0, 'questId could not be empty');
        require(hiquest[questId].manager != address(0), 'hiquest is not created');
        require(hiquest[questId].isClosed != true, 'hiquest is already closed');

        hiquest[questId].isClosed = true;
        return true;
    }

}