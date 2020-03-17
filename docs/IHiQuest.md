# <span id="IHiQuest"></span> IHiQuest
> 





## Contents


- [Events](#IHiQuest--Events)


  - [HiquestCreated](#IHiQuest--event--HiquestCreated)


  - [HiquestManagerChanged](#IHiQuest--event--HiquestManagerChanged)


  - [UserJoined](#IHiQuest--event--UserJoined)


  - [Rewarded](#IHiQuest--event--Rewarded)


  - [HiquestClosed](#IHiQuest--event--HiquestClosed)


  - [WithDrawn](#IHiQuest--event--WithDrawn)



- [Functions](#IHiQuest--Functions)


  - [create(bytes32,uint256,uint256,uint256)](#IHiQuest--function--create(bytes32,uint256,uint256,uint256))


  - [join(bytes32,bytes)](#IHiQuest--function--join(bytes32,bytes))


  - [changeManager(bytes32,address)](#IHiQuest--function--changeManager(bytes32,address))


  - [reward(bytes32,address,uint256)](#IHiQuest--function--reward(bytes32,address,uint256))


  - [close(bytes32)](#IHiQuest--function--close(bytes32))


  - [withdrawDeposit(bytes32)](#IHiQuest--function--withdrawDeposit(bytes32))


  - [questInfo(bytes32)](#IHiQuest--function--questInfo(bytes32))


  - [managingQuests(address)](#IHiQuest--function--managingQuests(address))


  - [joinedUsers(bytes32)](#IHiQuest--function--joinedUsers(bytes32))



## 🦄Events <a name="IHiQuest--Events"></a>


<details><summary><strong>HiquestCreated <a name="IHiQuest--event--HiquestCreated"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| manager | `false` | `address` |
| open | `false` | `uint256` |
| close | `false` | `uint256` |
| deposit | `false` | `uint256` |

</p>

</details>


<details><summary><strong>HiquestManagerChanged <a name="IHiQuest--event--HiquestManagerChanged"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| manager | `false` | `address` |

</p>

</details>


<details><summary><strong>UserJoined <a name="IHiQuest--event--UserJoined"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| user | `false` | `address` |
| desc | `false` | `bytes` |

</p>

</details>


<details><summary><strong>Rewarded <a name="IHiQuest--event--Rewarded"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| to | `false` | `address` |
| amount | `false` | `uint256` |

</p>

</details>


<details><summary><strong>HiquestClosed <a name="IHiQuest--event--HiquestClosed"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |

</p>

</details>


<details><summary><strong>WithDrawn <a name="IHiQuest--event--WithDrawn"></a></strong></summary>
<p>

| Name | Indexed | Type |
|:-:|:-:|:-:|
| questId | `false` | `bytes32` |
| amount | `false` | `uint256` |

</p>

</details>



## 🚀Functions <a name="IHiQuest--Functions"></a>
<dl>
<dt> <h3> create(bytes32,uint256,uint256,uint256) <a name="IHiQuest--function--create(bytes32,uint256,uint256,uint256)"></a> </h3> </dt>
<dd>

>create `_questId` quest from `_open` to `_close` and deposits `_deposit`amount of HiBlocks ERC20 token

🔨`should have approved this contract to use `_deposit` amount of HiBlocks token` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | quest id to create |
| _open | `uint256` | time when quest will start (unix timestamp) |
| _close | `uint256` | time whent quest will end (unix timestamp) |
| _deposit | `uint256` | amount to deposit for quest |


#### → Returns

| Name | Type |
|:-:|:-:|
|  success  | `bool` |

success : return true if succeeded

</dd>
<dt> <h3> join(bytes32,bytes) <a name="IHiQuest--function--join(bytes32,bytes)"></a> </h3> </dt>
<dd>

>joins `_questId` with given `_desc` message

 👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | quest id to join |
| _desc | `bytes` | description of joining |


#### → Returns

| Name | Type |
|:-:|:-:|
|  success  | `bool` |

success : return true if succeeded

</dd>
<dt> <h3> changeManager(bytes32,address) <a name="IHiQuest--function--changeManager(bytes32,address)"></a> </h3> </dt>
<dd>

>change manager of `_questId` to `_manager`

🔨`onlyManager` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | quest id to change manager |
| _manager | `address` | address of new manager |


#### → Returns

| Name | Type |
|:-:|:-:|
|  success  | `bool` |

success : return true if succeeded

</dd>
<dt> <h3> reward(bytes32,address,uint256) <a name="IHiQuest--function--reward(bytes32,address,uint256)"></a> </h3> </dt>
<dd>

>rewards `_amount` of HiBlocks token to `_to` for joining `_questId` quest 

🔨`onlyManager` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | quest id to give reward |
| _to | `address` | beneficiary of reward |
| _amount | `uint256` | amount of reward |


#### → Returns

| Name | Type |
|:-:|:-:|
|  success  | `bool` |

success : return true if succeeded

</dd>
<dt> <h3> close(bytes32) <a name="IHiQuest--function--close(bytes32)"></a> </h3> </dt>
<dd>

>close `_questId` quest 

🔨`onlyManager` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | quest id to close |


#### → Returns

| Name | Type |
|:-:|:-:|
|  success  | `bool` |

success : return true if succeeded

</dd>
<dt> <h3> withdrawDeposit(bytes32) <a name="IHiQuest--function--withdrawDeposit(bytes32)"></a> </h3> </dt>
<dd>

>withdraws leftover HiBlocks token from `_questId` quest and sends to manager

🔨`onlyManager` |  👀 `nonpayable`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | quest id to withdraw from |


#### → Returns

| Name | Type |
|:-:|:-:|
|  success  | `bool` |

success : return true if succeeded

</dd>
<dt> <h3> questInfo(bytes32) <a name="IHiQuest--function--questInfo(bytes32)"></a> </h3> </dt>
<dd>

>view function to get data of quest

 👀 `view`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | id of quest to query |


#### → Returns

| Name | Type |
|:-:|:-:|
|  manager  | `address` |
|  open  | `uint256` |
|  end  | `uint256` |
|  deposit  | `uint256` |
|  balance  | `uint256` |
|  closed  | `bool` |



</dd>
<dt> <h3> managingQuests(address) <a name="IHiQuest--function--managingQuests(address)"></a> </h3> </dt>
<dd>

>view function to get managing questIds

 👀 `view`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _manager | `address` | address of manager to query |


#### → Returns

| Name | Type |
|:-:|:-:|
|  quests  | `bytes32[]` |



</dd>
<dt> <h3> joinedUsers(bytes32) <a name="IHiQuest--function--joinedUsers(bytes32)"></a> </h3> </dt>
<dd>

>view function to get joined users

 👀 `view`

#### ⚙️ Parameters

| Name | Type | Description |
|:-:|:-:| - |
| _questId | `bytes32` | id of quest to query |


#### → Returns

| Name | Type |
|:-:|:-:|
|  users  | `address[]` |



</dd>
</dl>
