pragma solidity ^0.5.6;

contract HispaceActivity {

  struct UserActivity {
    bytes32 activityType;
    address targetAddress;
    bytes desc;
    uint256 datetime;
  }

  mapping(address => UserActivity[]) private activityHistory;

  event activity(bytes32 activityType, address who, bytes desc, uint256 datetime);

  /**
  * @dev 활동기록
  * @param activityType bytes32
  * @param desc bytes
  */
  function saveActivity(bytes32 activityType, bytes memory desc) public returns (bool) {
    require(desc.length <= 3000,"desc is too long");
    uint256 currentTime = now;
    activityHistory[msg.sender].push(UserActivity(activityType, msg.sender, desc, currentTime));
    emit activity(activityType, msg.sender, desc, currentTime);
    return true;
  }

  /**
  * @dev 활동기록 - 좋아요
  * @param activityType bytes32
  * @param to address
  * @param desc bytes
  */
  function saveActivityTo(bytes32 activityType, address to, bytes memory desc) public returns (bool) {
    require(desc.length <= 3000,"desc is too long");
    uint256 currentTime = now;
    activityHistory[msg.sender].push(UserActivity(activityType, to, desc, currentTime));
    activityHistory[to].push(UserActivity(activityType, msg.sender, desc, currentTime));
    emit activity(activityType, msg.sender, desc, currentTime);
    return true;
  }

  /**
  * @dev 활동기록 조회
  * @param who address
  * @param idx uint256
  */
  function historyOf(address who, uint256 idx) public view returns (bytes32 activityType, address targetAddress, bytes memory desc, uint256 datetime) {
    require(activityHistory[who].length > idx, "out of range");

    activityType = activityHistory[who][idx].activityType;
    targetAddress = activityHistory[who][idx].targetAddress;
    desc = activityHistory[who][idx].desc;
    datetime = activityHistory[who][idx].datetime;
  }

  /**
  * @dev 활동기록 개수 조회
  * @param who address
  */
  function historySizeOf(address who) public view returns (uint256) {
    return activityHistory[who].length;
  }
}